Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267128AbTA0ODL>; Mon, 27 Jan 2003 09:03:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267129AbTA0ODL>; Mon, 27 Jan 2003 09:03:11 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:62698 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S267128AbTA0ODK>; Mon, 27 Jan 2003 09:03:10 -0500
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15925.15947.576552.209252@laputa.namesys.com>
Date: Mon, 27 Jan 2003 17:12:27 +0300
X-PGP-Fingerprint: 43CE 9384 5A1D CD75 5087  A876 A1AA 84D0 CCAA AC92
X-PGP-Key-ID: CCAAAC92
X-PGP-Key-At: http://wwwkeys.pgp.net:11371/pks/lookup?op=get&search=0xCCAAAC92
To: Linux Kernel Mailing List <Linux-Kernel@Vger.Kernel.ORG>
Cc: Andrew Morton <AKPM@Digeo.COM>, Alexander Viro <viro@math.psu.edu>
Subject: possible deadlock in sys_pivot_root()?
X-Mailer: VM 7.07 under 21.5  (beta9) "brussels sprouts" XEmacs Lucid
X-NSA-Fodder: Ortega Area 51 Janet Reno Semtex quiche AK-47 constitution
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

sys_pivot_root() first takes BKL, then ->i_sem on the old root
directory. On the other hand, vfs_readdir() first takes ->i_sem on a
directory and then calls file system ->readdir() method, that usually
takes BKL. Isn't there a deadlock possibility? Of course,
sys_pivot_root() is probably not supposed to be called frequently, but
still.

Nikita.

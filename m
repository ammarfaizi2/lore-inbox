Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262750AbSITOzM>; Fri, 20 Sep 2002 10:55:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262758AbSITOzM>; Fri, 20 Sep 2002 10:55:12 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:56584 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S262750AbSITOzL>; Fri, 20 Sep 2002 10:55:11 -0400
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15755.14336.739277.700462@laputa.namesys.com>
Date: Fri, 20 Sep 2002 19:00:16 +0400
X-PGP-Fingerprint: 43CE 9384 5A1D CD75 5087  A876 A1AA 84D0 CCAA AC92
X-PGP-Key-ID: CCAAAC92
X-PGP-Key-At: http://wwwkeys.pgp.net:11371/pks/lookup?op=get&search=0xCCAAAC92
To: Linux Kernel Mailing List <Linux-Kernel@Vger.Kernel.ORG>
Cc: Alexander Viro <viro@math.psu.edu>, Andrew Morton <AKPM@Digeo.COM>
Subject: locking rules for ->dirty_inode()
X-Mailer: VM 7.07 under 21.5  (beta6) "bok choi" XEmacs Lucid
X-Meat: Turkey Jerky
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Documentation/filesystems/Locking states that all super operations may
block, but __set_page_dirty_buffers() calls

   __mark_inode_dirty()->s_op->dirty_inode()

under mapping->private_lock spin lock. This seems strange, because file
systems' ->dirty_inode() assume that they are allowed to block. For
example, ext3_dirty_inode() allocates memory in

   ext3_journal_start()->journal_start()->new_handle()->...

Nikita.


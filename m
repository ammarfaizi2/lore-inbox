Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266081AbTBTQuH>; Thu, 20 Feb 2003 11:50:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266069AbTBTQuG>; Thu, 20 Feb 2003 11:50:06 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:53167 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S266081AbTBTQuA>; Thu, 20 Feb 2003 11:50:00 -0500
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15957.2449.56807.954319@laputa.namesys.com>
Date: Thu, 20 Feb 2003 20:00:01 +0300
X-PGP-Fingerprint: 43CE 9384 5A1D CD75 5087  A876 A1AA 84D0 CCAA AC92
X-PGP-Key-ID: CCAAAC92
X-PGP-Key-At: http://wwwkeys.pgp.net:11371/pks/lookup?op=get&search=0xCCAAAC92
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
       Alex Larsson <alexl@redhat.com>, <procps-list@redhat.com>
Subject: Re: [patch] procfs/procps threading performance speedup, 2.5.62
In-Reply-To: <Pine.LNX.4.44.0302201656030.30000-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0302201656030.30000-100000@localhost.localdomain>
X-Mailer: VM 7.07 under 21.5  (beta9) "brussels sprouts" XEmacs Lucid
X-Windows: the joke that kills.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar writes:
 > 

[...]

 > 
 > to fix this overhead i've introduced a 'lookup cursor' cookie, which is
 > cached in filp->private_data, across readdir() [getdents64()] calls. If
 > the cursor matches then we skip all the overhead of skipping threads. If
 > the cursor is not available then we fall back to the old-style skipping
 > algorithm.

Shouldn't filp->private_data be cleared on lseek? It looks like lookup
cursor is never cleared once set and so readdir will always go forward
independently of ->f_pos updates. Note that glibc implementation of
readdir() (on the top of getdents64()) does call lseek on the
directory. So does seekdir(3).

 > 
 > 2) procps is forced to parse every thread in /proc to build up accurate
 >    'process CPU usage' counters. The parsing and accessing of every

Nikita.

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265922AbUA0Uxw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 15:53:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265924AbUA0Uxw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 15:53:52 -0500
Received: from sputnik.senv.net ([213.157.66.5]:1028 "EHLO sputnik.senv.net")
	by vger.kernel.org with ESMTP id S265922AbUA0Uxs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 15:53:48 -0500
Date: Tue, 27 Jan 2004 22:53:46 +0200 (EET)
From: Jussi Hamalainen <count@theblah.fi>
X-X-Sender: count@mir.senv.net
To: linux-kernel@vger.kernel.org
Subject: NFS: giant filename in readdir
Message-ID: <Pine.LNX.4.58.0401272233490.10626@mir.senv.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm getting these errors after about 15d of uptime:

Jan 27 17:43:18 mir kernel: NFS: giant filename in readdir (len 955ae5)!
Jan 27 21:06:14 mir kernel: NFS: giant filename in readdir (len 74000000)!

And doing an ls (ie. readdir()) inside an NFS-mount always produces
an empty directory listing. I can still access files and
subdirectories OK, though.

This seems to be a problem on the client side and only occurs when
using NFSv3. When I unmount and then remount using NFSv3, the problem
persists, but goes away once I remount with nfsvers=2. Also I tried
downgrading the other server's kernel to 2.4.21 and the problem still
persisted until I remounted with NFSv2.

I'll wait and see wether the downgrade helped on the client side, but
that might take a few days.

Both boxes have an almost identical setup of Slackware 9.1 and were
running 2.4.23-pac1+security bugfixes. The boxes are connected to the
same switch and VLAN. They mount filesystems from each other (yeah, I
know cross-mounting with NFS is a bad idea...) and the problem
occurred on both servers simultaineously.

The mounts look like this:

mir:/home on /home type nfs
(rw,rsize=8192,wsize=8192,hard,intr,lock,addr=XXX)
mir:/archive on /archive type nfs
(rw,rsize=8192,wsize=8192,soft,intr,addr=XXX)

sputnik:/var/spool/mail on /var/spool/mail type nfs
(rw,rsize=8192,wsize=8192,hard,intr,lock,nfsvers=2,addr=XXX)
sputnik:/files on /files type nfs
(rw,rsize=8192,wsize=8192,soft,intr,nfsvers=2,addr=XXX)

I tried searching with Google but couldn't find a resolution to this
problem. I did find references of it occurring as far back as 2002.
Any ideas, folks?

-- 
-=[ Count Zero / TBH - Jussi Hämäläinen - email count@theblah.fi ]=-

Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315278AbSFDR3C>; Tue, 4 Jun 2002 13:29:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315282AbSFDR3C>; Tue, 4 Jun 2002 13:29:02 -0400
Received: from pat.uio.no ([129.240.130.16]:38329 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S315278AbSFDR3A>;
	Tue, 4 Jun 2002 13:29:00 -0400
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Organization: Dept. of Physics, University of Oslo, Norway
To: Matthias Welk <welk@fokus.gmd.de>
Subject: Re: nfs slowdown since 2.5.4
Date: Tue, 4 Jun 2002 19:28:54 +0200
User-Agent: KMail/1.4.1
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200206041253.44446.welk@fokus.gmd.de> <200206041848.38954.trond.myklebust@fys.uio.no> <200206041916.29725.welk@fokus.gmd.de>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_68Z6NV61QKQCGJ5S6JGY"
Message-Id: <200206041928.54392.trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_68Z6NV61QKQCGJ5S6JGY
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

On Tuesday 04 June 2002 19:16, Matthias Welk wrote:
> On Tuesday 04 June 2002 18:48, Trond Myklebust wrote:
> > On Tuesday 04 June 2002 17:56, Matthias Welk wrote:
> > > To get more info about this problem I compared the compile time and the
> > > nfs traffic between 2.4.18-4 and 2.5.20 on a RedHat 7.3 system.
> > > The sources (mosfet-liquid0.9.5.tar.gz - KDE style) were located on the
> > > local disc and the libraries were linked over nfs.
> > > The results attached to this mail show the big difference !

Does the appended patch make a difference?

Cheers,
  Trond


--------------Boundary-00=_68Z6NV61QKQCGJ5S6JGY
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="gnurr.dif"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="gnurr.dif"

--- linux-2.5.20/fs/nfs/dir.c.orig	Mon Jun  3 03:44:49 2002
+++ linux-2.5.20/fs/nfs/dir.c	Tue Jun  4 19:24:21 2002
@@ -519,7 +519,6 @@
 	dput(parent);
 	return 1;
  out_bad:
-	NFS_CACHEINV(dir);
 	if (inode && S_ISDIR(inode->i_mode)) {
 		/* Purge readdir caches. */
 		nfs_zap_caches(inode);

--------------Boundary-00=_68Z6NV61QKQCGJ5S6JGY--

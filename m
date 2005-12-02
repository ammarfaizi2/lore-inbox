Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932733AbVLBLlj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932733AbVLBLlj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 06:41:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932736AbVLBLlj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 06:41:39 -0500
Received: from wine.ocn.ne.jp ([220.111.47.146]:17360 "EHLO
	smtp.wine.ocn.ne.jp") by vger.kernel.org with ESMTP id S932733AbVLBLlj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 06:41:39 -0500
To: rdunlap@xenotime.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: Wrong permission for kernel source tar ball !?
From: Tetsuo Handa <from-linux-kernel@i-love.sakura.ne.jp>
References: <200512020134.jB21YQpJ046558@www262.sakura.ne.jp>
	<Pine.LNX.4.58.0512011739280.10256@shark.he.net>
In-Reply-To: <Pine.LNX.4.58.0512011739280.10256@shark.he.net>
Message-Id: <200512022041.IIE67070.MOOPtMSFLFSGYJtVN@i-love.sakura.ne.jp>
X-Mailer: Winbiff [Version 2.43]
X-Accept-Language: ja,en
Date: Fri, 2 Dec 2005 20:41:28 +0900
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Randy.

> > "find -type f -perm 6" shows
> > extracted regular files are writable to everybody
> > for linux-2.6.14.tar.bz2 and later.
> Yes, you unzipped the tarball as root.  Don't do that.
> You should unzip & build kernels as a regular user
> and only become root to do install functions.
Yeah, I did it as root. But what is funny,
the result of "tar -jxf linux-2.6.14.tar.bz2" differ
if run as root or not. (I set umask 022 for both cases.)

What I worry is that something bad is happening
to the directory which is used for zipping.
I tried "tar -jtvf" and found that
linux-2.6.14.tar.bz2 has zipped files that are
world writable.

[demo@tomoyo ~]$ tar -jtvf /var/ftp/pub/linux-2.6.13.tar.bz2
tar: Record size = 8 blocks
drwxr-xr-x git/git           0 2005-08-29 08:41:01 linux-2.6.13/
-rw-r--r-- git/git       18691 2005-08-29 08:41:01 linux-2.6.13/COPYING
-rw-r--r-- git/git       89317 2005-08-29 08:41:01 linux-2.6.13/CREDITS
drwxr-xr-x git/git           0 2005-08-29 08:41:01 linux-2.6.13/Documentation/
-rw-r--r-- git/git       10244 2005-08-29 08:41:01 linux-2.6.13/Documentation/00-INDEX
-rw-r--r-- git/git        3699 2005-08-29 08:41:01 linux-2.6.13/Documentation/BUG-HUNTING
-rw-r--r-- git/git       13072 2005-08-29 08:41:01 linux-2.6.13/Documentation/Changes
-rw-r--r-- git/git       15351 2005-08-29 08:41:01 linux-2.6.13/Documentation/CodingStyle
-rw-r--r-- git/git       20407 2005-08-29 08:41:01 linux-2.6.13/Documentation/DMA-API.txt
-rw-r--r-- git/git       31996 2005-08-29 08:41:01 linux-2.6.13/Documentation/DMA-mapping.txt
[demo@tomoyo ~]$ tar -jtvf /var/ftp/pub/linux-2.6.14.tar.bz2
tar: Record size = 8 blocks
drwxr-xr-x git/git           0 2005-10-28 09:02:08 linux-2.6.14/
-rw-rw-rw- git/git         391 2005-10-28 09:02:08 linux-2.6.14/.gitignore
-rw-rw-rw- git/git       18693 2005-10-28 09:02:08 linux-2.6.14/COPYING
-rw-rw-rw- git/git       89223 2005-10-28 09:02:08 linux-2.6.14/CREDITS
drwxrwxrwx git/git           0 2005-10-28 09:02:08 linux-2.6.14/Documentation/
-rw-rw-rw- git/git       10330 2005-10-28 09:02:08 linux-2.6.14/Documentation/00-INDEX
-rw-rw-rw- git/git        3699 2005-10-28 09:02:08 linux-2.6.14/Documentation/BUG-HUNTING
-rw-rw-rw- git/git       13254 2005-10-28 09:02:08 linux-2.6.14/Documentation/Changes
-rw-rw-rw- git/git       16241 2005-10-28 09:02:08 linux-2.6.14/Documentation/CodingStyle
-rw-rw-rw- git/git       20403 2005-10-28 09:02:08 linux-2.6.14/Documentation/DMA-API.txt
-rw-rw-rw- git/git        5332 2005-10-28 09:02:08 linux-2.6.14/Documentation/DMA-ISA-LPC.txt
-rw-rw-rw- git/git       31996 2005-10-28 09:02:08 linux-2.6.14/Documentation/DMA-mapping.txt

I hope the person who zipped this file gave special commandline options.

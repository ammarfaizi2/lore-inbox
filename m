Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267476AbUIGAsI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267476AbUIGAsI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 20:48:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267478AbUIGAsI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 20:48:08 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:23936 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S267476AbUIGAsE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 20:48:04 -0400
Subject: Re: [NFS] Re: why do i get "Stale NFS file handle" for hours?
From: Greg Banks <gnb@melbourne.sgi.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Sven =?ISO-8859-1?Q?K=F6hler?= <skoehler@upb.de>,
       linux-kernel@vger.kernel.org,
       Linux NFS Mailing List <nfs@lists.sourceforge.net>
In-Reply-To: <1094353267.13791.156.camel@lade.trondhjem.org>
References: <chdp06$e56$1@sea.gmane.org>
	 <1094348385.13791.119.camel@lade.trondhjem.org>  <413A7119.2090709@upb.de>
	 <1094349744.13791.128.camel@lade.trondhjem.org>  <413A789C.9000501@upb.de>
	 <1094353267.13791.156.camel@lade.trondhjem.org>
Content-Type: text/plain
Organization: Silicon Graphics Inc, Australian Software Group.
Message-Id: <1094518532.20243.50.camel@hole.melbourne.sgi.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Tue, 07 Sep 2004 10:55:32 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-09-05 at 13:01, Trond Myklebust wrote:
> When your server fails to work as per spec, then it is said to be
> "broken" no matter what kernel/nfs-utils combination you are using.
> The spec is that reboots are not supposed to clobber filehandles.
> 
> So, there are 3 possibilities:
> 
>  1) You are exporting a non-supported filesystem, (e.g. FAT). See the
> FAQ on http://nfs.sourceforge.org.
>  2) A bug in your initscripts is causing the table of exports to be
> clobbered. Running "exportfs" in legacy 2.4 mode (without having the
> nfsd filesystem mounted on /proc/fs/nfsd) appears to be broken for me at
> least...
>  3) There is some other bug in knfsd that nobody else appears to be
> seeing.
> 

4) You're exporting a filesystem mounted on a block device whose
   device minor number is dynamic and has changed at the last reboot,
   e.g. loopback mounts or SCSI.
5) The mapping of minor numbers is stable but you physically re-arranged
   the disks or SCSI cards and changed /etc/fstab correspondingly.

Before you say any more, yes this is broken and fixing it properly is
Hard.  This is why have the fsid export option.

Greg.
-- 
Greg Banks, R&D Software Engineer, SGI Australian Software Group.
I don't speak for SGI.



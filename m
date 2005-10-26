Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964924AbVJZUQG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964924AbVJZUQG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 16:16:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964916AbVJZUQG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 16:16:06 -0400
Received: from ppsw-1.csi.cam.ac.uk ([131.111.8.131]:8873 "EHLO
	ppsw-1.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S964915AbVJZUQF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 16:16:05 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Wed, 26 Oct 2005 21:15:58 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Miklos Szeredi <miklos@szeredi.hu>
cc: bulb@ucw.cz, viro@ftp.linux.org.uk, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/8] VFS: per inode statfs (core)
In-Reply-To: <E1EUrb7-0001AU-00@dorka.pomaz.szeredi.hu>
Message-ID: <Pine.LNX.4.64.0510262114140.31781@hermes-1.csi.cam.ac.uk>
References: <E1EU5bT-0005sq-00@dorka.pomaz.szeredi.hu> <20051025042519.GJ7992@ftp.linux.org.uk>
 <E1EUHbq-0006t6-00@dorka.pomaz.szeredi.hu> <20051026173150.GB11769@efreet.light.src>
 <E1EUqm3-00013A-00@dorka.pomaz.szeredi.hu> <20051026195240.GB15046@efreet.light.src>
 <E1EUrb7-0001AU-00@dorka.pomaz.szeredi.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Oct 2005, Miklos Szeredi wrote:
> > > foo-filemanager: before copying a file or directory tree, checks for
> > > free space in destination directory
> > 
> > While most others simply don't care -- if it fails, it fails. Looking up the
> > free space beforehand is only a heurisitics anyway, as the free space can
> > change between the stat and the copy anyway.
> 
> Being a heuristic doesn't prevent it from being used.  And if you have
> one subfilesystem with zero free space, and one with lots, you _will_
> get burned if statfs() happens to report the zero space for every path
> within the mount.

Indeed.  ncpfs always returns 0 which for example breaks OpenOffice 
amongst many other applications when your home directory is on ncpfs.  We 
locally patch ncpfs to always return 2GiB free space which always makes 
things work.  (-:

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

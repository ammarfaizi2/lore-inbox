Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751062AbWG0ME1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751062AbWG0ME1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 08:04:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751158AbWG0ME1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 08:04:27 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:23619 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751062AbWG0ME1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 08:04:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=EtIOIe+zWbyqcdg7Js2+1Pib+Pkhovd+P64RBxi+LjxzQxldxShOQeB391Juf1f/BbM6ky1QF9wRuf/Fssz7PKGSWd5u2S5q8cGlXmtlnqYTc8lsx0xc/bWstYmebBzrPwJVfDxZRFbOM45OaLZR5p1q7De2m+ZI89LJ6IfZArU=
Date: Thu, 27 Jul 2006 16:04:25 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: ProfiHost - Stefan Priebe <s.priebe@profihost.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: XFS / Quota Bug in  2.6.17.x and 2.6.18x
Message-ID: <20060727120425.GB6825@martell.zuzino.mipt.ru>
References: <44C8A5F1.7060604@profihost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44C8A5F1.7060604@profihost.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2006 at 01:39:29PM +0200, ProfiHost - Stefan Priebe wrote:

Please regenerate patch with "diff -up" and sent it to
Nathan Scott <nathans@sgi.com>, CC'ing linux-fsdevel@vger.kernel.org,
xfs@oss.sgi.com

Also, read section 11 of Documentation/SubmittingPatches and if one of
clauses is applicable to you add appropriate "Signed-off-by" line.

> The crash only occurs if you use quota and IDE without barrier support.
> 
> The Problem is, that on a new mount of a root filesystem - the flag 
> VFS_RDONLY is set - and so no barrier check is done before checking 
> quota. With this patch barrier check is done always. The partition 
> should not be mounted at that moment. For mount -o remount, rw or 
> something like this it uses another function where VFS_RDONLY is checked.
> 
> Error Message:
> ns2 Wed Jul 26 14:22:58 2006 "I/O error in filesystem ("hda6") meta-data 
> dev
> hda6 block 0x23db5ab       ("xlog_iodone") error 5 buf count 1024"
> ns2 Wed Jul 26 14:22:58 2006 "xfs_force_shutdown(hda6,0x2) called from line
> 959 of file fs/xfs/xfs_log.c.  Return address = 0xc0211535"
> ns2 Wed Jul 26 14:22:58 2006 "Filesystem "hda6": Log I/O Error Detected.
> Shutting down filesystem: hda6"
> ns2 Wed Jul 26 14:22:58 2006 "Please umount the filesystem, and rectify the
> problem(s)"
> ns2 Wed Jul 26 14:22:58 2006 "xfs_force_shutdown(hda6,0x1) called from line
> 338 of file fs/xfs/xfs_rw.c.  Return address = 0xc0211535"
> ns2 Wed Jul 26 14:22:58 2006 "xfs_force_shutdown(hda6,0x1) called from line
> 338 of file fs/xfs/xfs_rw.c.  Return address = 0xc0211535"
> 
> Patch:
> *** fs/xfs/xfs_vfsops.c.orig	Thu Jul 27 13:10:23 2006
> --- fs/xfs/xfs_vfsops.c	Thu Jul 27 13:11:17 2006
> *************** xfs_mount(
> *** 524,528 ****
>   		goto error2;
> 
> ! 	if ((mp->m_flags & XFS_MOUNT_BARRIER) && !(vfsp->vfs_flag &
> VFS_RDONLY))
>   		xfs_mountfs_check_barriers(mp);
> 
> --- 524,528 ----
>   		goto error2;
> 
> ! 	if (mp->m_flags & XFS_MOUNT_BARRIER)
>   		xfs_mountfs_check_barriers(mp);
> 
> 


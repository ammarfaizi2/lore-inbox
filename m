Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760258AbWLFG2a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760258AbWLFG2a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 01:28:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760257AbWLFG2a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 01:28:30 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:31182 "EHLO
	agminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760255AbWLFG23 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 01:28:29 -0500
Date: Tue, 5 Dec 2006 22:28:09 -0800
From: Mark Fasheh <mark.fasheh@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: mm-commits@vger.kernel.org, akpm@osdl.org, hch@lst.de,
       val_henson@linux.intel.com, viro@zeniv.linux.org.uk
Subject: Re: + ocfs2-relative-atime-support-tweaks.patch added to -mm tree
Message-ID: <20061206062809.GD4497@ca-server1.us.oracle.com>
Reply-To: Mark Fasheh <mark.fasheh@oracle.com>
References: <200612060612.kB66CjNW025289@shell0.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200612060612.kB66CjNW025289@shell0.pdx.osdl.net>
Organization: Oracle Corporation
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2006 at 10:12:45PM -0800, akpm@osdl.org wrote:
> ------------------------------------------------------
> Subject: ocfs2-relative-atime-support-tweaks
> From: Andrew Morton <akpm@osdl.org>
> 
> methinks...
Yeah, all good tweaks - thanks for catching those. And thanks for carrying
the ocfs2 patch in -mm.

Acked-by: Mark Fasheh <mark.fasheh@oracle.com>

> diff -puN fs/ocfs2/file.c~ocfs2-relative-atime-support-tweaks fs/ocfs2/file.c
> --- a/fs/ocfs2/file.c~ocfs2-relative-atime-support-tweaks
> +++ a/fs/ocfs2/file.c
> @@ -153,16 +153,15 @@ int ocfs2_should_update_atime(struct ino
>  	    ((vfsmnt->mnt_flags & MNT_NODIRATIME) && S_ISDIR(inode->i_mode)))
>  		return 0;
>  
> -	now = CURRENT_TIME;
> -
>  	if (vfsmnt->mnt_flags & MNT_RELATIME) {
> -		if ((timespec_compare(&inode->i_atime, &inode->i_mtime) < 0) ||
> -		    (timespec_compare(&inode->i_atime, &inode->i_ctime) < 0))
> +		if ((timespec_compare(&inode->i_atime, &inode->i_mtime) <= 0) ||
> +		    (timespec_compare(&inode->i_atime, &inode->i_ctime) <= 0))
>  			return 1;
Hmm, should we fix up touch_atime() to use "<=" as well? Maybe I didn't read
it correctly...
	--Mark

--
Mark Fasheh
Senior Software Developer, Oracle
mark.fasheh@oracle.com

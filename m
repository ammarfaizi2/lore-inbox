Return-Path: <linux-kernel-owner+w=401wt.eu-S965056AbXATGSd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965056AbXATGSd (ORCPT <rfc822;w@1wt.eu>);
	Sat, 20 Jan 2007 01:18:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965048AbXATGSd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Jan 2007 01:18:33 -0500
Received: from 1wt.eu ([62.212.114.60]:2068 "EHLO 1wt.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965056AbXATGSc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Jan 2007 01:18:32 -0500
Date: Sat, 20 Jan 2007 07:18:18 +0100
From: Willy Tarreau <w@1wt.eu>
To: dann frazier <dannf@dannf.org>
Cc: Santiago Garcia Mantinan <manty@debian.org>, linux-kernel@vger.kernel.org,
       debian-kernel@lists.debian.org
Subject: Re: problems with latest smbfs changes on 2.4.34 and security backports
Message-ID: <20070120061818.GA22220@1wt.eu>
References: <20070117100030.GA11251@clandestino.aytolacoruna.es> <20070117215519.GX24090@1wt.eu> <20070119010040.GR16053@colo> <20070120010544.GY26210@colo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070120010544.GY26210@colo>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 19, 2007 at 06:05:44PM -0700, dann frazier wrote:
(...)
> Ah, think I see the problem now:
> 
> --- kernel-source-2.4.27.orig/fs/smbfs/proc.c	2007-01-19 17:53:57.247695476 -0700
> +++ kernel-source-2.4.27/fs/smbfs/proc.c	2007-01-19 17:49:07.480161733 -0700
> @@ -1997,7 +1997,7 @@
>  		fattr->f_mode = (server->mnt->dir_mode & (S_IRWXU | S_IRWXG | S_IRWXO)) | S_IFDIR;
>  	else if ( (server->mnt->flags & SMB_MOUNT_FMODE) &&
>  	          !(S_ISDIR(fattr->f_mode)) )
> -		fattr->f_mode = (server->mnt->file_mode & (S_IRWXU | S_IRWXG | S_IRWXO)) | S_IFREG;
> +		fattr->f_mode = (server->mnt->file_mode & (S_IRWXU | S_IRWXG | S_IRWXO)) | (fattr->f_mode & S_IFMT);
>  
>  }
>  
> Santiago: Thanks for reporting this - can you test this patch out on
> your system and let me know if there are still any problems?
> 
> Willy: I'll do some more testing and get you a patch that fixes this
> and the double assignment nonsense. Would you prefer a single patch or
> two?

Since the double assignment is not a bug per se, don't bother making a
separate patch, put everything in the same one.

Thanks a lot for your very fast response !

Cheers,
Willy


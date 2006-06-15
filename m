Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030337AbWFOMbK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030337AbWFOMbK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 08:31:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030338AbWFOMbK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 08:31:10 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:4075 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1030337AbWFOMbJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 08:31:09 -0400
Date: Thu, 15 Jun 2006 14:31:05 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Al Viro <viro@ftp.linux.org.uk>
cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] affs_fill_super() %s abuses
In-Reply-To: <20060615110355.GH27946@ftp.linux.org.uk>
Message-ID: <Pine.LNX.4.64.0606151427290.17704@scrub.home>
References: <20060615110355.GH27946@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 15 Jun 2006, Al Viro wrote:

> @@ -420,11 +422,17 @@ got_root:
>  	}
>  
>  	if (mount_flags & SF_VERBOSE) {
> -		chksum = cpu_to_be32(chksum);
> -		printk(KERN_NOTICE "AFFS: Mounting volume \"%*s\": Type=%.3s\\%c, Blocksize=%d\n",
> -			AFFS_ROOT_TAIL(sb, root_bh)->disk_name[0],
> -			AFFS_ROOT_TAIL(sb, root_bh)->disk_name + 1,
> -			(char *)&chksum,((char *)&chksum)[3] + '0',blocksize);
> +		int len = AFFS_ROOT_TAIL(sb, root_bh)->disk_name[0];
> +		char name[32];
> +
> +		if (len > 31)
> +			len = 31;

You get the same effect by changing it above into "min(AFFS_ROOT_TAIL(sb, 
root_bh)->disk_name[0], 31)" and makes the copying unnecessary.
BTW since this is only active with SF_VERBOSE, I don't think it's critical 
enough for 2.6.17 at this point.

bye, Roman

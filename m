Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280761AbRKKAzt>; Sat, 10 Nov 2001 19:55:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280762AbRKKAzi>; Sat, 10 Nov 2001 19:55:38 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:51697 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S280761AbRKKAz2>;
	Sat, 10 Nov 2001 19:55:28 -0500
Date: Sat, 10 Nov 2001 17:55:07 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Thorsten Kukuk <kukuk@suse.de>
Cc: linux-kernel@vger.kernel.org, Heinz.Mauelshagen@t-online.de
Subject: Re: Bug in /proc/lvm/global (garbage printed)
Message-ID: <20011110175507.L1778@lynx.no>
Mail-Followup-To: Thorsten Kukuk <kukuk@suse.de>,
	linux-kernel@vger.kernel.org, Heinz.Mauelshagen@t-online.de
In-Reply-To: <20011110120619.A10459@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <20011110120619.A10459@suse.de>; from kukuk@suse.de on Sat, Nov 10, 2001 at 12:06:19PM +0100
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 10, 2001  12:06 +0100, Thorsten Kukuk wrote:
> The problem is in the _proc_read_global function. This function does
> not use the "page" parameter to return the data. Instead it allocates
> it's own buffer and change to "start" parameter to point to it.
> 
> --- drivers/md/lvm-fs.c	2001/11/09 19:00:38	1.1
> +++ drivers/md/lvm-fs.c	2001/11/09 20:50:16
> @@ -482,11 +480,15 @@
>  		buf = NULL;
>  		return 0;
>  	}
> -	*start = &buf[pos];
> -	if (sz - pos < count)
> +	/* *start = &buf[pos]; */
> +	if (sz - pos < count) {
> +		memcpy (page, &buf[pos], sz - pos);
>  		return sz - pos;
> -	else
> +        }
> +	else {
> +		memcpy (page, &buf[pos], count);
>  		return count;
> +	}
>  
>  #undef LVM_PROC_BUF
>  }

What version of LVM do you have?  This code looks different than mine.
The file lvm-fs.c does not exist in Linus kernels, only in patched kernels.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/


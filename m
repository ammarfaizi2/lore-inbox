Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932369AbWCVTQD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932369AbWCVTQD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 14:16:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932368AbWCVTQC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 14:16:02 -0500
Received: from smtp.osdl.org ([65.172.181.4]:28357 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932369AbWCVTQA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 14:16:00 -0500
Date: Wed, 22 Mar 2006 11:12:31 -0800
From: Andrew Morton <akpm@osdl.org>
To: Neil Horman <nhorman@tuxdriver.com>
Cc: linux-kernel@vger.kernel.org, joe.korty@ccur.com
Subject: Re: [PATCH] proc: fix duplicate line in /proc/devices
Message-Id: <20060322111231.779efd38.akpm@osdl.org>
In-Reply-To: <20060322132558.GB29565@hmsreliant.homelinux.net>
References: <20060322132558.GB29565@hmsreliant.homelinux.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Horman <nhorman@tuxdriver.com> wrote:
>
> Patch to fix a potential duplicate block device line printed after the "Block
> device" header in /proc/devices.  Tested and confirmed working by the reporter.
> 

<looks>

Block devices:
  1 ramdisk
  1 ramdisk
  2 fd
  8 sd

> 
> diff --git a/fs/proc/proc_misc.c b/fs/proc/proc_misc.c
> index 1d24fea..b097958 100644
> --- a/fs/proc/proc_misc.c
> +++ b/fs/proc/proc_misc.c
> @@ -312,7 +312,6 @@ static void *devinfo_next(struct seq_fil
>  		case BLK_HDR:
>  			info->state = BLK_LIST;
>  			(*pos)++;
> -			break;
>  		case BLK_LIST:
>  			if (get_blkdev_info(info->blkdev,&idummy,&ndummy)) {
>  				/*

OK, so that's the same as CHR_HDR and lines up with the fallthroughs in
devinfo_show().  A somewhat strange way of implementing a state machine,
but I guess it saves a few cycles...

I'll copy the stable-kernel guys - this is 2.6.16.1 material, thanks.

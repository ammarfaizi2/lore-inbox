Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932392AbWCVTW1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932392AbWCVTW1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 14:22:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932396AbWCVTW1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 14:22:27 -0500
Received: from ra.tuxdriver.com ([24.172.12.4]:14353 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S932392AbWCVTW0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 14:22:26 -0500
Date: Wed, 22 Mar 2006 14:22:14 -0500
From: Neil Horman <nhorman@tuxdriver.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, joe.korty@ccur.com
Subject: Re: [PATCH] proc: fix duplicate line in /proc/devices
Message-ID: <20060322192214.GC29565@hmsreliant.homelinux.net>
References: <20060322132558.GB29565@hmsreliant.homelinux.net> <20060322111231.779efd38.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060322111231.779efd38.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2006 at 11:12:31AM -0800, Andrew Morton wrote:
> Neil Horman <nhorman@tuxdriver.com> wrote:
> >
> > Patch to fix a potential duplicate block device line printed after the "Block
> > device" header in /proc/devices.  Tested and confirmed working by the reporter.
> > 
> 
> <looks>
> 
> Block devices:
>   1 ramdisk
>   1 ramdisk
>   2 fd
>   8 sd
> 
> > 
> > diff --git a/fs/proc/proc_misc.c b/fs/proc/proc_misc.c
> > index 1d24fea..b097958 100644
> > --- a/fs/proc/proc_misc.c
> > +++ b/fs/proc/proc_misc.c
> > @@ -312,7 +312,6 @@ static void *devinfo_next(struct seq_fil
> >  		case BLK_HDR:
> >  			info->state = BLK_LIST;
> >  			(*pos)++;
> > -			break;
> >  		case BLK_LIST:
> >  			if (get_blkdev_info(info->blkdev,&idummy,&ndummy)) {
> >  				/*
> 
> OK, so that's the same as CHR_HDR and lines up with the fallthroughs in
> devinfo_show().  A somewhat strange way of implementing a state machine,
> but I guess it saves a few cycles...
> 
> I'll copy the stable-kernel guys - this is 2.6.16.1 material, thanks.
Fantastic.  Thanks Andrew.
Neil

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
/***************************************************
 *Neil Horman
 *Software Engineer
 *gpg keyid: 1024D / 0x92A74FA1 - http://pgp.mit.edu
 ***************************************************/

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263969AbTEOLYV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 07:24:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263970AbTEOLYV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 07:24:21 -0400
Received: from 205-158-62-136.outblaze.com ([205.158.62.136]:61098 "HELO
	fs5-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id S263969AbTEOLYT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 07:24:19 -0400
Subject: Re: 2.5.69-mm5: pccard oops while booting: resolved
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Andrew Morton <akpm@digeo.com>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20030514191735.6fe0998c.akpm@digeo.com>
References: <1052964213.586.3.camel@teapot.felipe-alfaro.com>
	 <20030514191735.6fe0998c.akpm@digeo.com>
Content-Type: text/plain
Message-Id: <1052998601.726.1.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.3 (Preview Release)
Date: 15 May 2003 13:36:41 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-05-15 at 04:17, Andrew Morton wrote:
> Felipe Alfaro Solana <felipe_alfaro@linuxmail.org> wrote:
> >
> > I've been able to pinpoint the culprit of this: it's the
> >  "make-KOBJ_NAME-match-BUS_ID_SIZE.patch" patch that it's causing the
> >  oops for me when booting 2.5.69.mm5.
> > 
> >  Reverting this patch solves the oops for me.
> 
> I might have screwed that patch up.
> 
> This is the second half of it.  When it crashed, did you have the below
> change in place as well?
> 
> Index: include/linux/device.h
> ===================================================================
> RCS file: /home/scm/linux-2.5/include/linux/device.h,v
> retrieving revision 1.48
> diff -u -u -r1.48 device.h
> --- include/linux/device.h	29 Apr 2003 17:30:20 -0000	1.48
> +++ include/linux/device.h	13 May 2003 07:47:39 -0000
> @@ -35,7 +35,7 @@
>  #define DEVICE_NAME_SIZE	50
>  #define DEVICE_NAME_HALF	__stringify(20)	/* Less than half to accommodate slop */
>  #define DEVICE_ID_SIZE		32
> -#define BUS_ID_SIZE		20
> +#define BUS_ID_SIZE		KOBJ_NAME_LEN
>  
> 
>  enum {
> -

I applied the second half patch on top of 2.5.69-mm5 (the original
2.5.69-mm5 defined BUS_ID_SIZE as 20), but the "pccard" kernel task
keeps crashing as before.

Anything else for me to try? :-)

Thanks!


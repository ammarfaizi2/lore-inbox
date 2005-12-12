Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751214AbVLLKgQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751214AbVLLKgQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 05:36:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751215AbVLLKgQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 05:36:16 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:30614 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751214AbVLLKgP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 05:36:15 -0500
Subject: Re: [PATCH 2.6.15-rc5] media/video/bttv : enhance ioctl debug
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: Philippe De Muyter <phdm@macqel.be>
Cc: linux-kernel@vger.kernel.org,
       Linux and Kernel Video <video4linux-list@redhat.com>
In-Reply-To: <200512082105.jB8L5xW12712@mail.macqel.be>
References: <200512082105.jB8L5xW12712@mail.macqel.be>
Content-Type: text/plain; charset=ISO-8859-1
Date: Mon, 12 Dec 2005 08:36:03 -0200
Message-Id: <1134383763.18903.37.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-1mdk 
Content-Transfer-Encoding: 8bit
X-Spam-Score: 1.8 (+)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (1.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[200.163.0.147 listed in dnsbl.sorbs.net]
	1.7 RCVD_IN_NJABL_DUL      RBL: NJABL: dialup sender did non-local SMTP
	[200.163.0.147 listed in combined.njabl.org]
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Qui, 2005-12-08 às 22:05 +0100, Philippe De Muyter escreveu:
> This patch adds the current process name in the media/video/bttv ioctl debug.

	Philippe, 

	I'm in doubt about the relevance of this patch. Why do you think it is
important to have process name at ioctl debug?

	PS.: Please address these patches to V4L Mailing List.
> 
> Signed-off-by: Philippe De Muyter <phdm@macqel.be>
> 
> ---
> 
> --- linux/drivers/media/video/bttv-driver.c.orig	2005-08-29 01:41:01.000000000 +0200
> +++ linux/drivers/media/video/bttv-driver.c	2005-12-08 20:59:45.000000000 +0100
> @@ -2181,19 +2182,19 @@ static int bttv_do_ioctl(struct inode *i
>  	int retval = 0;
>  
>  	if (bttv_debug > 1) {
> +		printk("bttv%d: %s: ioctl 0x%x ", btv->c.nr, current->comm,
> +			cmd);
>  		switch (_IOC_TYPE(cmd)) {
>  		case 'v':
> -			printk("bttv%d: ioctl 0x%x (v4l1, VIDIOC%s)\n",
> -			       btv->c.nr, cmd, (_IOC_NR(cmd) < V4L1_IOCTLS) ?
> +			printk("(v4l1, VIDIOC%s)\n",
> +			       (_IOC_NR(cmd) < V4L1_IOCTLS) ?
>  			       v4l1_ioctls[_IOC_NR(cmd)] : "???");
>  			break;
>  		case 'V':
> -			printk("bttv%d: ioctl 0x%x (v4l2, %s)\n",
> -			       btv->c.nr, cmd,  v4l2_ioctl_names[_IOC_NR(cmd)]);
> +			printk("(v4l2, %s)\n", v4l2_ioctl_names[_IOC_NR(cmd)]);
>  			break;
>  		default:
> -			printk("bttv%d: ioctl 0x%x (???)\n",
> -			       btv->c.nr, cmd);
> +			printk("(???)\n");
>  		}
>  	}
>  	if (btv->errors)
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


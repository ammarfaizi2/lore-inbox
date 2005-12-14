Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932397AbVLNQnH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932397AbVLNQnH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 11:43:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932400AbVLNQnH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 11:43:07 -0500
Received: from mail.macqel.be ([194.78.208.39]:56582 "EHLO mail.macqel.be")
	by vger.kernel.org with ESMTP id S932397AbVLNQnG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 11:43:06 -0500
Message-Id: <200512141642.jBEGgvg07588@mail.macqel.be>
Subject: Re: [PATCH 2.6.15-rc5] media/video/bttv : enhance ioctl debug
In-Reply-To: <1134383763.18903.37.camel@localhost> from Mauro Carvalho Chehab
 at "Dec 12, 2005 08:36:03 am"
To: Mauro Carvalho Chehab <mchehab@infradead.org>
Date: Wed, 14 Dec 2005 17:42:56 +0100 (CET)
CC: linux-kernel@vger.kernel.org,
       Linux and Kernel Video <video4linux-list@redhat.com>
From: "Philippe De Muyter" <phdm@macqel.be>
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mauro Carvalho Chehab wrote :
> Em Qui, 2005-12-08 às 22:05 +0100, Philippe De Muyter escreveu:
> > This patch adds the current process name in the media/video/bttv ioctl debug.
> 
> 	Philippe, 
> 
> 	I'm in doubt about the relevance of this patch. Why do you think it is
> important to have process name at ioctl debug?

I needed to add that when testing my v4l2-compat patches with xawtv.  It took
me a long time to discover that some ioctls were issued by xawtv itself,
others by v4l-conf and others yet by the xvideo/v4l module of my Xserver.
With the process name in the ioctl debugging, I think that my tests and
development would have been much faster.

Philippe

> 
> 	PS.: Please address these patches to V4L Mailing List.
> > 
> > Signed-off-by: Philippe De Muyter <phdm@macqel.be>
> > 
> > ---
> > 
> > --- linux/drivers/media/video/bttv-driver.c.orig	2005-08-29 01:41:01.000000000 +0200
> > +++ linux/drivers/media/video/bttv-driver.c	2005-12-08 20:59:45.000000000 +0100
> > @@ -2181,19 +2182,19 @@ static int bttv_do_ioctl(struct inode *i
> >  	int retval = 0;
> >  
> >  	if (bttv_debug > 1) {
> > +		printk("bttv%d: %s: ioctl 0x%x ", btv->c.nr, current->comm,
> > +			cmd);
> >  		switch (_IOC_TYPE(cmd)) {
> >  		case 'v':
> > -			printk("bttv%d: ioctl 0x%x (v4l1, VIDIOC%s)\n",
> > -			       btv->c.nr, cmd, (_IOC_NR(cmd) < V4L1_IOCTLS) ?
> > +			printk("(v4l1, VIDIOC%s)\n",
> > +			       (_IOC_NR(cmd) < V4L1_IOCTLS) ?
> >  			       v4l1_ioctls[_IOC_NR(cmd)] : "???");
> >  			break;
> >  		case 'V':
> > -			printk("bttv%d: ioctl 0x%x (v4l2, %s)\n",
> > -			       btv->c.nr, cmd,  v4l2_ioctl_names[_IOC_NR(cmd)]);
> > +			printk("(v4l2, %s)\n", v4l2_ioctl_names[_IOC_NR(cmd)]);
> >  			break;
> >  		default:
> > -			printk("bttv%d: ioctl 0x%x (???)\n",
> > -			       btv->c.nr, cmd);
> > +			printk("(???)\n");
> >  		}
> >  	}
> >  	if (btv->errors)
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> 


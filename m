Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932184AbWEWMOM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932184AbWEWMOM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 08:14:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932185AbWEWMOM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 08:14:12 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:47271 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932184AbWEWMOL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 08:14:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oShvQSk2Nl0Y6uUZ67GctXmo9wQnxXrmsnd9/MdOYH4hNfcfyWpbKh2lOq+bF0Me9Dm4p1xP5vw9Lj7ig3yHkzpwXcqijg/nQ/CLyl3+AcROSxctlZ4XMxnMdrMcRF+ukk7U5BGOxmSNQRExr8aZlD/33sh+AmVZy1anOcsHSrQ=
Message-ID: <70066d530605230514o7e6c34cfye6465faa6db37547@mail.gmail.com>
Date: Tue, 23 May 2006 08:14:09 -0400
From: "Jaya Kumar" <jayakumar.video@gmail.com>
To: "Mauro Carvalho Chehab" <mchehab@infradead.org>
Subject: Re: [Fwd: [PATCH 2.6.17-rc4 1/1] usbvideo misc cleanup]
Cc: "Linux and Kernel Video" <video4linux-list@redhat.com>,
       "Simon Evans" <spse@secret.org.uk>,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Dmitri <dmitri@users.sourceforge.net>
In-Reply-To: <1147903350.30469.16.camel@praia>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1147903350.30469.16.camel@praia>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/17/06, Mauro Carvalho Chehab <mchehab@infradead.org> wrote:
> Hmm... It seems that those drivers are without any current maintainer.
> At least, from my research, I didn't noticed any patch from a maintainer
> at 2.6 git tree.
>
> Anyway, let's copy both Dmitri and Simon.
>
> I dunno who were the authors for ibmcam and usbvideo.
>
>

I was also wondering if anyone is working on converting usbvideo to
v4l2. There's also a warning message from videodev that is triggered
by usbvideo's template:

videodev does:
357 #if 1 /* needed until all drivers are fixed */
358         if (!vfd->release)
359                 printk(KERN_WARNING "videodev: \"%s\" has no
release callback. "
360                        "Please fix your driver for proper sysfs
support, see "
361                        "http://lwn.net/Articles/36850/\n", vfd->name);
362 #endif

usbvideo does:
958 static const struct video_device usbvideo_template = {
959         .owner =      THIS_MODULE,
960         .type =       VID_TYPE_CAPTURE,
961         .hardware =   VID_HARDWARE_CPIA,
962         .fops =       &usbvideo_fops,
963 };

and so videodev doesn't find .release and complains.

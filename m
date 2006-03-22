Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750737AbWCVLPu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750737AbWCVLPu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 06:15:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750838AbWCVLPu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 06:15:50 -0500
Received: from mailgate2.urz.uni-halle.de ([141.48.3.8]:20878 "EHLO
	mailgate2.urz.uni-halle.de") by vger.kernel.org with ESMTP
	id S1750737AbWCVLPt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 06:15:49 -0500
Date: Wed, 22 Mar 2006 12:14:46 +0100
From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH] hpet header sanitization
In-reply-to: <200603221118.43853.abergman@de.ibm.com>
To: Arnd Bergmann <abergman@de.ibm.com>
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, lkml <linux-kernel@vger.kernel.org>,
       akpm <akpm@osdl.org>
Message-id: <20060322111446.GA7675@turing.informatik.uni-halle.de>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: Mutt/1.4i
References: <20060321144607.153d1943.rdunlap@xenotime.net>
 <200603221118.43853.abergman@de.ibm.com>
X-Scan-Signature: d2c9cb8541c06091084f66af647eabf0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann wrote:
> On Tuesday 21 March 2006 23:46, Randy.Dunlap wrote:
> > +#define        HPET_IE_ON      _IO('h', 0x01)  /* interrupt on */
> > +#define        HPET_IE_OFF     _IO('h', 0x02)  /* interrupt off */
> > +#define        HPET_INFO       _IOR('h', 0x03, struct hpet_info)
> > +#define        HPET_EPI        _IO('h', 0x04)  /* enable periodic */
> > +#define        HPET_DPI        _IO('h', 0x05)  /* disable periodic */
> > +#define        HPET_IRQFREQ    _IOW('h', 0x6, unsigned long)   /* IRQFREQ usec */
> 
> By the way, HPET_INFO and HPET_IRQFREQ don't work for 32 bit user space,
> the driver needs a compat_ioctl() method to handle those.

There isn't any program (except the example in the docs) that uses any
of these ioctls, and I'm writing patches to make this device available
through portable timer APIs like hrtimer/POSIX clocks/ALSA that are much
easier to use besides, so I think it would be a good idea to just
schedule these ioctls for removal.


Clemens

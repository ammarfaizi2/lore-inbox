Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932152AbVLPGzz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932152AbVLPGzz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 01:55:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932153AbVLPGzz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 01:55:55 -0500
Received: from smtp110.sbc.mail.re2.yahoo.com ([68.142.229.95]:4235 "HELO
	smtp110.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S932152AbVLPGzy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 01:55:54 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [PATCH] tlclk.c: pointers are handled by %p
Date: Fri, 16 Dec 2005 01:55:51 -0500
User-Agent: KMail/1.8.3
Cc: Al Viro <viro@ftp.linux.org.uk>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
References: <E1EmpFz-00080I-2r@ZenIV.linux.org.uk> <20051215095754.GA32490@flint.arm.linux.org.uk>
In-Reply-To: <20051215095754.GA32490@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512160155.52397.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 15 December 2005 04:57, Russell King wrote:
> On Thu, Dec 15, 2005 at 09:18:35AM +0000, Al Viro wrote:
> > diff --git a/drivers/char/tlclk.c b/drivers/char/tlclk.c
> > index 12167c0..e8467dc 100644
> > --- a/drivers/char/tlclk.c
> > +++ b/drivers/char/tlclk.c
> > @@ -776,8 +776,8 @@ static int __init tlclk_init(void)
> >  	tlclk_device = platform_device_register_simple("telco_clock",
> >  				-1, NULL, 0);
> >  	if (!tlclk_device) {
> > -		printk(KERN_ERR " platform_device_register retruns 0x%X\n",
> > -			(unsigned int) tlclk_device);
> > +		printk(KERN_ERR " platform_device_register retruns 0x%p\n",
> > +			tlclk_device);
> 
> This looks really strange - we know what tlclk_device will be at that
> printk - it'll be NULL because if it's anything different we wouldn't
> be inside this if(){ }.
> 
> Moreover, this code is obviously bogus.  platform_device_register_simple
> does not return NULL for the error case.  It should be something like:
> 
> 	if (IS_ERR(tlclk_device)) {
> 		ret = PTR_ERR(tlclk_device);
> 		printk(KERN_ERR "platform_device_register returns %d\n",
> 		        ret);
> 		goto out4;
> 	}
> 

I have a patch killing usage of platform_register_device_simple in this
driver (converting to platform_device_alloc() + _add()). Will post in a
minute.

-- 
Dmitry

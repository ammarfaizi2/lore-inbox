Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750843AbVKNGKM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750843AbVKNGKM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 01:10:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750888AbVKNGKM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 01:10:12 -0500
Received: from smtp102.sbc.mail.re2.yahoo.com ([68.142.229.103]:30849 "HELO
	smtp102.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1750843AbVKNGKL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 01:10:11 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Neil Brown <neilb@suse.de>
Subject: Re: uinput broken in 2.6.15-rc1
Date: Mon, 14 Nov 2005 01:10:04 -0500
User-Agent: KMail/1.8.3
Cc: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>, vojtech@suse.cz,
       linux-kernel@vger.kernel.org
References: <17272.7295.464735.805122@cse.unsw.edu.au>
In-Reply-To: <17272.7295.464735.805122@cse.unsw.edu.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511140110.05991.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 14 November 2005 00:11, Neil Brown wrote:
> 
> The 'uinput' driver doesn't work well in 2.6.15-rc1.  It
> triggers this complaint:
> 		printk(KERN_WARNING "input: device %s is statically allocated, will not register\n"
> 			"Please convert to input_allocate_device() or contact dtor_core@ameritech.net\n",
> 			dev->name ? dev->name : "<Unknown>");
> 
> The following patch fixes it for me, but I'm not convinced it is
> correct.  I would expect it to need a special 'free' routine to match
> the special 'alloc' routine, but I couldn't easily find one.
> 

Hi,

This should work OK as long as you don't try to reuse the uinput device
because input_unregister_device frees the data structure for you and
uinput does not expect to lose part of its data structure.

I am trying to comer up with a proper fix...

-- 
Dmitry

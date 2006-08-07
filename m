Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750892AbWHGC2K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750892AbWHGC2K (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 22:28:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750910AbWHGC2K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 22:28:10 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:31564 "EHLO
	asav07.manage.insightbb.com") by vger.kernel.org with ESMTP
	id S1750892AbWHGC2J convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 22:28:09 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Aa4HADpB1kSBUQ
From: Dmitry Torokhov <dtor@insightbb.com>
To: Marek =?utf-8?q?Va=C5=A1ut?= <marek.vasut@gmail.com>
Subject: Re: [PATCH] Stowaway 2.6.17.1
Date: Sun, 6 Aug 2006 22:28:07 -0400
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <200608052152.05840.marek.vasut@gmail.com>
In-Reply-To: <200608052152.05840.marek.vasut@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200608062228.07964.dtor@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 05 August 2006 15:52, Marek Vašut wrote:
> Hi,
> this patch adds support for stowaway and stowaway compatible (eg. dicota 
> inutPDA) serial keyboards. I made it on kernel 2.6.16, but it applies cleanly 
> on 2.6.17.1 too. I tested it on palm zire71 and friend reported me that it 
> works on palm tungsten T3.
>

Hi,

Looks pretty good, I have a question though:

> +       if (data < 0x80) {
> +       /* invalid scan codes are probably the init sequence, so we ignore them */
> +           if (skbd->keycode[data & SKBD_KEY]) { 
> +                   input_regs(skbd->dev, regs);
> +                   input_report_key(skbd->dev, skbd->keycode[data & SKBD_KEY], 1);
> +                   input_sync(skbd->dev); 
> +           }
> +           else if (data == 0xe7) /* end of init sequence */
> +                   printk(KERN_INFO "input: %s on %s\n", skbd->dev->name, serio->phys);

How does "init sequence" gets here? Normally inputattach initializes
hardware and then creates proper serio port...
 
> +       err = serio_open(serio, drv);
> +       if (err)
> +               goto fail;
> +
> +       input_register_device(skbd->dev);
> +       return 0;

You need to handle errors from input_register_device() too.

-- 
Dmitry

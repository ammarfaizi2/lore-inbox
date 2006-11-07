Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752933AbWKGVKf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752933AbWKGVKf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 16:10:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752928AbWKGVKf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 16:10:35 -0500
Received: from smtp.osdl.org ([65.172.181.4]:8393 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752918AbWKGVKe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 16:10:34 -0500
Date: Tue, 7 Nov 2006 13:10:14 -0800
From: Andrew Morton <akpm@osdl.org>
To: Haavard Skinnemoen <hskinnemoen@atmel.com>
Cc: David Brownell <david-b@pacbell.net>, Andrew Victor <andrew@sanpeople.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [-mm patch 1/4] GPIO framework for AVR32
Message-Id: <20061107131014.535ab280.akpm@osdl.org>
In-Reply-To: <20061107122715.3022da2f@cad-250-152.norway.atmel.com>
References: <20061107122507.6f1c6e81@cad-250-152.norway.atmel.com>
	<20061107122715.3022da2f@cad-250-152.norway.atmel.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Nov 2006 12:27:15 +0100
Haavard Skinnemoen <hskinnemoen@atmel.com> wrote:

> Add a simple GPIO framework for AVR32. This should be fairly similar
> to the AT91 GPIO API, but there are still a couple of differences:
> 
>   * Naming. We prefix all functions with gpio_ instead of at91_
>   * request_gpio() and free_gpio() should be called to make sure
>     the required pins are available, but it will still work if you
>     don't.

+EXPORT_SYMBOL(request_gpio);
+EXPORT_SYMBOL(free_gpio);
+EXPORT_SYMBOL(gpio_set_value);
+EXPORT_SYMBOL(gpio_get_value);
+EXPORT_SYMBOL(gpio_set_output_enable);
+EXPORT_SYMBOL(gpio_set_pullup_enable);

I wonder about this naming choice.  I'd have though that if/when the kernel
gets a generic GPIO driver or layer, these avr32-specific symbols will need
renaming.

h8300 uses h8300_free_gpio(), and there's also omap_free_gpio().  Perhaps
this patch should have added avr32_free_gpio()?


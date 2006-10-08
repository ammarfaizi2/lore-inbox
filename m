Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750764AbWJHS12@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750764AbWJHS12 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 14:27:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750835AbWJHS12
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 14:27:28 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:64781 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1750764AbWJHS12
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 14:27:28 -0400
Date: Sun, 8 Oct 2006 18:24:38 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Miguel Ojeda Sandonis <maxextreme@gmail.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.19-rc1 V9] drivers: add LCD support
Message-ID: <20061008182438.GA4033@ucw.cz>
References: <20061006002950.49b25189.maxextreme@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061006002950.49b25189.maxextreme@gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Andrew, I think this can be the final review.
> Updated to 2.6.19-rc1. Please apply.

No, I'm sorry. And I have to apologize for being blind.

I was going to say 'this is very important, because cellphones *do*
have secondary displays, and we want to use them'. And yes it is
important, but you got the interface wrong.


> +		The cfag12864b LCD driver defines two ways to communicate
> +		with the lcd.
> +
> +		1. Use seek and write syscalls. Bytes written appear on
> +		   the screen without any formatting on the position pointed
> +		   by the file offset.
> +
> +		   It is hardware dependent. It should be use to modify
> +		   specific display's pixels to achieve higher refreshing
> +		   rates.
> +
> +		2. Use ioctl syscall. The magic number is 0xFF.
> +		   There are four ioctls:
> +
> +		   2.0. off	_IO(0xFF,0)
> +
> +			Power off display.
> +
> +			It doesn't clear the display.
> +			It doesn't stop the controllers.
> +
> +		   2.1. on	_IO(0xFF,1)
> +
> +			Power on display.
> +
> +		   2.2. clear	_IO(0xFF,2)
> +
> +			Clear the display.
> +
> +		   2.3. format	_IOW(0xFF,3,void *)
> +
> +			Read the given buffer, transform it to the hardware
> +			dependent format and show it on the screen.
> +
> +			The argument must point to a userspace buffer of
> +			size 128*64 bytes (the display's size).
> +
> +			Each buffer's byte (unsigned) represent a pixel:
> +				0  = pixel will turn off
> +				>0 = pixel will turn on
> +
> +		For more information and examples, see
> +		Documentation/auxdisplay/cfag12864b

So you have 128x64 pixels b/w display, and invented completely new
interface to control it.

Fortunately we already have good interface for the display... It is
called fbcon, and is more flexible than 128x64 b/w... but can do
128x64 b/w just fine.

Please use it. It is way more flexible, and it is right thing to do.

						Pavel
-- 
Thanks for all the (sleeping) penguins.

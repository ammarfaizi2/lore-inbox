Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262694AbTESSpz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 14:45:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262706AbTESSpy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 14:45:54 -0400
Received: from zeke.inet.com ([199.171.211.198]:7575 "EHLO zeke.inet.com")
	by vger.kernel.org with ESMTP id S262694AbTESSpx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 14:45:53 -0400
Message-ID: <3EC9295A.4090103@inet.com>
Date: Mon, 19 May 2003 13:58:34 -0500
From: Eli Carter <eli.carter@inet.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Adam J. Richter" <adam@yggdrasil.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.69-bk1[23] kconfig loop
References: <200305191821.h4JILlE12026@adam.yggdrasil.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam J. Richter wrote:
>         If I run "make oldconfig" under linux-2.5.69-bk12
> and select "m" for CONFIG_USB_GADGET, I am asked a question
> or two about USB gadget interfaces that I might want, and
> then the build process gets into an infinite loop.  If I set
> CONFIG_USB_GADGET to "n", then everything is fine.
> 
>         I expect there is no input that is supposed to cause
> "make oldconfig" to go into an infinite loop, so this must at
> least be a kconfig bug.  Here is a transcript of the interation
> that leads to the infinite loop:
> 
> 
> Support for USB Gadgets (USB_GADGET) [N/m/y/?] (NEW) m
>   USB Peripheral Controller Support
>     NetChip 2280 USB Peripheral Controller (USB_NET2280) [N/m/?] (NEW) m
>   USB Gadget Drivers
>     Gadget Zero (DEVELOPMENT) (USB_ZERO) [N/m/?] (NEW) m
>     Ethernet Gadget (USB_ETH) [N/m/?] (NEW) m
> [Infinite loop starts here.  The following lines repeat forever,
> non-interactively.  They just go scrolling by.]
> *
> * Restart config...
> *
> *
> * Support for USB Gadgets
> *
> Support for USB Gadgets (USB_GADGET) [M/n/y/?] m
>   USB Peripheral Controller Support
>     NetChip 2280 USB Peripheral Controller (USB_NET2280) [M/n/?] m
>   USB Gadget Drivers
>     Gadget Zero (DEVELOPMENT) (USB_ZERO) [M/n/?] m
> make: *** [oldconfig] Interrupt

I've seen this happen when no options within a 'choice' construct are 
active.  (i.e., they all depend on something that isn't true.)

HTH,

Eli
--------------------. "If it ain't broke now,
Eli Carter           \                  it will be soon." -- crypto-gram
eli.carter(a)inet.com `-------------------------------------------------


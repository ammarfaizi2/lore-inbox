Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261607AbULBNMp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261607AbULBNMp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 08:12:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261616AbULBNMp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 08:12:45 -0500
Received: from alog0328.analogic.com ([208.224.222.104]:2688 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261607AbULBNLG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 08:11:06 -0500
Date: Thu, 2 Dec 2004 08:11:01 -0500 (EST)
From: linux-os <linux-os@chaos.analogic.com>
Reply-To: linux-os@analogic.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: keyboard timeout
In-Reply-To: <1101944709.30770.78.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.61.0412020748070.11261@chaos.analogic.com>
References: <Pine.LNX.4.61.0412011721090.8835@chaos.analogic.com>
 <1101944709.30770.78.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Dec 2004, Alan Cox wrote:

> On Mer, 2004-12-01 at 22:29, linux-os wrote:
>> If Linux 2.6.9 is booted on a 40 MHz `486 with the standard
>> ISA clock of 14.3 MHz (yes that's the standard), the kernel
>> will complain about a keyboard timeout for every key touched!
>
> 8.33Mhz. The delays should be correct but given that just about all
> hardware under 15 years old doesn't care (I think the last thing to care
> was the digital hi-note laptop) it is possible that the new input code
> has a tiny missing delay somewhere. Having said that I have specifically
> audited the input keyboard driver for such problems in 2.6.5 or so and
> found only one (which is fixed)
>
> Nor should the ISA bus speed matter - the uController chugs along at
> about 2Mhz and the delays it needs are a bit longer than just ISA
> cycles.

>From original IBM specification...
"...8284A Clock generator clock generator supplies the multiphase
clock signals that are needed to drive the microprocessor and
the peripherals. Its base frequency is 14.31818 MHz....."

 	14.31818 / 3 =  4.7727... MHz (the original CPU clock frequency)
 	14.31818 / 12 = 1.1931... frequency fed to 8253 PIT and
 		keyboard controller.

 	... etc...

Low power clones, designed to use very low power __still__ use
these low frequencies. These frequencies were chosen by ME
because they can derive from the 3.579545 MHz color sugarier
frequency that was used in color television. The early PCs
were expected to be connected to color TV.

FYI 3.579545 (NTSC color sub-carrier frequency) is 14.31818 / 4.
I know all these numbers by heart because I had to defend them
over several murderous design reviews in Boca Raton. Modern
motherboards generate the PIT and keyboard frequencies (also
the UART input) using other methods, but these low frequencies
are still in use. And, yes the keyboard MUST have a longer timeout
regardless of your "audit". Thanks for the help.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.9 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by John Ashcroft.
                  98.36% of all statistics are fiction.

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292576AbSBTX1H>; Wed, 20 Feb 2002 18:27:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292581AbSBTX05>; Wed, 20 Feb 2002 18:26:57 -0500
Received: from exchange.macrolink.com ([64.173.88.99]:55822 "EHLO
	exchange.macrolink.com") by vger.kernel.org with ESMTP
	id <S292576AbSBTX0j>; Wed, 20 Feb 2002 18:26:39 -0500
Message-ID: <11E89240C407D311958800A0C9ACF7D13A76A7@EXCHANGE>
From: Ed Vance <EdV@macrolink.com>
To: "'David Lawyer'" <dave@lafn.org>
Cc: "'linux-kernel'" <linux-kernel@vger.kernel.org>
Subject: RE: Problem to use a Oxford semiconductor Intelligent DUAL Channe
	 l UA RT (OX16PCI952)
Date: Wed, 20 Feb 2002 15:26:45 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2002 at 09:03PM, David Lawyer wrote:
> On Fri, Feb 15, 2002 at 11:17:02AM -0800, Ed Vance wrote:
> > 
> > If you can find out the maximum baud rate, try adjusting the it for the
port
> > with setserial's baud_base parameter. Two common base baud rates for 95X
> > based cards are 921600 and 3125000. 
> 
> How does 3125000 divide to give the standard "baud" rates?  I checked a
> few standard values such at 115.2k, 28.8k, etc. 3125000 is not
> divisible by them.  You may have a wrong number.

Right you are. The 3125000 Hz number does not divide well for the faster
standard rates. Here's where the number came from. The oscillator value on
my 16PCI954 based card is 50.0 MHz, which is not a clean multiple of
anything. The UART is in x16 async clock mode so (without the prescaler) the
highest possible baud rate (divisor = 1) is 50.0 MHz / 16 = 3125000 Hz. 

To get the standard rates above 115.2k with a 50.0 MHz clock, we must use
the 16950's CPR register (prescaler) which supports fractional scale
factors. See today's patch from fabrizio.gennari@philips.com, "[PATCH]
Kernel support for 16C950's CPR register". This is a better solution than
what I was using which was to initialize the CPR to create a more benign
base rate close to 921600 Hz, which is the other number I mentioned.

Thanks for noticing. I had published the version of my serial driver patch
without the CPR register initialization. oops. 

Best regards,
---------------------------------------------------------------- 
Ed Vance              edv@macrolink.com
Macrolink, Inc.       1500 N. Kellogg Dr  Anaheim, CA  92807
----------------------------------------------------------------


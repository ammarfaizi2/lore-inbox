Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285647AbRLRJxA>; Tue, 18 Dec 2001 04:53:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285644AbRLRJwu>; Tue, 18 Dec 2001 04:52:50 -0500
Received: from gw2-mail.cict.fr ([195.220.59.21]:56580 "EHLO gw2-mail.cict.fr")
	by vger.kernel.org with ESMTP id <S285640AbRLRJwc>;
	Tue, 18 Dec 2001 04:52:32 -0500
Date: Tue, 18 Dec 2001 10:52:27 +0100
From: Jerome AUGE <auge@irit.fr>
To: linux-kernel@vger.kernel.org
Subject: What about a "generic" ISA/BIOS PnP layer ?
Message-ID: <20011218105227.A3339@pc9sig.irit.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Organization: IRIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've tweaked the opl3sa2 driver to use PnP BIOS device detection/registration,
in order to load "automagically" the module without specifying the io/dma/irq
stuff on my system that do not support ISA PnP.

So, for compatibility, I end up using both ISA and BIOS PnP functions. I've got
to handle all the configuration cases (CONFIG_ISAPNP/CONFIG_BIOSPNP). I first
try with ISA, if it fails then I try with BIOS, then I've got to remind what
method (ISA or BIOS) was used in order to correctly unload/remove the driver
by calling the correct isapnp_ or pnpbios_ functions. And I had to duplicate
all the isapnp functions/struct to pnpbios equivalent.

So I'd like to know what do you think about making a generic PnP layer that
would "hide" and automatically select to use ISA or BIOS functions ?

The driver code would use the "generic PnP" functions without checking all
the configuration cases. And the "generic PnP" layer would decide if it
uses ISA or BIOS and make/forward the correct calls.

This way, we could write drivers that would work indifferently with ISA PnP
or BIOS PnP. If the system support ISA PnP, then the "generic" PnP
layer would use ISA functions, and if the system support only BIOS PnP then
it would use BIOS functions.

Is the "new driver model" from P. Mochel supposed to do this ? or is it just
for PCI devices ?

-- 


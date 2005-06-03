Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261188AbVFCATM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261188AbVFCATM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 20:19:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261462AbVFCATL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 20:19:11 -0400
Received: from hobbit.corpit.ru ([81.13.94.6]:35931 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S261188AbVFCATD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 20:19:03 -0400
Message-ID: <429FA1F3.9000001@tls.msk.ru>
Date: Fri, 03 Jun 2005 04:18:59 +0400
From: Michael Tokarev <mjt@tls.msk.ru>
Organization: Telecom Service, JSC
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: castet.matthieu@free.fr
CC: linux-kernel@vger.kernel.org
Subject: Re: PNP parallel&serial ports: module reload fails (2.6.11)?
References: <20050602222400.GA8083@mut38-1-82-67-62-65.fbx.proxad.net>
In-Reply-To: <20050602222400.GA8083@mut38-1-82-67-62-65.fbx.proxad.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

castet.matthieu@free.fr wrote:
> Reply-To: 429CECE3.1060904@tls.msk.ru

This looks like a Message-ID of my original email you're replied to.
Why you set up Reply-To header this way? :)

> Hi,
> 
> try pnpacpi=off in your kernel options and it should work.
> An other solution is to comment pnpacpi_disable_resources in
> drivers/pnp/pnpacpi/core.c in order to avoid that the resource are
> disable.

Both ways solves this problem for me.  Now I can insmod/rmmod
parport_pc as many times as I want:

parport: PnPBIOS parport detected.
parport0: PC-style at 0x378, irq 7 [PCSPP]
pnp: Device 00:0b disabled.
pnp: Device 00:0b activated.
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378, irq 7 [PCSPP]
pnp: Device 00:0b disabled.
pnp: Device 00:0b activated.
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378, irq 7 [PCSPP]
....

BTW, how "stable" pnpacpi=off is?  I mean, is it supposed to
work on more hardware than current default acpi-aware method?

> When booting, the parport resources are enable by your kernel, and when
> you load for the first time the module there nothing to activate.
> 
> But when you rmmod the driver, you free the resource.

Well, I figured this much ;)

> And pnpacpi have some problem to activate resource with some strange acpi implementation...

I haven't seen any probs with acpi or bios or other things on
those boxen yet -- pretty good ones.  It's HP ProLiant ML150
machine (not G2).  There are other HP machines out here which
also shows the same problem - eg HP ProLiant ML310 G1.

> There was a problem in pnp layer implementation : the resource weren't
> given in the right order, Adam Belay send me a patch, but I don't know
> if it got in main-line ?

Which patch was that?  I can try it here, but can't seem to be able
to find it...

> May be there also a bug in pnpacpi_encode_resources (with the pnp patch
> apply I didn't still work on some hardware...)
> 
> You can try to send your dsdt, but I am quit busy for the moment.
> May be some Intel guy could look at the problem...

The DSDTs are at http://www.corpit.ru/mjt/hpml150.dsdt
and http://www.corpit.ru/mjt/hpml310.dsdt (that's a
(binary) copy from /proc/acpi/dsdt -- is there a way
to decode it into some text form?)

Thank you for your time.  At least I now know I'm not
alone with this prob.. ;)

/mjt

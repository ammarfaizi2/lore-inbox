Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265215AbTIIXST (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 19:18:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265224AbTIIXST
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 19:18:19 -0400
Received: from fw.osdl.org ([65.172.181.6]:14256 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265215AbTIIXRO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 19:17:14 -0400
Date: Tue, 9 Sep 2003 16:23:49 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise
To: Pavel Machek <pavel@suse.cz>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Jens Axboe <axboe@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PM] Passing suspend level down to drivers
In-Reply-To: <20030909230755.GG211@elf.ucw.cz>
Message-ID: <Pine.LNX.4.44.0309091615400.695-100000@cherise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I'd not worry about runtime states for now. [If user wants to sleep
> one device, we probably can allow that, but I do not think it is
> reasonable to do much more for 2.6.X]. That leaves us with:

We've always supported runtime states. There is just no drivers which 
support it. 

> APM suspend-to-ram
> APM suspend-to-disk
> ACPI standby (S1)
> ACPI suspend-to-ram (S3)
> ACPI suspend-to-disk (S4bios)
> swsusp
> 
> Do we want to support ACPI S2? I don't think so. That list is not
> *that* bad.

ACPI S2 is irrelevant. Nonetheless, you're suggesting that we add manual 
checks at runtime for each device to determine what state to go into, 
depending on whether the system is entering suspend-to-disk or suspend-to-
ram. 

That's a bad idea because:

- It doesn't need to be done at runtime, only initialization. Though it's 
  not a permformant path, it's still more efficient to do it once only. 

- It forces policy into the drivers, instead of having them specify a 
  changeable default. 

- It can only be changed by editing and recompiling the driver, unless 
  they manually export the variable. 

> Yes, but you'll have to have central database saying "nvidia VGA needs
> to be in D1 during S3". I don't think that's good idea. Better put it
> into the driver... Hopefully not many drivers will need such hacks.

No, read the first email on this subject. You can have the bus do it for 
all devices of a certain type (e.g. IDE), or you can have the drivers do 
it when they're bound to specific devices. 


	Pat


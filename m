Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265067AbTIIXIO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 19:08:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265069AbTIIXIO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 19:08:14 -0400
Received: from gprs149-34.eurotel.cz ([160.218.149.34]:5504 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S265067AbTIIXIK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 19:08:10 -0400
Date: Wed, 10 Sep 2003 01:07:55 +0200
From: Pavel Machek <pavel@suse.cz>
To: Patrick Mochel <mochel@osdl.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Jens Axboe <axboe@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PM] Passing suspend level down to drivers
Message-ID: <20030909230755.GG211@elf.ucw.cz>
References: <20030909225410.GD211@elf.ucw.cz> <Pine.LNX.4.44.0309091604070.695-100000@cherise>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0309091604070.695-100000@cherise>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I do think this is a bit complicated. I believe passing level, along
> > with type of the suspend (aka swsusp vs. S4bios) should be enough.
> 
> What about suspend-to-ram, APM, and runtime states?

I'd not worry about runtime states for now. [If user wants to sleep
one device, we probably can allow that, but I do not think it is
reasonable to do much more for 2.6.X]. That leaves us with:

APM suspend-to-ram
APM suspend-to-disk
ACPI standby (S1)
ACPI suspend-to-ram (S3)
ACPI suspend-to-disk (S4bios)
swsusp

Do we want to support ACPI S2? I don't think so. That list is not
*that* bad.

> That actually makes it quite a bit more complicated, globally. By forcing 
> the policy down to the drivers, you force each one to interpret the value 
> themselves and make the decision. By doing it centrally, the only thing 
> the low-level drivers have to worry about is going into the state. 

Yes, but you'll have to have central database saying "nvidia VGA needs
to be in D1 during S3". I don't think that's good idea. Better put it
into the driver... Hopefully not many drivers will need such hacks.
 
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]

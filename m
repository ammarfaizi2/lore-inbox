Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750902AbWBCO25@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750902AbWBCO25 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 09:28:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750904AbWBCO25
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 09:28:57 -0500
Received: from clix.aarnet.edu.au ([192.94.63.10]:40343 "EHLO
	clix.aarnet.edu.au") by vger.kernel.org with ESMTP id S1750902AbWBCO24
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 09:28:56 -0500
Message-ID: <43E36850.5030900@aarnet.edu.au>
Date: Sat, 04 Feb 2006 00:57:28 +1030
From: Glen Turner <glen.turner@aarnet.edu.au>
Organization: Australia's Academic & Research Network
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: 8250 serial console fixes -- issue
References: <Pine.LNX.4.44.0602011911360.22854-100000@gate.crashing.org> <1138844838.5557.17.camel@localhost.localdomain> <43E2B8D6.1070707@aarnet.edu.au> <20060203094042.GB30738@flint.arm.linux.org.uk>
In-Reply-To: <20060203094042.GB30738@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDSA: Yes
X-Spam-Score: -104.901 BAYES_00,USER_IN_WHITELIST
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Russell,

Thanks for your response.

 > A normal user can't produce arbitarily formatted
 > kernel messages

They don't need to provide an entire message, just a
AT string (a vector which a user could control
could be a volume label on removable media).

 > You'd rather we threw away these messages?

When option 'r' is set, yes.  Because Data Carrier Detect
is not asserted there can't be anything that is going to
read the messages.  All we are doing is taking a long
time to drop each character off the end of the serial
cable.

Since the kernel takes a very long time to boot with
the 'r' option and no attached console the current
situation isn't correct.

There's one very nasty practical effect.  Hayes modems
hang up if any character is typed during the interval
between off-hook and Data Carrier Detect (ie, the negotiation
period where the speaker outputs the tones).  If you're
continually writing console messages (say from a failing
disk) then you can't successfully dial in to read the
messages to find out why the machine is hosed.

> It'd help if you talked to the right person - I've been looking after
> the serial layer since 2.5.something.

See my e-mail to you of 2003-10-21, which started:

   Hi Russell,

   I have ported the patch which fixes all kernel bugs
   reported to me as the maintainer of the "Remote Serial
   Console HOWTO" from 2.4 to Linus's BitKeeper (2.6.0-test8).

and contained the patch at

   <http://www.aarnet.edu.au/~gdt/patch/console/serial-console.patch>

The previous patch of 2002-10-13 gave a much longer description
of the bugs and fixes:

   [PATCH] 0/3 Fix serial console flow control
   <http://www.ussg.iu.edu/hypermail/linux/kernel/0210.1/1790.html>

   [PATCH] 1/3 Fix serial console flow control, serial.c
   <http://www.ussg.iu.edu/hypermail/linux/kernel/0210.1/1791.html>

As I said earlier I'm happy to once more forward-port the
patch, test it and present it using the current version control
system as long as the effort is worth doing.

Regards,
Glen

-- 
  Glen Turner         Tel: (08) 8303 3936 or +61 8 8303 3936
  Australia's Academic & Research Network  www.aarnet.edu.au

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264686AbRFQEEZ>; Sun, 17 Jun 2001 00:04:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264687AbRFQEEP>; Sun, 17 Jun 2001 00:04:15 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:4356 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S264686AbRFQEEN>;
	Sun, 17 Jun 2001 00:04:13 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200106170403.f5H43x869307@saturn.cs.uml.edu>
Subject: Re: 2.4.2 yenta_socket problems on ThinkPad 240
To: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Sun, 17 Jun 2001 00:03:59 -0400 (EDT)
Cc: jgarzik@mandrakesoft.com (Jeff Garzik), eric@brouhaha.com (Eric Smith),
        linux-kernel@vger.kernel.org, torvalds@transmeta.com (Linus Torvalds),
        alan@lxorguk.ukuu.org.uk (Alan Cox), arjanv@redhat.com, mj@ucw.cz
In-Reply-To: <E15BG4h-000842-00@the-village.bc.nu> from "Alan Cox" at Jun 16, 2001 02:25:15 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox writes:
> [lost]

>> I would love to just define it unconditionally for x86, but I
>> believe Martin said that causes problems with some hardware, and
>> the way the BIOS has set up that hardware.  (details anyone?)
>
> Im not sure unconditionally is wise. However turning it into a
> routine that walks the PCI bus tree and returns 1 if a duplicate
> is found seems to be a little bit less likely to cause suprises

That could hurt.

I have a device that can serve as a bridge, and also as a
network card. Sometimes the bridge feature is not used, so
the bus numbers get set to 0xfd, 0xfe, 0xff or just all 0xff.
Multiple cards get the same values just to keep them out of
the way.

(this is a PCI-over-network thing)

Depending on EEPROM config data, it might not have a bridge
class code at boot. It has to be turned into a bridge via config
space writes though, so that the network feature will work.
This means I need to allocate some bus numbers after boot,
perhaps renumbering other bridges to make room. (BTW if there
is an API for this that I missed, please let me know)

In case I do want to really use the bridge feature, there is
a little bug to deal with. The primary bus number must be set
equal to the secondary bus number. No problem I hope?

Right now Linux seems happy, with lspci complaining a bit.

If the generic code were to "fix" my bus number assignment,
all Hell would break loose.

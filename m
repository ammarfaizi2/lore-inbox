Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315427AbSHXJE1>; Sat, 24 Aug 2002 05:04:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315430AbSHXJE1>; Sat, 24 Aug 2002 05:04:27 -0400
Received: from AMarseille-201-1-2-125.abo.wanadoo.fr ([193.253.217.125]:6000
	"EHLO zion.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S315427AbSHXJE0>; Sat, 24 Aug 2002 05:04:26 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Andre Hedrick <andre@linux-ide.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       "Heater, Daniel (IndSys, GEFanuc, VMIC)" <Daniel.Heater@gefanuc.com>,
       "'Padraig Brady'" <padraig.brady@corvil.com>,
       "'Linux Kernel'" <linux-kernel@vger.kernel.org>
Subject: Re: IDE-flash device and hard disk on same controller
Date: Sat, 24 Aug 2002 02:19:19 +0200
Message-Id: <20020824001919.9768@192.168.4.1>
In-Reply-To: <3D66E944.9080507@mandrakesoft.com>
References: <3D66E944.9080507@mandrakesoft.com>
X-Mailer: CTM PowerMail 3.1.2 carbon <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Well... x86 PCs with ordinary BIOSes did. Other firmwares,
>> embedded devices, whatever.... may not, or eventually the firmware
>> will have reset everything prior to booting the kernel (go figure
>> why, but that happens).
>> 
>> It's not difficult nor harmful to wait for that dawn busy bit to
>> go away, so why not do it ?
>
>
>Basically think about the consequences of trying to handle a completely 
>unknown state -- if you are going to attempt to handle this you would 
>need to check for data, not just the BSY bit.  And read the data into a 
>throwaway buffer, if there is data to be read, or write the data it's 
>expecting.
>
>So it's not just the busy bit :)

But are we dealing with completely unknown states ? That's not
what I'm saying. We are dealing with:

 - Hotswap in (pcmcia, ...)
 - Firmware that don't wait after reset
 - Interfaces (like ide-pmac) that hard reset the disk
 - no POST code (power-on reset)

A completely unknown state doesn't work today and I don't think
we should really care about it. If an arch wants to deal with
such a state (which is +/- the  case of ide-pmac when booting
from MacOS), then that arch has to do the specifics of dealing
with that (in ide-pmac case, tggling the hard reset line of
the drive).

So I still think it would make sense to wait. Now, what I
suggested to Andre on IRC is that we could eventually make
that wait conditional on some HWIF flag set by the arch
(or rather the HBA driver) if you really don't want to do it in
the generic case.

Ben.


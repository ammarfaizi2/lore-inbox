Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289516AbSAOM2l>; Tue, 15 Jan 2002 07:28:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289517AbSAOM2a>; Tue, 15 Jan 2002 07:28:30 -0500
Received: from eventhorizon.antefacto.net ([193.120.245.3]:26322 "EHLO
	eventhorizon.antefacto.net") by vger.kernel.org with ESMTP
	id <S289516AbSAOM2C>; Tue, 15 Jan 2002 07:28:02 -0500
Message-ID: <3C441F2A.50203@antefacto.com>
Date: Tue, 15 Jan 2002 12:23:06 +0000
From: Padraig Brady <padraig@antefacto.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011226
X-Accept-Language: en-us
MIME-Version: 1.0
To: Matt_Domsch@Dell.com
CC: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
        nils@kernelconcepts.de, giometti@ascensit.com, pb@nexus.co.uk,
        chowes@vsol.net, gorgo@itc.hu, info@itc.hu, lethal@chaoticdreams.org,
        woody@netwinder.org, johnsonm@redhat.com
Subject: Re: [CFT][PATCH] watchdog nowayout and timeout module parameters
In-Reply-To: <71714C04806CD5119352009027289217022C4115@ausxmrr502.us.dell.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt_Domsch@Dell.com wrote:

>>Timeout has been moved to an ioctl more by other diffs so Im not sure
>>timeout= is too important
>>
> 
> Of the seven drivers I added this parm to, six do not offer such a method
> via ioctl:
> eurotechwdt.c provides WDIOC_SETTIMEOUT.


And was the first to provide it:
http://marc.theaimsgroup.com/?l=linux-kernel&m=100619600900700&w=2


> acquirewdt.c, advantechwdt.c, ib700wdt.c, pcwd.c, wdt.c, wdt_pci.c do not
> provide a set timeout ioctl.


I think all should? As it would be nice/more consistent for all


> 
> These already offer a timeout parm, but no set timeout ioctl:
> i810-tco.c, softdog.c, wdt285.o
> 
> The other drivers I didn't add timeout parm to anyhow, but they don't have a
> set timeout ioctl either:
> machzwd.c, mixcomwd.c, shwdt.c, wdt977.c


new version of wdt977 in patch does provide WDIOC_SETTIMEOUT


> 
> Unless there are strong objections or a push to make it an ioctl everywhere
> instead/also, I'd like to leave it in.


Personally I'm undecided whether param or ioctl is preferable.

I don't think many would need to change the timeout parameter
at runtime, but if you do it's a pain to reload the module,
so I vote for providing both interfaces?


> 
>>Rest looks good
>>
> 
> Thanks for reviewing and approving.  14 drivers modified, 5 drivers
> approved, one investigating, two email addresses invalid, leaving 6 to hear
> from.
> 
> -Matt

What about the following though?

cpwatchdog.c
riowatchdog.c
sbc60xxwdt.c

Actually I think there should be a drivers/char/watchdog directory ?
(there are now around 18 seperate watchdog drivers).
Then the out of date watchdog.txt could be updated to point users
at this directory to see what's available, rather than the current
out of date list:

	ICS	WDT501-P
	ICS	WDT501-P (no fan tachometer)
	ICS	WDT500-P
	Software Only
	SA1100 Internal Watchdog
	Berkshire Products PC Watchdog Revision A & C (by Ken Hollis)

ALso I've drivers here for {IBASE, Portwell} SBC watchdogs.
[Who] will I submit them to?

cheers,
Padraig.


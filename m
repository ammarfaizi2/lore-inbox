Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261661AbSKOAsx>; Thu, 14 Nov 2002 19:48:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261836AbSKOAsx>; Thu, 14 Nov 2002 19:48:53 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:35852 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261661AbSKOAsv>;
	Thu, 14 Nov 2002 19:48:51 -0500
Message-ID: <3DD445EF.9080002@pobox.com>
Date: Thu, 14 Nov 2002 19:55:11 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20021018
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christian Guggenberger 
	<christian.guggenberger@physik.uni-regensburg.de>
CC: rl@hellgate.ch, linux-kernel@vger.kernel.org,
       Mikael Pettersson <mikpe@csd.uu.se>, mingo@redhat.com
Subject: Yet another IO-APIC problem (was Re: via-rhine weirdness with via
 kt8235 Southbridge)
References: <20021115002822.G6981@pc9391.uni-regensburg.de> <20021115011738.D17058@pc9391.uni-regensburg.de>
In-Reply-To: <20021115002822.G6981@pc9391.uni-regensburg.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Guggenberger wrote:

> >On Wed, 23 Oct 2002 15:49:31 +0200, Christian Guggenberger wrote:
> >
> >>This concerns both 2.4 and 2.5 kernels  (testet with 2.4.20pre*aa 
> series,
> >>and with 2.5.43, 2.5.44 and 2.5.44-ac1):
> >>
> >>When I enable APIC in the Bios, the via-rhine module will insert
> >>properly, but I won't get a link... With APIC disabled, link is ok.  Ok,
> >>this could be caused by buggy bios, so I'll try again, when a new
> >>biosversion is available.
> >
> >Yeah, it seems there's a problem with IO-APICs. I currently don't have a
> >machine with IO-APIC for testing, though, so...
> >
>
>
> A new Biosversion is installed on my mobo now, but that APIC problem 
> is still
> there.
> Are there some dumps I could post to get some light on that topic?
>
> Maybe some outputs of via-diag, mii-diag, lspci, dmesg ...?
> If they could help, what options should I pass to mii-diag and via-diag ?



Yet Another IO-APIC problem.  From what I see quoted above, it has 
nothing at all to do with the via-rhine, and everything to do with IO-APIC.

Almost universally, in 2.4 and 2.5, running IO-APIC on uniprocessor is 
badly broken, and causes all sorts of bogus bug reports for unrelated 
subsystems.  Sometimes IO-APIC is busted even on SMP.

Workaround solutions:  (1) boot with "noapic" on command line, (2) 
disable IO-APIC in kernel config (if uniprocessor), and/or (3) make sure 
that "MP 1.1" is listed in BIOS setup instead of "MP 1.4".

Man, this must be the fourth or fifth bug report I've gotten in the past 
week or so, where the IO-APIC can be blamed.  ;-(  In all recent cases 
it has been uniprocessor IOAPIC, not SMP IOAPIC, that was problematic. 
IMO we should just take out UP IOAPIC support in the kernel, or put a 
big fat warning in the kernel config _and_ at boot...

	Jeff



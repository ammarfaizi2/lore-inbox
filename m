Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271677AbRH0J0W>; Mon, 27 Aug 2001 05:26:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271678AbRH0J0N>; Mon, 27 Aug 2001 05:26:13 -0400
Received: from fmfdns02.fm.intel.com ([132.233.247.11]:59102 "EHLO
	thalia.fm.intel.com") by vger.kernel.org with ESMTP
	id <S271677AbRH0J0A> convert rfc822-to-8bit; Mon, 27 Aug 2001 05:26:00 -0400
Message-ID: <4148FEAAD879D311AC5700A0C969E89006CDE0B7@orsmsx35.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'Jan Niehusmann'" <jan@gondor.com>,
        =?iso-8859-1?Q?Dieter_N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        "'mpet@bigfoot.de'" <mpet@bigfoot.de>
Subject: RE: VCool - cool your Athlon/Duron during idle
Date: Mon, 27 Aug 2001 02:26:09 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well I don't want to inhibit your hackerly fervor, but C2 and C3 handling
are already supported by the ACPI driver, in a vendor-neutral manner.

If you take a look at the code, you will notice a few things. First, it only
transitions to a deeper sleep state after doing some number of lighter
sleeps. This is to minimize the performance hit caused by C2/C3 entry and
exit latencies. Second, it only uses a given processor power state if the
system's ACPI tables indicates they can be used. If you are attempting to
use C2 even if your system explicitly does not support it, you are asking
for trouble, just like AMD's errata says.

Besides I'd think any cooling issues would occur when the CPU was 100%
utilized, yes? Why are you trying to optimize the idle loop for power when
it's not the problem? You can throttle the processor or turn a fan on to
handle a too-hot cpu, but all C2/C3 gets you is reduced power when idle.
This results in better battery life on a laptop but that is irrelevant on a
desktop system.

Regards -- Andy

> -----Original Message-----
> From: Jan Niehusmann [mailto:jan@gondor.com]
> Sent: Sunday, August 26, 2001 4:01 PM
> To: Dieter Nützel
> Cc: Alan Cox; Linux Kernel List
> Subject: Re: VCool - cool your Athlon/Duron during idle
> Importance: High
> 
> 
> On Sun, Aug 26, 2001 at 08:09:34PM +0200, Dieter Nützel wrote:
> > Have you read something about this Athlon/Duron cooling problem?
> > Can this code included into your (and/or the official) tree?
> 
> I haven't yet measured if this really saves a significant amount of
> power, but I made a kernel patch closely based on the vcool patch
> from http://www.naggelgames.de/vcool/
> 
> This patch is extremely experimental, but it didn't crash my 
> machine, yet ;-) Some things could probably be more elegant.
> 
> Feel free to comment or use this patch as you like.
> It does only use stpclk if you boot with idle=stpclk
> 
> Jan

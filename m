Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290697AbSAYPdF>; Fri, 25 Jan 2002 10:33:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290706AbSAYPcs>; Fri, 25 Jan 2002 10:32:48 -0500
Received: from gumby.it.wmich.edu ([141.218.23.21]:33666 "EHLO
	gumby.it.wmich.edu") by vger.kernel.org with ESMTP
	id <S290697AbSAYPci>; Fri, 25 Jan 2002 10:32:38 -0500
Subject: Re: [patch] amd athlon cooling on kt266/266a chipset
From: Ed Sweetman <ed.sweetman@wmich.edu>
To: Liakakis Kostas <kostas@skiathos.physics.auth.gr>
Cc: Dieter =?ISO-8859-1?Q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>,
        Daniel Nofftz <nofftz@castor.uni-trier.de>,
        Vojtech Pavlik <vojtech@suse.cz>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.21.0201251535520.11551-100000@skiathos.physics.auth.gr>
In-Reply-To: <Pine.GSO.4.21.0201251535520.11551-100000@skiathos.physics.auth.gr>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 25 Jan 2002 10:31:51 -0500
Message-Id: <1011972717.22707.42.camel@psuedomode>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-01-25 at 09:17, Liakakis Kostas wrote:
> 
> Hi,
> 
> I have been watching this thread for a while now. I am surprised everybody
> is happy with the temperature drops they get and don't look a bit
> further. I might be sounding like a *ickhead but here go my .02 euros:
> 
> With STOPGNT enabled, the disconnection happens by the northbridge
> actually halting the FSB for the CPU until the next interrupt. The
> continuous dis/reconnection causes increased lattency on the PCI bus and
> strictly timed PCI transfers needed by TV-Tuner cards/software or sound
> software suffer greatly from this. It also results in poorer hd
> performance.
>  
> Also with such a power hungry CPU as the Athlon, bus dis/reconnection
> results in current demand changing from 40A to 5A to 40A ... every few ms.
> This puts your motherboards' voltage regulator under unecessary strain as
> well those in your PSU.
> 
> Furthermore, CPUs do like lower operating temperatures, but even more they
> like constant temperatures. Differences like 10-15C every now and then
> (load/idle) put the cpu die under mechanichal strain from thermal
> contraction/expansion.
> 
> Finally, this procedure can actually *hide* severe cooling inefficiency of
> the system. People seem to go with the moto: STOPGNT lowers my
> temperature, so it is a good thing. Well, it doesn't. Run SETI@HOME and
> you are back where you started. It can take only a hot summer day and you
> have a fried chip.
> 
> There was a thought by somebody, that you should only enable disconnection
> after some time of inactivity. This sounds better, but then, don't we 
> have S1/S3 for this already?
> 
> This feature of the AMD processors seemed like a real bargain once but
> now, I doupt there is one motherboard vendor out there that allows you to
> control it in the BIOS (like they used too). Even more, they suggest you
> leave this feature alone. A walk in troubleshooting/support forums
> suggests the same: It is a feature you can do without, you'd be better off
> with a cooler that can cool and a well ventilated case.
> 
> Sorry for the length,
> 
> -Kostas
> 

I was getting at this earlier. Though the Athlon XP's are much better
power-wise than the earlier athlon's.  I wouldn't suggest doing it to
any athlon under XP. But then again, the XP is supposed to have
something similar to clock stepping to gradually move from full power to
lower power, which decreases mechanical stress and psu stress.  I
remember when the same concerns were brought over the HLT idle trick but
obviously the HLT instruction isn't harmful enough.  Would be nice to
look at the latencies with say, Robert Love's preempt stat patch of a
kernel running with no power management, then with HLT, then with the
vcl patch.

Nice rule of thumb though.   If your cpu _ever_ gets into the 50C range
your case and or hsf is not efficient enough for your hardware. Anything
above 50 and you're shortening the life of the cpu. Relying on idle
tricks isn't going to help you.  

I'd recommend this patch for Athlon XP's since they're the only chips
that have motherboards built to handle this kind of thing (assuming you
didn't buy some cheap brand). Don't use it on anything earlier. Not that
I dont believe that the chip can take the punishment, but I dont believe
that the motherboard and cpu can if not built to XP specifications.  





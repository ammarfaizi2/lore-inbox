Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266460AbSKORTc>; Fri, 15 Nov 2002 12:19:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266480AbSKORTb>; Fri, 15 Nov 2002 12:19:31 -0500
Received: from roc-24-169-118-30.rochester.rr.com ([24.169.118.30]:54445 "EHLO
	death.krwtech.com") by vger.kernel.org with ESMTP
	id <S266460AbSKORTW>; Fri, 15 Nov 2002 12:19:22 -0500
Date: Fri, 15 Nov 2002 12:26:10 -0500 (EST)
From: Ken Witherow <ken@krwtech.com>
X-X-Sender: ken@death
Reply-To: Ken Witherow <ken@krwtech.com>
To: David Crooke <dave@convio.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Dual athlon XP 1800 problems
In-Reply-To: <3DD4CD06.2010009@convio.com>
Message-ID: <Pine.LNX.4.44.0211151210140.1153-100000@death>
Organization: KRW Technologies
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 1. When I first put it together, it would consistenly run OK for a
> period of 4-5 minutes, quite precisely - no less than 4, no more than 5
> and then just lock up HARD - no Ctrl-Alt-Del, no kernel panics, nothing.
> Once or twice it seemed like it stuttered - as if the load was like
> 10.00 or higher, the keystroke echo would take 2-3 seconds.
>
> 2. First try - I pulled the Tekram (it's ancient and has bootable BIOS)
> - no difference
>
> 3. Tried some BIOS settings (e.g. SMP 1.1 mode) - it DOES NOT like this;
> any BIOS changes AT ALL (even seemingly harmless ones like Num Lock)
> appear to mess it up totally, and LILO hangs at "LI" when trying to
> start. Restored factory defaults.

I have a S2460 with dual 1800MPs using BIOS rev 1.04. I had very similar
problems (random hangs, sometimes after 2 minutes, sometimes after 36
hours). Here's what I did to solve them:

1) Turn off power management in the BIOS. I still have power management
enabled in linux and all is fine.

2) (this is the most important one) Make sure you have a minimum of a 500
watt power supply. Each CPU alone is rated for 66 watts of consumption.

3) I still get random hangs at boot (usually after rebooting linux) and I
believe this is due to some ACPI problem. A hard reboot (turn the power
supply off and on) fixes it for me.

4) There are a couple bugs with the 760MP chipset and APICs. To see if
they're affecting you, add "mem=nopentium noapic" to your kernel
parameters (I can run fine without them).

> 4. Then I noticed that the CPU1 heatsink was quite warm (maybe 70C
> feeling around the thick bit of the aluminium) whereas CPU0 heatsink is
> just above room temp.
>
> 5. Checking the Winbond monitoring in the BIOS** menu, it comes up
> showing both CPU's at 77C, then as you hit keys it takes proper
> readings, and claims both CPUs within 1-2 degrees of each other (??). It
> seems accurate on fan speeds though. Both fans running pretty fast,
> 5500-6200 RPM.

My BIOS reports the right temps but lm_sensors didn't. I too was getting
temps in the 75C+ range. To fix lm_sensors, do the following:

echo "2" > /proc/sys/dev/sensors/w83782d-i2c-0-2d/sensor1
echo "2" > /proc/sys/dev/sensors/w83782d-i2c-0-2d/sensor2
echo "2" > /proc/sys/dev/sensors/w83782d-i2c-0-2d/sensor3

> 7. Brought it up to single user mode console, to see if it was video
> card etc. - did some testing of just letting it mostly idle (while true
> - uptime - sleep 1 - etc.) and locked up 1-2 more times.

I thought it was my video card too... so I went out and spent $90 on a new
one only to find it does the same thing.

> 8. Rebooted again, now it's up and running and appears stable (still 1
> CPU), so I took it up to full init 5 and it stayed up (and so I'm
> writing this email :-)  Once or twice seemed to stall again for 1-2
> seconds (interrupt storm ???) but recovered.

I notice this sometimes too... I chalk it up to some SMP locking
somewhere. Currently up 6 days, 3:53 with the maximum around 40 days
(rebooted to upgrade kernel).

> Other observation, possibly unrelated: the unpacking of the kernel seems
> very slow for an otherwise pretty quick machine - the dots when it says
> "Loading xxx..." tick at about 1 per second, much like a laptop with
> PC-66 memory, compared with 4-5 per second for the Pentium III
> 800/PC-133 motherboard I just hauled out.

When mine hasn't reset right (the aforementioned ACPI lockup), mine does
this. It was especially prevalent before I upgraded my power supply from
400 to 550 watts

> ** The temperature sensor driver stuff didn't seem to come with the
> kernel ??

pick up the lm_sensors package

-- 
       Ken Witherow <phantoml AT rochester.rr.com>
           ICQ: 21840670  AIM: phantomlordken
               http://www.krwtech.com/ken



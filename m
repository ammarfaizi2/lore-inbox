Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266615AbSKORgw>; Fri, 15 Nov 2002 12:36:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266623AbSKORgw>; Fri, 15 Nov 2002 12:36:52 -0500
Received: from dgesmtp01.wcom.com ([199.249.16.16]:49902 "EHLO
	dgesmtp01.wcom.com") by vger.kernel.org with ESMTP
	id <S266615AbSKORgl>; Fri, 15 Nov 2002 12:36:41 -0500
Date: Fri, 15 Nov 2002 11:40:39 -0600
From: steve roemen <steve.roemen@wcom.com>
Subject: RE: Dual athlon XP 1800 problems
In-reply-to: <Pine.LNX.4.44.0211151210140.1153-100000@death>
To: "'Ken Witherow'" <ken@krwtech.com>, "'David Crooke'" <dave@convio.com>
Cc: linux-kernel@vger.kernel.org
Reply-to: steve.roemen@wcom.com
Message-id: <005801c28cce$1d6e6180$e70a7aa5@WSXA7NCC106.wcomnet.com>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V4.72.3719.2500
X-Mailer: Microsoft Outlook 8.5, Build 4.71.2173.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7bit
Importance: Normal
X-Priority: 3 (Normal)
X-MSMail-priority: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i had similar issues on my old 2460 board.

i found out that a huge power supply doesn't cut it, you need a QUALITY
power supply of ~400watts( more specifically the 5 volt bus).

i also found out the hard way that i believe tyan didn't design that board
properly because the 5 volt part of the connectors were burned up on the PS
and MB.

i've since replaced with a s2466n-4m  and am very happy.

i'd check your power supply connector before it burns up yours too...

-steve

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Ken Witherow
Sent: Friday, November 15, 2002 11:26 AM
To: David Crooke
Cc: linux-kernel@vger.kernel.org
Subject: Re: Dual athlon XP 1800 problems


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


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262355AbTJISuM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 14:50:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262365AbTJISuM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 14:50:12 -0400
Received: from pop.gmx.net ([213.165.64.20]:24460 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262355AbTJISuG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 14:50:06 -0400
X-Authenticated: #7204266
Date: Thu, 09 Oct 2003 19:50:10 +0100
To: linux-kernel@vger.kernel.org
Subject: Horrible ordeals with ACPI, APIC and HIGHMEM (2.6.0-test* and -ac kernels)
From: Martin Aspeli <optilude@gmx.net>
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <oprwsg9wfc9y0cdf@mail.gmx.net>
User-Agent: Opera7.20/Win32 M2 build 3144
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

First off, sorry for not being subscribed to the list (my mail provider 
would kill me), so please CC answers. I will of course check the archives. 
I've tried to search and ask elsewhere... LKML is my last resort! Any help 
at all would be greatly appreciated!

Hardware: Evesham Voyager Xi (which is really a Mitac M3000N); 1.6GHz 
Centrino with 1GB RAM. ACPI, all the RAM and everything else works fine in 
Windows XP, and it's brand new, so I doubt there are any hardware 
problems. BIOS is by AMI and claims to be v02.33, from March 2003, no 
update available from OEM. Standard intel chipset with onboard sound 
(i8x0) and 855 graphics.I'm trying to do a fresh install of Gentoo.

I've been trying the 2.6.0-test kernels, mostly for the speedstep support 
(which appears to work). However, when I put ACPI in the kernel, all goes 
wrong. Without ACPI, half my hardware is left IRQ-less. These are the 
symptoms:

1. ACPI enabled + Local APIC disabled: System boots fine, but as soon as 
ACPI goes on, the fan starts blowing full speed. When I try to log in 
performance is very sluggish. Top shows a process "events/0" (what is 
this?) that is eating 99.9% of my CPU (is this why the fan comes on?). 
Constant disk access (probably swap, but it did continue after I did 
"swapoff -a").

2. ACPI + APIC + APIC-IO enabled, HIGHMEM disabled: System freezes on boot 
immediately after loading ACPI subsystem.

3. Same as 2 + HIGHMEM (4GB) enabled: System reboots immediately after 
loading ACPI subsystem.

4. Same as 1 (no HIGHMEM) but with "acpi=off" on command line: System 
boots and runs fine. Obviously no battery monitor, but I can live without. 
However, a lot of my hardware (particularly the sound card, but I think 
maybe also the graphics) try to get assigned to IRQ 0 and fail, so they do 
not get configured. BIOS appears to regulate fan.

Also, in any configuration, if HIGHMEM is enabled and I pass acpi=off to 
get the system to boot, performance is absolutely appalling - it takes 
about 10 minutes to get to the login prompt! I can't see anything 
obviously wrong (speedfreq and uname -a detect all 1600MHz, top shows no 
obviously astray processes, although top itself is taking about 10-15% CPU 
just by being there).

Apart from complaints about IRQ 0 for various devices, I see nothing 
obviously wrong in dmesg or anywhere else.

Please don't condemn me to a life of Windows XP! I'm willing to live 
without ACPI if I could get my soundcard and other hardware (I can't see 
what it is, all I get are the id numbers) to work; I could also live with 
the ~800Mb or RAM left if HIGHMEM is off, but it's just annoying not to 
use those last ~200Mb.

Main question, I guess - what is events/0 and why is it bent on screwing 
up my life?

Best wishes,
Martin

-- 
Using M2, Opera's revolutionary e-mail client: http://www.opera.com/m2/

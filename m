Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265468AbUBFOq3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 09:46:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265470AbUBFOq2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 09:46:28 -0500
Received: from nsmtp.pacific.net.th ([203.121.130.117]:8612 "EHLO
	nsmtp.pacific.net.th") by vger.kernel.org with ESMTP
	id S265468AbUBFOqZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 09:46:25 -0500
From: Michael Frank <mhf@linuxmail.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: 2.4.25-rc1: BUG: wrong zone alignment, it will crash
Date: Fri, 6 Feb 2004 22:45:25 +0800
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <200402061735.07726.mhf@linuxmail.org> <Pine.LNX.4.58L.0402061143280.16422@logos.cnet>
In-Reply-To: <Pine.LNX.4.58L.0402061143280.16422@logos.cnet>
X-OS: KDE 3 on GNU/Linux
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402062245.25651.mhf@linuxmail.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 06 February 2004 21:44, Marcelo Tosatti wrote:
> 
> On Fri, 6 Feb 2004, Michael Frank wrote:
> 
> > As with 2.4.24, using the highmem option causes the BUG message.
> >
> > This is a kernel ex BK without any patches.
> >
> > Linux version 2.4.25-rc1 (root@mhfl4) (gcc version 2.95.3 20010315 (release)) #5 Fri Feb 6 17:27:18 HKT 2004
> > BIOS-provided physical RAM map:
> >  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
> >  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
> >  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
> >  BIOS-e820: 0000000000100000 - 000000001eff0000 (usable)
> >  BIOS-e820: 000000001eff0000 - 000000001eff3000 (ACPI NVS)
> >  BIOS-e820: 000000001eff3000 - 000000001f000000 (ACPI data)
> >  BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
> > 300MB HIGHMEM available.
> > 195MB LOWMEM available.
> > On node 0 totalpages: 126960
> > zone(0): 4096 pages.
> > zone(1): 46064 pages.
> > zone(2): 76800 pages.
> > BUG: wrong zone alignment, it will crash
> > Kernel command line: vga=0xf07 root=/dev/hda4 console=tty0 console=ttyS0,115200n8r devfs=nomount nousb acpi=off highmem=300m
> > Initializing CPU#0
> > Detected 2399.771 MHz processor.
> > Console: colour VGA+ 80x60
> > Calibrating delay loop... 4784.12 BogoMIPS
> > Memory: 498696k/507840k available (1589k kernel code, 8756k reserved, 676k data, 120k init, 307200k highmem)
> >
> > The kernel seems to experience stability problems.
> 
> Michael,
> 
> This is totally bogus, you dont have highmem available. Dont use highmem=.
> 
> 
> 

Marcello,

Thanks for your reply.

It is supposed to work, just a bug in the zone alignment code.

Also 2.6.2 has same problem.

I have have to use HIGHMEM emulation for testing.

Regards
Michqel

Linux version 2.6.2 (mhf@mhfl4) (gcc version 2.95.3 20010315 (release)) #1 Fri Feb 6 19:46:34 HKT 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001eff0000 (usable)
 BIOS-e820: 000000001eff0000 - 000000001eff3000 (ACPI NVS)
 BIOS-e820: 000000001eff3000 - 000000001f000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
300MB HIGHMEM available.
195MB LOWMEM available.
On node 0 totalpages: 126960
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 46064 pages, LIFO batch:11
  HighMem zone: 76800 pages, LIFO batch:16
BUG: wrong zone alignment, it will crash
DMI 2.3 present.
Building zonelist for node : 0
Kernel command line: vga=0xf07 root=/dev/hda4  console=tty0 console=ttyS0,115200n8r devfs=nomount nousb acpi=off highmem=300m
Initializing CPU#0
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 2400.068 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x60
Memory: 498224k/507840k available (1930k kernel code, 8592k reserved, 986k data, 160k init, 307200k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 4734.97 BogoMIPS
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU#0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU: Intel(R) Pentium(R) 4 CPU 2.40GHz stepping 07
Enabling fast FPU save and restore... done.



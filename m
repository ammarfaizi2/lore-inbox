Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267745AbTADA0C>; Fri, 3 Jan 2003 19:26:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267744AbTADAYs>; Fri, 3 Jan 2003 19:24:48 -0500
Received: from air-2.osdl.org ([65.172.181.6]:65447 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267743AbTADAY1>;
	Fri, 3 Jan 2003 19:24:27 -0500
Subject: 2.5.54: Re: [PATCH][CFT] kexec (rewrite) for 2.5.52
From: Andy Pfiffer <andyp@osdl.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>, suparna@in.ibm.com
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>,
       Dave Hansen <haveblue@us.ibm.com>,
       Werner Almesberger <wa@almesberger.net>
In-Reply-To: <20021231200519.A2110@in.ibm.com>
References: <m1smwql3av.fsf@frodo.biederman.org> 
	<20021231200519.A2110@in.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 03 Jan 2003 16:32:51 -0800
Message-Id: <1041640372.12182.51.camel@andyp>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-12-31 at 06:35, Suparna Bhattacharya wrote:
> On Sun, Dec 22, 2002 at 04:07:52AM -0700, Eric W. Biederman wrote:
> > 
> > I have recently taken the time to dig through the internals of
> > kexec to see if I could make my code any simpler and have managed
> > to trim off about 100 lines, and have made the code much more
> > obviously correct.
> > 
> > Anyway, I would love to know in what entertaining ways this code blows
> > up, or if I get lucky and it doesn't.  I probably will not reply back
> > in a timely manner as I am off to visit my parents, for Christmas and
> > New Years.  
> > 

Eric,

The patch applied cleanly to 2.5.54 for me.

The kexec portion works just fine and the reboot discovers all of the
memory on my system using kexec_tools 1.8.

However, something has recently changed in the 2.5.5x series that causes
the reboot to hang while calibrating the delay loop after a kexec
reboot:

setup16_end: 00091b2f
Synchronizing SCSI caches: 
Shutting down devices      
Starting new kernel  
Linux version 2.5.54 (andyp@joe) (gcc version 2.95.3 20010315 (SuSE)) #2
SMP Fri Jan 3 21:36:51 PST 2003
Video mode to be used for restore is ffff
BIOS-provided physical RAM map:          
 BIOS-e820: 0000000000000000 - 000000000009dc00 (usable)
 BIOS-e820: 000000000009dc00 - 00000000000a0000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000027fed140 (usable)  
 BIOS-e820: 0000000027fed140 - 0000000027ff0000 (ACPI data)
 BIOS-e820: 0000000027ff0000 - 0000000028000000 (reserved) 
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
639MB LOWMEM available.                                   
found SMP MP-table at 0009ddd0
hm, page 0009d000 reserved twice.
hm, page 0009e000 reserved twice.
hm, page 0009d000 reserved twice.
hm, page 0009e000 reserved twice.
WARNING: MP table in the EBDA can be UNSAFE, contact
linux-smp@vger.kernel.org if you experience SMP problems!
On node 0 totalpages: 163821  
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 159725 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1     
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.   
OEM ID: IBM ENSW Product ID: xSeries 220  APIC at: 0xFEE00000
Processor #0 6:8 APIC version 17                             
I/O APIC #14 Version 17 at 0xFEC00000.
I/O APIC #13 Version 17 at 0xFEC01000.
Enabling APIC mode:  Flat.  Using 2 I/O APICs
Processors: 1                                
IBM machine detected. Enabling interrupts during APM calls.
IBM machine detected. Disabling SMBus accesses.            
Building zonelist for node : 0                 
Kernel command line: auto BOOT_IMAGE=linux-2.5 ro root=805
console=ttyS0,9600n8
Initializing
CPU#0                                                             
Detected 799.578 MHz processor.
Console: colour VGA+ 80x25     
Calibrating delay loop... 

<wedged>

This happens with -and- without the separate "hwfixes" chunk of code
(that patch carries forward and continues to apply cleanly).

It would appear that clock interrupts are no long arriving (ticks always
equals jiffies).

You can download the kexec patches for 2.5.54 from OSDL's PLM service:
(apologies in advance for the long URL):
https://www.osdl.org/cgi-bin/plm?module=search&search_patch=kexec-rewrite&search_created=Anytime&search_format=detailed&action=run_patch_search&sort_field=idDESC

If the URL is mangled, go here:
https://www.osdl.org/cgi-bin/plm?module=search
and then put "kexec-rewrite" into the "Patch Name or ID" box,
and then press "Submit Query".

Key:
kexec-rewrite-2.5.54-1-of-3-1 == your rewrite from 2002-12-22
kexec-rewrite-2.5.54-2-of-3-1 == your "hwfixes" from 2.5.48ish
kexec-rewrite-2.5.54-3-of-3-1 == ignore it (changes CONFIG_KEXEC=y for PLM)

Regards,
Andy





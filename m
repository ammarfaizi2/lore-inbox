Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932357AbWIOXSz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932357AbWIOXSz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 19:18:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932364AbWIOXSz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 19:18:55 -0400
Received: from chain.digitalkingdom.org ([64.81.49.134]:41618 "EHLO
	chain.digitalkingdom.org") by vger.kernel.org with ESMTP
	id S932357AbWIOXSy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 19:18:54 -0400
Date: Fri, 15 Sep 2006 16:18:52 -0700
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Same MCE on 4 working machines (was Re: Early boot hang on recent 2.6 kernels (> 2.6.3), on x86-64 with 16gb of RAM)
Message-ID: <20060915231852.GV4610@chain.digitalkingdom.org>
References: <20060912223258.GM4612@chain.digitalkingdom.org> <20060914190548.GI4610@chain.digitalkingdom.org> <1158320742.29932.20.camel@localhost.localdomain> <20060915182915.GR4610@chain.digitalkingdom.org> <1158353439.29932.146.camel@localhost.localdomain> <20060915203159.GS4610@chain.digitalkingdom.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060915203159.GS4610@chain.digitalkingdom.org>
User-Agent: Mutt/1.5.12-2006-07-14
From: Robin Lee Powell <rlpowell@digitalkingdom.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Found away to get around the large RAM issue; see below.

On Fri, Sep 15, 2006 at 01:31:59PM -0700,  wrote:
> On Fri, Sep 15, 2006 at 09:50:39PM +0100, Alan Cox wrote:
> > 
> > You also have a lot of RAM, that shouldn't matter but it means
> > you hit code paths most users don't. If you boot with mem
> > limited to 1GB I assume it still blows up ?
> 
> I've tried mem=1023M, yes, and it still blows up.  Just did
> acpi=off mem=1023M to check.

I've found a server with the same hardware except only 2GiB of RAM.
The behaviour is slightly different.  It restarts instead of
hanging, and the last bit is:

Initializing CPU#0
PID hash table entries: 4096 (order: 12, 32768 bytes)
Disabling vsyscall due to use of PM timer
time.c: Using 3.579545 MHz WALL PM GTOD PM timer.
time.c: Detected 1804.115 MHz processor.
Console: colour VGA+ 80x25
Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Memory: 2059540k/2096576k available (2584k kernel code, 36348k reserved, 1198k data, 220k init)
Calibrating delay using timer specific routine.. 3611.41 BogoMIPS (lpj=18057088)
Security Framework v1.0.0 initialized
Mount-cache hash table entries: 256
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
í

Not the wierd character at the end; there's always one or two of
them, but that could just be our Cyclades console servers doing
something odd.

At that point, the machine reboots.

I have found no way yet to get any other behaviour; acpi=off, in
particular, doesn't give me the MCE on this box.

I've tried all your pci= options, too, with no effect.

I tried "nosmp noapic mem=512M ide=nodma apm=off acpi=off desktop
showopts".

I tried iommu=off.

I tried Debian's 2.6.8-11-amd64-generic, which on the 16GiB boxes
went straight to the MCE; it stopped at the same place, but seems to
have hung instead of rebooting.  Still didn't get as far as the MCE.

Nothing seems to make a difference.

But 2.6.2 boots right up, no troubles.

Just to make sure that the machines really were the same, I pulled
lspci -v from this smaller-RAM one.  They are *exactly the same*.
Right down to the IRQs.  You can see them at:

16gb: http://teddyb.org/~rlpowell/media/regular/lkml/lspci_v.txt

2gb: http://teddyb.org/~rlpowell/media/regular/lkml/devnutch1-lspci_v.txt

(you can see they're not the same file, because the whitespace came
out differently :-)

Here's some BIOS options that look maybe relevant, just in case:

4GB Memory Hole Adjust                  [Auto]  
4GB Memory Hole Size                    [128 MB]
IOMMU:                                  [Enable]
Size:                                   [64 MB] 
Multiprocessor Specification:           [1.4]   
Use PCI Interrupt Entries in MP Table:  [Yes]   

ACPI Enabled:                    [Yes]      
ACPI SRAT Table                  [Enabled]  
Spread spectrum modulation       [No]       
Suppress Unused PCI Slot Clocks  [No]       

-Robin

-- 
http://www.digitalkingdom.org/~rlpowell/ *** http://www.lojban.org/
Reason #237 To Learn Lojban: "Homonyms: Their Grate!"
Proud Supporter of the Singularity Institute - http://singinst.org/

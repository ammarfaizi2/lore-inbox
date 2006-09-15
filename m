Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751312AbWIOSHR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751312AbWIOSHR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 14:07:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751315AbWIOSHR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 14:07:17 -0400
Received: from chain.digitalkingdom.org ([64.81.49.134]:59018 "EHLO
	chain.digitalkingdom.org") by vger.kernel.org with ESMTP
	id S1751312AbWIOSHP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 14:07:15 -0400
Date: Fri, 15 Sep 2006 11:07:11 -0700
To: Bharath Ramesh <krosswindz@gmail.com>
Cc: Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org
Subject: Re: Same MCE on 4 working machines (was Re: Early boot hang on recent 2.6 kernels (> 2.6.3), on x86-64 with 16gb of RAM)
Message-ID: <20060915180711.GP4610@chain.digitalkingdom.org>
References: <20060912223258.GM4612@chain.digitalkingdom.org> <20060914190548.GI4610@chain.digitalkingdom.org> <1158261249.7948.111.camel@mindpipe> <20060914191555.GJ4610@chain.digitalkingdom.org> <c775eb9b0609142242r45d184d2h8d7edd7dd5bc2a26@mail.gmail.com> <20060915174701.GN4610@chain.digitalkingdom.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060915174701.GN4610@chain.digitalkingdom.org>
User-Agent: Mutt/1.5.12-2006-07-14
From: Robin Lee Powell <rlpowell@digitalkingdom.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ooops, I'm sorry, I didn't actually follow your instructions; all
the testing I just did was with Debian's 2.6.8-12-amd64-k8-smp.  Too many
kernels on the box; I'll re-image.

Installing my own 2.6.17.11 now.

The behaviour is a bit different on my own 2.6.17.11; no idea why,
haven't compared the configs carefully yet.  Instead of having the
MCE, it hangs at:

- --------------------

CPU 0: aperture @ 0 size 64 MB
No AGP bridge found
Your BIOS doesn't leave a aperture memory hole
Please enable the IOMMU option in the BIOS setup
This costs you 64 MB of RAM
Mapping aperture over 65536 KB of RAM @ 10000000
Built 1 zonelists
Kernel command line: root=/dev/sda2 ro console=ttyS1
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 32768 bytes)
Disabling vsyscall due to use of PM timer
time.c: Using 3.579545 MHz WALL PM GTOD PM timer.
time.c: Detected 1804.148 MHz processor.
Console: colour VGA+ 80x25
Dentry cache hash table entries: 2097152 (order: 12, 16777216 bytes)
Inode-cache hash table entries: 1048576 (order: 11, 8388608 bytes)
Memory: 16320480k/16777216k available (2584k kernel code, 324288k reserved, 1198k data, 220k init)
Calibrating delay using timer specific routine.. 3611.41 BogoMIPS (lpj=18057091)
Security Framework v1.0.0 initialized
Mount-cache hash table entries: 256
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)

- --------------------

Note that that's the *first* CPU; it doesn't even get to the second
one.

If I use acpi=off, if gets to the MCE:


- ---------------------

Initializing CPU#1
Calibrating delay using timer specific routine.. 3608.30 BogoMIPS (lpj=18041501)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
AMD Opteron(tm) Processor 244 stepping 0a
CPU 1: Syncing TSC to CPU 0.
CPU 1: synchronized TSC with CPU 0 (last diff 1 cycles, maxerr 1221 cycles)
Brought up 2 CPUs
testing NMI watchdog ... OK.
migration_cost=621
NET: Registered protocol family 16
PCI: Using configuration type 1
ACPI: Subsystem revision 20060127
ACPI: Interpreter disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI: disabled
SCSI subsystem initialized
PCI: Probing PCI hardware

HARDWARE ERROR
CPU 0: Machine Check Exception:                7 Bank 3: b40000000000083b
RIP 10:<ffffffff80308e7e> {pci_conf1_read+0xbe/0xf0}
TSC 20aa61dfee ADDR fdfc000cfc
This is not a software problem!
Run through mcelog --ascii to decode and contact your hardware vendor
Kernel panic - not syncing: Uncorrected machine check

- ---------------------

"mce=bootlog" has the same hang as the first case above.

"mce=bootlog acpi=off" has the same MCE as the second case above.
Specifically:

HARDWARE ERROR
CPU 0: Machine Check Exception:                7 Bank 3: b40000000000083b
RIP 10:<ffffffff80308e7e> {pci_conf1_read+0xbe/0xf0}
TSC 1a0c706340 ADDR fdfc000cfc
This is not a software problem!
Run through mcelog --ascii to decode and contact your hardware vendor
Kernel panic - not syncing: Uncorrected machine check

-Robin
On Fri, Sep 15, 2006 at 10:47:01AM -0700, rlpowell wrote:
> I didn't know about mce=bootlog.  Neat.  It doesn't change anything,
> though.  I've tried noacpi and many variants thereon; no change.
> 
> The most severe set of options I have record of trying is:
> 
> nosmp noapic mem=512M ide=nodma apm=off acpi=off desktop showopts
> 
> but there were lots of others.
> 
> mce=nobootlog doesn't help either, for the record.
> 
> If mce=bootlog actually sticks logs somewhere I should retrieve and
> show to you, please tell me; ./Documentation/x86_64/boot-options.txt
> doesn't say anything about it.
> 
> -Robin
> 
> On Fri, Sep 15, 2006 at 01:42:49AM -0400, Bharath Ramesh wrote:
> > Have you tried booting newer kernel post 2.6.13 with the boot
> > option mce=bootlog and see if it goes past the current failure.
> > Try the same with with noacpi.
> > 
> > Bharath
> > 
> > On 9/14/06, Robin Lee Powell <rlpowell@digitalkingdom.org> wrote:
> > >On Thu, Sep 14, 2006 at 03:14:08PM -0400, Lee Revell wrote:
> > >> On Thu, 2006-09-14 at 12:05 -0700, Robin Lee Powell wrote:
> > >> > This isn't just me.  All the Debian kernels hang too.  I've tried
> > >> > all of the following:
> > >> >
> > >> > Linux version 2.6.8-12-amd64-generic (buildd@bester) (gcc version
> > >> > 3.4.4 20050314 (prerelease) (Debian 3.4.3-13)) #1 Mon Jul 17 01:12:05
> > >> > UTC 2006
> > >> >
> > >> > Linux version 2.6.8-12-amd64-k8 (buildd@bester) (gcc version 3.4.4
> > >> > 20050314 (prerelease) (Debian 3.4.3-13)) #1 Mon Jul 17 01:39:03 UTC
> > >> > 2006
> > >> >
> > >> > Linux version 2.6.8-12-amd64-k8-smp (buildd@bester) (gcc version 3.4.4
> > >> > 20050314 (prerelease) (Debian 3.4.3-13)) #1 SMP Mon Jul 17 00:17:20
> > >> > UTC 2006
> > >>
> > >> Have you tried a *recent* 2.6 kernel like 2.6.17 or 2.6.18-rc*?
> > >>
> > >> 2.6.8 is way too old to debug.
> > >
> > >Yes; that's what my previous post was about.  See
> > >http://lkml.org/lkml/2006/9/12/300
> > >
> > >I was doing 2.6.17.11, which was kernel.org's latest stable at the
> > >time I started all this.
> > >
> > >I tried the Debian kernels just to show that it wasn't just me
> > >screwing up my kernel configs.
> > >
> > >These machines will not boot an any kernel > 2.6.3 that I have
> > >tried, and I've tried about 8 different ones at this point.
> > >
> > >I noted in the release notes for 2.6.4 that the mce code was
> > >entirely replaced; I'm suspecting that's the problem, but I have no
> > >idea how to debug it.  Whether the problem is the kernel or the
> > >motherboard is also certainly open to debate.
> > >
> > >-Robin
> > >
> > >--
> > >http://www.digitalkingdom.org/~rlpowell/ *** http://www.lojban.org/
> > >Reason #237 To Learn Lojban: "Homonyms: Their Grate!"
> > >Proud Supporter of the Singularity Institute - http://singinst.org/
> > >-
> > >To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > >the body of a message to majordomo@vger.kernel.org
> > >More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > >Please read the FAQ at  http://www.tux.org/lkml/
> > >
> 
> -- 
> http://www.digitalkingdom.org/~rlpowell/ *** http://www.lojban.org/
> Reason #237 To Learn Lojban: "Homonyms: Their Grate!"
> Proud Supporter of the Singularity Institute - http://singinst.org/

-- 
http://www.digitalkingdom.org/~rlpowell/ *** http://www.lojban.org/
Reason #237 To Learn Lojban: "Homonyms: Their Grate!"
Proud Supporter of the Singularity Institute - http://singinst.org/

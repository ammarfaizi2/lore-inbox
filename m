Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750876AbVIWRhv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750876AbVIWRhv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 13:37:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750844AbVIWRhu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 13:37:50 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:53959 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750836AbVIWRhu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 13:37:50 -0400
Date: Fri, 23 Sep 2005 10:37:43 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Sean Bruno <sean.bruno@dsl-only.net>
Cc: karim@opersys.com, ak@suse.de, LKML <linux-kernel@vger.kernel.org>
Subject: Re: The system works (2.6.14-rc2): functional k8n-dl
Message-ID: <20050923173743.GJ5910@us.ibm.com>
References: <20050922155254.GE5910@us.ibm.com> <43332254.1040603@opersys.com> <1127495296.25701.15.camel@oscar> <20050923172014.GH5910@us.ibm.com> <1127496135.25701.22.camel@oscar>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1127496135.25701.22.camel@oscar>
X-Operating-System: Linux 2.6.14-rc2 (x86_64)
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.09.2005 [10:22:15 -0700], Sean Bruno wrote:
> On Fri, 2005-09-23 at 10:20 -0700, Nishanth Aravamudan wrote:
> > On 23.09.2005 [10:08:16 -0700], Sean Bruno wrote:
> > > On Thu, 2005-09-22 at 17:29 -0400, Karim Yaghmour wrote:
> > > > Nish,
> > > > 
> > > > OK, I can confirm that with version 1006 of the BIOS it works flawlessly
> > > > with Linux. I was able to install full FC4 and boot without a problem
> > > > even with the SATA disk plugged to the nVidia controller (reading the
> > > > archives you will see that the nVidia SATA controller is something I
> > > > was simply unable to get working.) I didn't need to recompile anything.
> > > > The kernel that came with FC4 worked just fine.
> > > I can also confirm these findings.  However, I still have to boot the
> > > kernel with iommu=memaper=3 in order to get the system to work
> > > properly.  
> > 
> > You have 6GB of RAM, right? That must be the difference, as I only have
> > 2 GB (and the IOMMU is used when you have more than 3 GB according to
> > menuconfig?).
> > 
> Yes 6GB of ram.

Odd, any ideas of why that is? What happens when you don't pass the
param? (sorry, haven't followed all the k8n-dl threads :)

A couple of points. Noticed that param is not documented in
Documentation/kernel-parameters.txt; care to make up a patch? Also,
after your message, I did a quick grep through my dmesg and see the
following:

[    0.000000] Checking aperture...
[    0.000000] CPU 0: aperture @ 4000000 size 32 MB
[    0.000000] Aperture from northbridge cpu 0 too small (32 MB)
[    0.000000] No AGP bridge found
[    0.000000] Your BIOS doesn't leave a aperture memory hole
[    0.000000] Please enable the IOMMU option in the BIOS setup
[    0.000000] This costs you 64 MB of RAM
[    0.000000] Mapping aperture over 65536 KB of RAM @ 4000000

Is the aperture memory hole necessary even without AGP? Does the ASUS
BIOS provide a means to change the aperture size (I didn't see one when
I looked, but I could easily have missed it).

[   45.703183] PCI: Using ACPI for IRQ routing
[   45.703194] PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
[   45.703286] PCI-DMA: Disabling AGP.
[   45.703295] PCI-DMA: More than 4GB of RAM and no IOMMU
[   45.703296] PCI-DMA: 32bit PCI IO may malfunction.<6>PCI-DMA: Disabling IOMMU.

I am not sure why the kernel thinks I have more than 4GB of RAM, when I
have 2 GB. Seems like a bug? Looks like that "Disabling IOMMU" printk is
b0rked...and why does it disable it if I don't have one?  (according to
2 messages before that one?) Andi, do you have any input on this?

/proc/meminfo:

MemTotal:      1989424 kB
MemFree:         32896 kB
Buffers:        276924 kB
Cached:        1013852 kB
SwapCached:          0 kB
Active:        1085736 kB
Inactive:       510788 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:      1989424 kB
LowFree:         32896 kB
SwapTotal:           0 kB
SwapFree:            0 kB
Dirty:              24 kB
Writeback:           0 kB
Mapped:         355348 kB
Slab:           340204 kB
CommitLimit:    994712 kB
Committed_AS:   432912 kB
PageTables:       6792 kB
VmallocTotal: 34359738367 kB
VmallocUsed:    262572 kB
VmallocChunk: 34359475707 kB
HugePages_Total:     0
HugePages_Free:      0
Hugepagesize:     2048 kB

Thanks,
Nish

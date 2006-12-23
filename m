Return-Path: <linux-kernel-owner+w=401wt.eu-S1753430AbWLWCEw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753430AbWLWCEw (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 21:04:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753446AbWLWCEw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 21:04:52 -0500
Received: from mail1.key-systems.net ([81.3.43.211]:47192 "HELO
	mail1.key-systems.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753430AbWLWCEu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 21:04:50 -0500
Message-ID: <458C8EBE.3010506@scientia.net>
Date: Sat, 23 Dec 2006 03:04:46 +0100
From: Christoph Anton Mitterer <calestyo@scientia.net>
User-Agent: Icedove 1.5.0.9 (X11/20061220)
MIME-Version: 1.0
To: Karsten Weiss <K.Weiss@science-computing.de>
CC: Chris Wedgwood <cw@f00f.org>, linux-kernel@vger.kernel.org,
       Erik Andersen <andersen@codepoet.org>, Andi Kleen <ak@suse.de>,
       chaves@computer.org, muli@il.ibm.com
Subject: Re: data corruption with nvidia chipsets and IDE/SATA drives // memory
 hole mapping related bug?!
References: <Pine.LNX.4.64.0612021202000.2981@addx.localnet> <Pine.LNX.4.61.0612111001240.23470@palpatine.science-computing.de> <458051FD.1060900@scientia.net> <20061213195345.GA16112@tuatara.stupidest.org> <Pine.LNX.4.61.0612132100060.6688@palpatine.science-computing.de>
In-Reply-To: <Pine.LNX.4.61.0612132100060.6688@palpatine.science-computing.de>
Content-Type: multipart/mixed;
 boundary="------------090105040804070401070002"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090105040804070401070002
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi my friends....

It became a little bit silent about this issue... any new ideas or results?



Karsten Weiss wrote:
> BTW: Did someone already open an official bug at
> http://bugzilla.kernel.org ?
Karsten, did you already file a bug?



I told the whole issue to the Debian people which are about to release
etch and suggested them to use iommu=soft by default.
This brings me to:
Chris Wedgwood wrote:
> Does anyone have an amd64 with an nforce4 chipset and >4GB that does
> NOT have this problem? If so it might be worth chasing the BIOS
> vendors to see what errata they are dealing with.
John Chaves replied and claimed that he wouldn't suffer from that
problem (I've CC'ed him to this post).
You can read his message at the bottom of this post.
@ John: Could you please tell us in detail how you've tested your system?



Muli told us some information about the iommu options (when he
discuessed Karstens patch) has anybody made tests with the other iommu
options?



Ok and what does it all come down to? We still don't know the exact
reason...
Perhaps a kernel bug, a Opteron and/or Chipset bug,.. and perhaps there
are even some BIOSes that solve the issue...

For the kernel-bug reason,... who is the responsible developer for the
relevant code? Can we contact him to read our threads and perhaps review
the code?

Is anyone able (or wants to try) to inform AMD and/or Nvidia about the
issue (perhaps with pointing to that thread).

Someone might even try to contact some board vendors (some of us seem to
have Tyan boards). Although I'm in contact with the German support Team
of Tyan, I wasn't very successful with the US team... perhaps they have
other ideas.

Last but not least.... if we don't find a solution what should we do?
In my opinion at least the following:
1) Inform other OS communities (*BSD) and point the to our thread. Some
of you claimed that Windows wouldn't use the hwiommu at all so I think
we don't have to contact big evil.
2) Contact the major Linux Distributions (I've already did it for
Debian) and inform them about the potential issue and pointing them to
this thread (where one can find all the relevant information, I think)
3) Workaround for the kernel:
I have to less knowledge to know exactly what to do but I remember there
are other fixes for mainboard flaws and buggy chipsets in the kernel
(e.g. the RZ1000 or something like this in the "old" IDE driver)...
Perhaps someone (who knows what to do ;-) ) could write some code that
automatically uses iommu=soft,... but then we have the question: In
which case :-( . I imagine that the AMD users who don't suffer from this
issue would like to continue using their hwiommus..


What I'm currently plan to do:
1) If know one else is willing to try contacting AMD/Nvidia,.. I'd try
again.
2) I told you that I'm going to test the whole issue in the Leibniz
Supercomputing Centre where I work as student...
This is a little bit delayed (organisational problems :-) )
Anyway,... I'm not only going to test it on our Linux Cluster but also
some Sun Fire's (whe have maaaannnnny of them ;-) ). According to my
boss they have nvidia chipsets... (He is probably contacting Sun for the
issue).



So much for now.

Best wishes,
Chris.


John Chaves message:
Here's another data point in case it helps.
The following system does *not* have the data corruption issue.

Motherboard: Iwill DK88 <http://www.iwill.net/product_2.asp?p_id=102>
Chipset: NVIDIA nForce4 Professional 2200
CPUs: Two Dual Core AMD Opteron(tm) Processor 280
Memory: 32GB
Disks: Four 500GB SATA in linux RAID1 over RAID0 setup
Kernel: 2.6.18

This system is a workhorse with extreme disk I/O of huge files,
and the nature of the work done would have revealed data
corruption pretty quickly.

FWIW,
John Chaves

His lspic:
0000:00:00.0 Memory controller: nVidia Corporation CK804 Memory
Controller (rev a3)
Flags: bus master, 66MHz, fast devsel, latency 0
Capabilities: [44] #08 [01e0]
Capabilities: [e0] #08 [a801]

0000:00:01.0 ISA bridge: nVidia Corporation CK804 ISA Bridge (rev a3)
Subsystem: nVidia Corporation: Unknown device cb84
Flags: bus master, 66MHz, fast devsel, latency 0

0000:00:01.1 SMBus: nVidia Corporation CK804 SMBus (rev a2)
Subsystem: nVidia Corporation: Unknown device cb84
Flags: 66MHz, fast devsel, IRQ 9
I/O ports at d400 [size=32]
I/O ports at 4c00 [size=64]
I/O ports at 4c40 [size=64]
Capabilities: [44] Power Management version 2

0000:00:02.0 USB Controller: nVidia Corporation CK804 USB Controller
(rev a2) (prog-if 10 [OHCI])
Subsystem: nVidia Corporation: Unknown device cb84
Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 209
Memory at feafc000 (32-bit, non-prefetchable) [size=4K]
Capabilities: [44] Power Management version 2

0000:00:02.1 USB Controller: nVidia Corporation CK804 USB Controller
(rev a3) (prog-if 20 [EHCI])
Subsystem: nVidia Corporation: Unknown device cb84
Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 193
Memory at feafdc00 (32-bit, non-prefetchable) [size=256]
Capabilities: [44] #0a [2098]
Capabilities: [80] Power Management version 2

0000:00:06.0 IDE interface: nVidia Corporation CK804 IDE (rev a2)
(prog-if 8a [Master SecP PriP])
Subsystem: nVidia Corporation: Unknown device cb84
Flags: bus master, 66MHz, fast devsel, latency 0
I/O ports at 3000 [size=16]
Capabilities: [44] Power Management version 2

0000:00:07.0 IDE interface: nVidia Corporation CK804 Serial ATA
Controller (rev a3) (prog-if 85 [Master SecO PriO])
Subsystem: nVidia Corporation: Unknown device cb84
Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 193
I/O ports at e800 [size=8]
I/O ports at e400 [size=4]
I/O ports at e000 [size=8]
I/O ports at dc00 [size=4]
I/O ports at d800 [size=16]
Memory at feafe000 (32-bit, non-prefetchable) [size=4K]
Capabilities: [44] Power Management version 2

0000:00:08.0 IDE interface: nVidia Corporation CK804 Serial ATA
Controller (rev a3) (prog-if 85 [Master SecO PriO])
Subsystem: nVidia Corporation: Unknown device cb84
Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 201
I/O ports at fc00 [size=8]
I/O ports at f800 [size=4]
I/O ports at f400 [size=8]
I/O ports at f000 [size=4]
I/O ports at ec00 [size=16]
Memory at feaff000 (32-bit, non-prefetchable) [size=4K]
Capabilities: [44] Power Management version 2

0000:00:09.0 PCI bridge: nVidia Corporation CK804 PCI Bridge (rev a2)
(prog-if 01 [Subtractive decode])
Flags: bus master, 66MHz, fast devsel, latency 0
Bus: primary=00, secondary=05, subordinate=05, sec-latency=128
I/O behind bridge: 0000b000-0000bfff
Memory behind bridge: fc900000-fe9fffff
Prefetchable memory behind bridge: e0000000-e00fffff

0000:00:0b.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3)
(prog-if 00 [Normal decode])
Flags: bus master, fast devsel, latency 0
Bus: primary=00, secondary=04, subordinate=04, sec-latency=0
Memory behind bridge: fc800000-fc8fffff
Capabilities: [40] Power Management version 2
Capabilities: [48] Message Signalled Interrupts: 64bit+ Queue=0/1 Enable-
Capabilities: [58] #08 [a800]
Capabilities: [80] #10 [0141]

0000:00:0c.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3)
(prog-if 00 [Normal decode])
Flags: bus master, fast devsel, latency 0
Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
Memory behind bridge: fc700000-fc7fffff
Capabilities: [40] Power Management version 2
Capabilities: [48] Message Signalled Interrupts: 64bit+ Queue=0/1 Enable-
Capabilities: [58] #08 [a800]
Capabilities: [80] #10 [0141]

0000:00:0d.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3)
(prog-if 00 [Normal decode])
Flags: bus master, fast devsel, latency 0
Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
Capabilities: [40] Power Management version 2
Capabilities: [48] Message Signalled Interrupts: 64bit+ Queue=0/1 Enable-
Capabilities: [58] #08 [a800]
Capabilities: [80] #10 [0141]

0000:00:0e.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3)
(prog-if 00 [Normal decode])
Flags: bus master, fast devsel, latency 0
Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
Capabilities: [40] Power Management version 2
Capabilities: [48] Message Signalled Interrupts: 64bit+ Queue=0/1 Enable-
Capabilities: [58] #08 [a800]
Capabilities: [80] #10 [0141]

0000:00:18.0 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] HyperTransport Technology Configuration
Flags: fast devsel
Capabilities: [80] #08 [2101]
Capabilities: [a0] #08 [2101]
Capabilities: [c0] #08 [2101]

0000:00:18.1 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] Address Map
Flags: fast devsel

0000:00:18.2 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] DRAM Controller
Flags: fast devsel

0000:00:18.3 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] Miscellaneous Control
Flags: fast devsel

0000:00:19.0 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] HyperTransport Technology Configuration
Flags: fast devsel
Capabilities: [80] #08 [2101]
Capabilities: [a0] #08 [2101]
Capabilities: [c0] #08 [2101]

0000:00:19.1 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] Address Map
Flags: fast devsel

0000:00:19.2 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] DRAM Controller
Flags: fast devsel

0000:00:19.3 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] Miscellaneous Control
Flags: fast devsel

0000:03:00.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5721
Gigabit Ethernet PCI Express (rev 11)
Subsystem: Broadcom Corporation NetXtreme BCM5721 Gigabit Ethernet PCI
Express
Flags: bus master, fast devsel, latency 0, IRQ 185
Memory at fc7f0000 (64-bit, non-prefetchable) [size=64K]
Capabilities: [48] Power Management version 2
Capabilities: [50] Vital Product Data
Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=0/3 Enable-
Capabilities: [d0] #10 [0001]

0000:04:00.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5721
Gigabit Ethernet PCI Express (rev 11)
Subsystem: Broadcom Corporation NetXtreme BCM5721 Gigabit Ethernet PCI
Express
Flags: bus master, fast devsel, latency 0, IRQ 177
Memory at fc8f0000 (64-bit, non-prefetchable) [size=64K]
Capabilities: [48] Power Management version 2
Capabilities: [50] Vital Product Data
Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=0/3 Enable-
Capabilities: [d0] #10 [0001]

0000:05:07.0 VGA compatible controller: ATI Technologies Inc Rage XL
(rev 27) (prog-if 00 [VGA])
Subsystem: ATI Technologies Inc Rage XL
Flags: bus master, stepping, medium devsel, latency 64, IRQ 10
Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
I/O ports at b800 [size=256]
Memory at fe8ff000 (32-bit, non-prefetchable) [size=4K]
Expansion ROM at e0000000 [disabled] [size=128K]
Capabilities: [5c] Power Management version 2

0000:06:01.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8132 PCI-X
Bridge (rev 11) (prog-if 00 [Normal decode])
Flags: bus master, fast devsel, latency 64
Bus: primary=06, secondary=08, subordinate=08, sec-latency=64
Capabilities: [60] Capabilities: [b8] #08 [8000]
Capabilities: [c0] #08 [0041]
Capabilities: [f4] #08 [a800]

0000:06:01.1 PIC: Advanced Micro Devices [AMD] AMD-8132 PCI-X IOAPIC
(rev 11) (prog-if 10 [IO-APIC])
Subsystem: Advanced Micro Devices [AMD] AMD-8132 PCI-X IOAPIC
Flags: bus master, medium devsel, latency 0
Memory at febfe000 (64-bit, non-prefetchable) [size=4K]

0000:06:02.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8132 PCI-X
Bridge (rev 11) (prog-if 00 [Normal decode])
Flags: bus master, fast devsel, latency 64
Bus: primary=06, secondary=07, subordinate=07, sec-latency=64
Capabilities: [60] Capabilities: [b8] #08 [8000]
Capabilities: [c0] #08 [8840]
Capabilities: [f4] #08 [a800]

0000:06:02.1 PIC: Advanced Micro Devices [AMD] AMD-8132 PCI-X IOAPIC
(rev 11) (prog-if 10 [IO-APIC])
Subsystem: Advanced Micro Devices [AMD] AMD-8132 PCI-X IOAPIC
Flags: bus master, medium devsel, latency 0
Memory at febff000 (64-bit, non-prefetchable) [size=4K]

His /proc/cpuinfo:processor : 0
vendor_id : AuthenticAMD
cpu family : 15
model : 33
model name : Dual Core AMD Opteron(tm) Processor 280
stepping : 2
cpu MHz : 2400.020
cache size : 1024 KB
physical id : 0
siblings : 2
core id : 0
cpu cores : 2
fpu : yes
fpu_exception : yes
cpuid level : 1
wp : yes
flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt lm
3dnowext 3dnow pni lahf_lm cmp_legacy
bogomips : 4802.02
TLB size : 1024 4K pages
clflush size : 64
cache_alignment : 64
address sizes : 40 bits physical, 48 bits virtual
power management: ts fid vid ttp

processor : 1
vendor_id : AuthenticAMD
cpu family : 15
model : 33
model name : Dual Core AMD Opteron(tm) Processor 280
stepping : 2
cpu MHz : 2400.020
cache size : 1024 KB
physical id : 0
siblings : 2
core id : 1
cpu cores : 2
fpu : yes
fpu_exception : yes
cpuid level : 1
wp : yes
flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt lm
3dnowext 3dnow pni lahf_lm cmp_legacy
bogomips : 4799.29
TLB size : 1024 4K pages
clflush size : 64
cache_alignment : 64
address sizes : 40 bits physical, 48 bits virtual
power management: ts fid vid ttp

processor : 2
vendor_id : AuthenticAMD
cpu family : 15
model : 33
model name : Dual Core AMD Opteron(tm) Processor 280
stepping : 2
cpu MHz : 2400.020
cache size : 1024 KB
physical id : 1
siblings : 2
core id : 0
cpu cores : 2
fpu : yes
fpu_exception : yes
cpuid level : 1
wp : yes
flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt lm
3dnowext 3dnow pni lahf_lm cmp_legacy
bogomips : 4799.36
TLB size : 1024 4K pages
clflush size : 64
cache_alignment : 64
address sizes : 40 bits physical, 48 bits virtual
power management: ts fid vid ttp

processor : 3
vendor_id : AuthenticAMD
cpu family : 15
model : 33
model name : Dual Core AMD Opteron(tm) Processor 280
stepping : 2
cpu MHz : 2400.020
cache size : 1024 KB
physical id : 1
siblings : 2
core id : 1
cpu cores : 2
fpu : yes
fpu_exception : yes
cpuid level : 1
wp : yes
flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt lm
3dnowext 3dnow pni lahf_lm cmp_legacy
bogomips : 4799.37
TLB size : 1024 4K pages
clflush size : 64
cache_alignment : 64
address sizes : 40 bits physical, 48 bits virtual
power management: ts fid vid ttp


--------------090105040804070401070002
Content-Type: text/x-vcard; charset=utf-8;
 name="calestyo.vcf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="calestyo.vcf"

YmVnaW46dmNhcmQNCmZuOk1pdHRlcmVyLCBDaHJpc3RvcGggQW50b24NCm46TWl0dGVyZXI7
Q2hyaXN0b3BoIEFudG9uDQplbWFpbDtpbnRlcm5ldDpjYWxlc3R5b0BzY2llbnRpYS5uZXQN
CngtbW96aWxsYS1odG1sOlRSVUUNCnZlcnNpb246Mi4xDQplbmQ6dmNhcmQNCg0K
--------------090105040804070401070002--

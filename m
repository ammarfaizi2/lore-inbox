Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275377AbTHIT2n (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 15:28:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275388AbTHIT2n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 15:28:43 -0400
Received: from web40614.mail.yahoo.com ([66.218.78.151]:19996 "HELO
	web40614.mail.yahoo.com") by vger.kernel.org with SMTP
	id S275377AbTHIT2e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 15:28:34 -0400
Message-ID: <20030809192833.88024.qmail@web40614.mail.yahoo.com>
Date: Sat, 9 Aug 2003 20:28:33 +0100 (BST)
From: =?iso-8859-1?q?Chris=20Rankin?= <rankincj@yahoo.com>
Subject: RE: Loading Pentium III microcode under Linux - catch 22! BOARD NOW STABLE!
To: "Nakajima, Jun" <jun.nakajima@intel.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Tigran Aivazian <tigran@veritas.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <7F740D512C7C1046AB53446D3720017304AE75@scsmsx402.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 --- "Nakajima, Jun" <jun.nakajima@intel.com> wrote:
> We don't need IPI or even the microcode update
> driver if we do this. But I think putting it in
> initrd should be sufficient.

Well, I don't know about "sufficient". Someone on
"www.hardwareanalysis.com" suggested underclocking my
CPUs. So my dual 933 MHz CPUs are now running at 700
MHz (FSB changed from 133 MHz to 100 MHz) and
everything has been fine for the past 3 hours; same
load as when everything hit the fan last week too. Of
course, the CPUs run cooler like this, so I can't
ignore the thermal element...

$ more /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 6
cpu MHz         : 696.033
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8
apic sep mtrr pge mca cmov 
pat pse36 mmx fxsr sse
bogomips        : 1389.36

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 6
cpu MHz         : 696.033
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8
apic sep mtrr pge mca cmov 
pat pse36 mmx fxsr sse
bogomips        : 1389.36

The correct microcode has been loaded successfully:

IA-32 Microcode Update Driver: v1.11
<tigran@veritas.com>
microcode: CPU0 updated from revision 0 to 7,
date=05052000
microcode: CPU1 updated from revision 0 to 7,
date=05052000

This was not done from initrd (yet). However, I should
probably point out that 4 weeks ago, I *must* have
successfully loaded the microcode from rc.sysinit in
order for the box to survive for the next 3 weeks.

Now throughout all these problems, Linux has never
locked up before this message has appeared in the boot
log:

Freeing unused kernel memory: 108k freed

However, it seems that it can crash at any point
afterwards. (I never had to wait too long either,
although it seemed that the more work the box did, the
quicker it crashed.)

The conclusions from all this seem to be:
- Linux was crashing due to an incorrect
CPU/motherboard interaction.
- the current microcode for these CPUs does not fix
the problem, although it might reduce it (literally
weather permitting).

I spoke to Supermicro about this i840 board (PIIIDME)
last year, and all BIOS development has stopped. The
best they could offer me was my existing BIOS
containing the new microcode (which I already have).

Given the information at hand, my options would seem
to be:
a) reinstall the original 733 MHz CPUs, accepting that
this is the best that the board can do. These CPUs
would need the FSB putting back to 133 MHz so it's not
exactly a "slam-dunk" success. However, I have run
them  successfully in hot weather before, so I'm
reasonably confident that they would work now.
b) relocate close to one of the Earth's Poles, where
seasonal temperatures are more favourable to CPUs.

Stablising the 933 MHZ CPUs on this board properly
would appear to need extra help from Intel. Judging by
what I've seen, Linux does seem to have a window in
its boot sequence when any extra workaround could
safely be applied.

Cheers,
Chris

P.S. I'm now going to set up an initrd anyway out of
sheer bloody-mindedness ... ;-)


________________________________________________________________________
Want to chat instantly with your online friends?  Get the FREE Yahoo!
Messenger http://uk.messenger.yahoo.com/

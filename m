Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751094AbWGAAR6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751094AbWGAAR6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 20:17:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750967AbWGAAR6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 20:17:58 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:41000 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750834AbWGAAR5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 20:17:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IAr8oAOeck9+/c3Xg5rmpfwiFL1etMEnJPB9Hupuwq51UhD3TeM+pQ801FBSHa2Yhl80hq+TSfz+RRd8HPhwxVsmg0FIZRrRBc/lzRSaCtdlEXBFA52SlHq0siuZMDyfRNQpCspDDYWBdAIcgenchpMcfRSabUZ6Pk+puaAaJ10=
Message-ID: <4807377b0606301717t35d783cbgad6d67daeb163f5a@mail.gmail.com>
Date: Fri, 30 Jun 2006 17:17:55 -0700
From: "Jesse Brandeburg" <jesse.brandeburg@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: 2.6.17-mm4
Cc: linux-kernel@vger.kernel.org, "john stultz" <johnstul@us.ibm.com>
In-Reply-To: <20060630171212.50630182.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060629013643.4b47e8bd.akpm@osdl.org>
	 <4807377b0606291053g602f3413gb3a60d1432a62242@mail.gmail.com>
	 <20060629120518.e47e73a9.akpm@osdl.org>
	 <4807377b0606301653n68bee302t33c2cc28b8c5040@mail.gmail.com>
	 <20060630171212.50630182.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/30/06, Andrew Morton <akpm@osdl.org> wrote:
> "Jesse Brandeburg" <jesse.brandeburg@gmail.com> wrote:
> >
> > On 6/29/06, Andrew Morton <akpm@osdl.org> wrote:
> > > On Thu, 29 Jun 2006 10:53:03 -0700
> > > "Jesse Brandeburg" <jesse.brandeburg@gmail.com> wrote:
> > >
> > > > can't boot 2.6.17-mm4 on x86_64 Intel 7520 platform.
> > > > instant reboot after printing:
> > > >   Booting 'Red Hat Enterprise Linux AS (2.6.17-mm4-jesse)'
> > > >
> > > > root (hd0,0)
> > > >  Filesystem type is ext2fs, partition type 0x83
> > > > kernel /vmlinuz-2.6.17-mm4-jesse ro root=LABEL=/1 rhgb hdc=none video=atyfb:102
> > > > 4x768M-32@70 console=ttyS0,115200n8 console=tty1 panic=30
> > > >    [Linux-bzImage, setup=0x1e00, size=0x199883]
> > > > initrd /initrd-2.6.17-mm4-jesse.img
> > > >    [Linux-initrd @ 0x37efd000, 0xf2da8 bytes]
> > > >
> > > > ie no kernel output
> > >
> > > Your .config works OK on my x86_64 box.  Wanna swap? ;)
> > >
> > > > where should i start to debug?  I can do a bisect pretty easily too
> > > > using git if necessary.
> > >
> > > That would be great, thanks.  Your options are to do a git bisect using
> > >
> > > git://git.kernel.org/pub/scm/linux/kernel/git/smurf/linux-trees.git#v2.6.17-mm4
> > >
> > > (Beware that the mm-to-git trees have had a few problem reports and I'm not
> > > aware of anyone previously using them for a bisect).
> > >
> > > or to install quilt and use
> > > http://www.zip.com.au/~akpm/linux/patches/stuff/bisecting-mm-trees.txt
> >
> > had to pull in linus' tree in order to get the latest 2.6.17 label,
> > bisect complete, this patch appeared to make the problem
> > ad596171ed635c51a9eef829187af100cbf8dcf7 is first bad commit
> > diff-tree ad596171ed635c51a9eef829187af100cbf8dcf7 (from
> > 734efb467b31e56c2f9430590a9aa867ecf3eea1)
> > Author: john stultz <johnstul@us.ibm.com>
> > Date:   Mon Jun 26 00:25:06 2006 -0700
> >
> >     [PATCH] Time: Use clocksource infrastructure for update_wall_time
> >
> >     Modify the update_wall_time function so it increments time using the
> >     clocksource abstraction instead of jiffies.  Since the only
> > clocksource driver
> >     currently provided is the jiffies clocksource, this should result in no
> >     functional change.  Additionally, a timekeeping_init and timekeeping_resume
> >     function has been added to initialize and maintain some of the new
> > timekeping
> >     state.
> >
> >     [hirofumi@mail.parknet.co.jp: fixlet]
> >     Signed-off-by: John Stultz <johnstul@us.ibm.com>
> >     Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
> >     Signed-off-by: Andrew Morton <akpm@osdl.org>
> >     Signed-off-by: Linus Torvalds <torvalds@osdl.org>
> >
> > :040000 040000 3ea3b4140ffa318c20513d596eb063430760822a
> > 30d3669ec72a2a9edc69a72fadfb4158bd17d6fe M      include
> > :040000 040000 5c222365dd5b1fdbfebabd40106732b9bfcc3f0d
> > adbb7244617875fe7e0f3014e90808ddf6115976 M      init
> > :040000 040000 24c5fcb7f26396cf231c7ab06ddc8fb187ebe5d4
> > 8157df180abe5f6f058c050f1d017b46334f5c8f M      kernel
> >
> > however i cannot revert this patch from -mm4 because of conflicts ( i
> > might be able to revert a specific set of patches from mm)
>
> Thanks.  I assume mainline is doing this now.
>
> I guess it has to be dying in timekeeping_init().  Have you tried
> earlyprintk=vga or, better, earlyprintk=serial,ttyS0,9600?

wish you would have said that earlier, i looked in
kernel-parameters.txt and didn't find earlyprinkt when searching for
debug :-(

two traces follow, one with the stock 2.6.17-mm4 kernel and the other
with the bisect kernel.


Linux version 2.6.17-mm4-jesse (root@lindenhurst-2.jf.intel.com) (gcc version 3.
4.4 20050721 (Red Hat 3.4.4-2)) #1 SMP Thu Jun 29 08:53:59 PDT 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000ebaf0 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000005ffd0000 (usable)
 BIOS-e820: 000000005ffd0000 - 000000005ffdf000 (ACPI data)
 BIOS-e820: 000000005ffdf000 - 0000000060000000 (ACPI NVS)
 BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
 BIOS-e820: 00000000ffc00000 - 0000000100000000 (reserved)
kernel direct mapping tables up to 100000000 @ 8000-d000
DMI not present or invalid.
No NUMA configuration found
Faking a node at 0000000000000000-000000005ffd0000
Bootmem setup node 0 0000000000000000-000000005ffd0000
ACPI: PM-Timer IO Port: 0x408
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:3 APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x06] enabled)
Processor #6 15:3 APIC version 20
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x01] enabled)
Processor #1 15:3 APIC version 20
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x07] enabled)
Processor #7 15:3 APIC version 20
ACPI: IOAPIC (id[0x08] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 8, version 32, address 0xfec00000, GSI 0-23
ACPI: IOAPIC (id[0x09] address[0xfec80000] gsi_base[24])
IOAPIC[1]: apic_id 9, version 32, address 0xfec80000, GSI 24-47
ACPI: IOAPIC (id[0x0a] address[0xfec80400] gsi_base[48])
IOAPIC[2]: apic_id 10, version 32, address 0xfec80400, GSI 48-71
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
Setting APIC routing to flat
ACPI: HPET id: 0x8086a202 base: 0xfed00000
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 68000000 (gap: 60000000:80000000)
Built 1 zonelists.  Total pages: 386918
Kernel command line: ro root=LABEL=/1 rhgb hdc=none video=atyfb:1024x768M-32@70
console=ttyS0,115200n8 console=tty1 panic=30 earlyprintk=serial,ttyS0,115200 ini
tcall_debug debug
ide_setup: hdc=none
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 32768 bytes)
time.c: Using 14.318180 MHz WALL HPET GTOD HPET/TSC timer.
time.c: Detected 3600.267 MHz processor.
Unable to handle kernel NULL pointer dereference at 0000000000000034 RIP:
 [<ffffffff8103396a>] do_timer+0x40/0x556
PGD 0
Oops: 0000 [1] SMP
last sysfs file:
CPU 0
Modules linked in:
Pid: 0, comm: swapper Not tainted 2.6.17-mm4-jesse #1
RIP: 0010:[<ffffffff8103396a>]  [<ffffffff8103396a>] do_timer+0x40/0x556
RSP: 0018:ffffffff8130ce80  EFLAGS: 00010002
RAX: 0000000000000000 RBX: 000000000036ef8b RCX: 0000005135618814
RDX: 0000000000000000 RSI: 00000000001233fd RDI: ffffffff813adec8
RBP: 0000000000000000 R08: 00000000fffffffe R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000000019fb
R13: 0000000000000000 R14: ffffffff813adec8 R15: ffffffff813adec8
FS:  0000000000000000(0000) GS:ffffffff813a0000(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 0000000000000034 CR3: 0000000001001000 CR4: 00000000000006a0
Process swapper (pid: 0, threadinfo ffffffff813ac000, task ffffffff8128be00)
Stack:  0000000000000000 0000000000000000 0000000000000001 0000000000000000
 0000000000000000 000000000036ef8b 0000000000000000 00000000000019fb
 0000000000000000 ffffffff813adec8 ffffffff813adec8 ffffffff8100d442
Call Trace:
 <IRQ> [<ffffffff8100d442>] main_timer_handler+0x1ed/0x3ad
 [<ffffffff8100d614>] timer_interrupt+0x12/0x27
 [<ffffffff8105076a>] handle_IRQ_event+0x29/0x5a
 [<ffffffff81050837>] __do_IRQ+0x9c/0xfd
 [<ffffffff8100bf27>] do_IRQ+0x63/0x71
 [<ffffffff810098b8>] ret_from_intr+0x0/0xa
 <EOI>

Code: 8b 4a 34 48 d3 e0 48 01 42 58 48 8b 2d b5 3b 31 00 4c 8b 6d
RIP  [<ffffffff8103396a>] do_timer+0x40/0x556
 RSP <ffffffff8130ce80>
CR2: 0000000000000034
 <0>Kernel panic - not syncing: Aiee, killing interrupt handler!

and with the bisect kernel, slightly different
Bootdata ok (command line is ro root=LABEL=/1 rhgb hdc=none video=atyfb:1024x768
M-32@70 console=ttyS0,115200n8 console=tty1 panic=30 earlyprintk=serial,ttyS0,11
5200 initcall_debug debug)
Linux version 2.6.17-bisect (root@lindenhurst-2.jf.intel.com) (gcc version 3.4.4
 20050721 (Red Hat 3.4.4-2)) #15 SMP Fri Jun 30 16:09:50 PDT 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000ebaf0 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000005ffd0000 (usable)
 BIOS-e820: 000000005ffd0000 - 000000005ffdf000 (ACPI data)
 BIOS-e820: 000000005ffdf000 - 0000000060000000 (ACPI NVS)
 BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
 BIOS-e820: 00000000ffc00000 - 0000000100000000 (reserved)
kernel direct mapping tables up to 100000000 @ 8000-8000
DMI not present or invalid.
ACPI: PM-Timer IO Port: 0x408
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:3 APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x06] enabled)
Processor #6 15:3 APIC version 20
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x01] enabled)
Processor #1 15:3 APIC version 20
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x07] enabled)
Processor #7 15:3 APIC version 20
ACPI: IOAPIC (id[0x08] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 8, version 32, address 0xfec00000, GSI 0-23
ACPI: IOAPIC (id[0x09] address[0xfec80000] gsi_base[24])
IOAPIC[1]: apic_id 9, version 32, address 0xfec80000, GSI 24-47
ACPI: IOAPIC (id[0x0a] address[0xfec80400] gsi_base[48])
IOAPIC[2]: apic_id 10, version 32, address 0xfec80400, GSI 48-71
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
Setting APIC routing to flat
ACPI: HPET id: 0x8086a202 base: 0xfed00000
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 68000000 (gap: 60000000:80000000)
Checking aperture...
Built 1 zonelists.  Total pages: 385592
Kernel command line: ro root=LABEL=/1 rhgb hdc=none video=atyfb:1024x768M-32@70
console=ttyS0,115200n8 console=tty1 panic=30 earlyprintk=serial,ttyS0,115200 ini
tcall_debug debug
ide_setup: hdc=none
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 32768 bytes)
time.c: Using 14.318180 MHz WALL HPET GTOD HPET/TSC timer.
time.c: Detected 3600.266 MHz processor.
Unable to handle kernel NULL pointer dereference at 0000000000000020 RIP:
<ffffffff80236e71>{do_timer+49}
PGD 0
Oops: 0000 [1] SMP
CPU 0
Modules linked in:
Pid: 0, comm: swapper Not tainted 2.6.17-bisect #15
RIP: 0010:[<ffffffff80236e71>] <ffffffff80236e71>{do_timer+49}
RSP: 0018:ffffffff80564e98  EFLAGS: 00010002
RAX: 0000000000000000 RBX: 000000000036ef8a RCX: 00000064e38a4032
RDX: 0000000000000000 RSI: 00000000001233fe RDI: ffffffff805f3e48
RBP: ffffffff80564eb8 R08: 0000000000000036 R09: 0000000000000000
R10: ffffffff805f3e70 R11: 0000000000000000 R12: 0000000000000000
R13: 00000000000019fa R14: 0000000000000001 R15: ffffffff805f3e48
FS:  0000000000000000(0000) GS:ffffffff805e5000(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 0000000000000020 CR3: 0000000000201000 CR4: 00000000000006a0
Process swapper (pid: 0, threadinfo ffffffff805f2000, task ffffffff804adb00)
Stack: 000000000036ef8a 0000000000000000 00000000000019fa 0000000000000000
       ffffffff80564ef8 ffffffff8020e1c3 0000000000000000 ffffffff804afb00
       0000000000000000 ffffffff805f3e48
Call Trace: <IRQ> <ffffffff8020e1c3>{main_timer_handler+547}
       <ffffffff8020e445>{timer_interrupt+21} <ffffffff802569e3>{handle_IRQ_even
t+51}
       <ffffffff80256ae2>{__do_IRQ+178} <ffffffff8020cd65>{do_IRQ+69}
       <ffffffff8020a1aa>{ret_from_intr+0} <EOI> <ffffffff8043f7b3>{_spin_unlock
_irqrestore+19}
       <ffffffff80256e8e>{setup_irq+222} <ffffffff805fc33e>{time_init+990}
       <ffffffff805f577a>{start_kernel+250} <ffffffff805f5295>{_sinittext+661}

Code: ff 50 20 4c 8b 2d 3d 2b 36 00 48 8b 15 3e 2b 36 00 49 89 c4
RIP <ffffffff80236e71>{do_timer+49} RSP <ffffffff80564e98>
CR2: 0000000000000020
 <0>Kernel panic - not syncing: Aiee, killing interrupt handler!

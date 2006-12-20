Return-Path: <linux-kernel-owner+w=401wt.eu-S932897AbWLTB3c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932897AbWLTB3c (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 20:29:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932865AbWLTB3c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 20:29:32 -0500
Received: from smtp.osdl.org ([65.172.181.25]:51907 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932897AbWLTB3b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 20:29:31 -0500
Date: Tue, 19 Dec 2006 17:29:00 -0800
From: Andrew Morton <akpm@osdl.org>
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: Greg Kroah-Hartman <gregkh@suse.de>, bugme-daemon@bugzilla.kernel.org,
       Zhang Yanmin <yanmin.zhang@intel.com>, <linux-kernel@vger.kernel.org>,
       take@libero.it, ard@telegraafnet.nl, agalanin@mera.ru
Subject: Re: [Bug 7505] Linux-2.6.18 fails to boot on AMD64 machine
Message-Id: <20061219172900.37312b38.akpm@osdl.org>
In-Reply-To: <m1mz5lqhfi.fsf@ebiederm.dsl.xmission.com>
References: <200612181543.kBIFhcIc001555@fire-2.osdl.org>
	<m1mz5lqhfi.fsf@ebiederm.dsl.xmission.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Dec 2006 09:48:01 -0700
ebiederm@xmission.com (Eric W. Biederman) wrote:

> bugme-daemon@bugzilla.kernel.org writes:
> 
> > http://bugzilla.kernel.org/show_bug.cgi?id=7505
> >
> > ------- Additional Comments From agalanin@mera.ru  2006-12-18 07:39 -------
> > OK, fixed.
> 
> 
> Greg.
> 
> It appears commit d71374dafbba7ec3f67371d3b7e9f6310a588808 which
> replaced the pci bus spinlock with a semaphore causes some systems not
> to boot.  I haven't a clue why.   
> 
> So I figure I would toss the ball over to your court to see if you can
> look and see what needs to happen to resolve this problem.
> 
> There appears to be at least one positive confirmation that reverting
> this patch allows this patch fixes the problems.
> 

That's weird.

Quoting the bug report:


There are output from kernel with enabled 'earlyprintk' option.

Linux version 2.6.19-rc5 (root@gaa) (gcc version 4.1.2 20060901 (prerelease) 
(Debian 4.1.1-13)) #2 PREEMPT Sat Nov 11 16:04:00 MSK 2006
Command line: BOOT_IMAGE=Linux-bug ro root=303 
video=radeonfb:mode:1024x768-16@60 idebus=66 earlyprintk=serial,ttyS0,9600,keep
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 000000001fff3000 (ACPI NVS)
 BIOS-e820: 000000001fff3000 - 0000000020000000 (ACPI data)
 BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
end_pfn_map = 1048576
kernel direct mapping tables up to 100000000 @ 8000-d000
DMI 2.2 present.
Zone PFN ranges:
  DMA             0 ->     4096
  DMA32        4096 ->  1048576
  Normal    1048576 ->  1048576
early_node_map[2] active PFN ranges
    0:        0 ->      159
    0:      256 ->   131056
Nvidia board detected. Ignoring ACPI timer override.
ACPI: PM-Timer IO Port: 0x4008
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 (Bootup-CPU)
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] disabled)
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: BIOS IRQ0 pin2 override ignored.
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: INT_SRC_OVR (bus 0 bus_irq 14 global_irq 14 high edge)
ACPI: INT_SRC_OVR (bus 0 bus_irq 15 global_irq 15 high edge)
Setting APIC routing to flat
Using ACPI (MADT) for SMP configuration information
Nosave address range: 000000000009f000 - 00000000000a0000
Nosave address range: 00000000000a0000 - 00000000000f0000
Nosave address range: 00000000000f0000 - 0000000000100000
Allocating PCI resources starting at 30000000 (gap: 20000000:c0000000)
Built 1 zonelists.  Total pages: 128336
Kernel command line: BOOT_IMAGE=Linux-bug ro root=303 
video=radeonfb:mode:1024x768-16@60 idebus=66 earlyprintk=serial,ttyS0,9600,keep
ide_setup: idebus=66
Initializing CPU#0
general protection fault: 013b [1] PREEMPT 
CPU 0 
Modules linked in:
Pid: 0, comm: swapper Not tainted 2.6.19-rc5 #2
RIP: 0010:[<ffffffff8010fac6>]  [<ffffffff8010fac6>] init_8259A+0xb6/0xf0
RSP: 0018:ffffffff803cdf68  EFLAGS: 00010246
RAX: 00000000000000ff RBX: 0000000000000246 RCX: 00000000b4fcb55f
RDX: 0000000000000011 RSI: ffffffff8013cf40 RDI: 0000000000000199
RBP: 0000000000000000 R08: 00000000ffffffff R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000070 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffffffff803c0000(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 0000000000f0aed9 CR3: 0000000000101000 CR4: 00000000000006a0
Process swapper (pid: 0, threadinfo ffffffff803cc000, task ffffffff80360360)
Stack:  0000000000000000 ffffffff803d3a46 800089360a40206f 0000000000090000
 000000000008e000 ffffffff803d3ab9 0000000000000000 ffffffff803ddd99
 0000000000090000 ffffffff803cf65a 0000000000000000 0000000000090000
Call Trace:
 [<ffffffff803d3a46>] init_ISA_irqs+0x16/0x80
 [<ffffffff803d3ab9>] init_IRQ+0x9/0x1e0
 [<ffffffff803ddd99>] rcu_cpu_notify+0x49/0x60
 [<ffffffff803cf65a>] start_kernel+0xda/0x1f0
 [<ffffffff803cf146>] _sinittext+0x146/0x150


I assume we went splat in start_kernel->trap_init->cpu_init.  We shouldn't
have touched pci_bus_lock that early?  Perhaps acpi does PCI things very
early..

Conceivably an accidental early local_irq_enable could cause bad things,
but that rwsem should be 100% uncontended.

Could the reporters please determine whether disabling the various
CONFIG_DEBUG_* options prevents this?  Such as CONFIG_DEBUG_LOCKDEP,
CONFIG_DEBUG_LOCK_ALLOC, CONFIG_PROVE_LOCKING, etc?

Also, some additional oops traces would be nice, if we can get them.

(Please do reply-to-all via email from now on, rather than using the
bugzilla UI).


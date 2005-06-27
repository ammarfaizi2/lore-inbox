Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261893AbVF0Hr5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261893AbVF0Hr5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 03:47:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261896AbVF0Hr4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 03:47:56 -0400
Received: from tornado.reub.net ([60.234.136.108]:28113 "EHLO tornado.reub.net")
	by vger.kernel.org with ESMTP id S261893AbVF0Hro (ORCPT
	<rfc822;<linux-kernel@vger.kernel.org>>);
	Mon, 27 Jun 2005 03:47:44 -0400
Message-ID: <42BFAF1F.8050201@reub.net>
Date: Mon, 27 Jun 2005 19:47:43 +1200
From: Reuben Farrelly <reuben-lkml@reub.net>
User-Agent: Mozilla Thunderbird 1.0+ (Windows/20050624)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.12-mm2
References: <fa.h6rvsi4.j68fhk@ifi.uio.no>	<42BFA05B.1090208@reub.net> <20050627002429.40231fdf.akpm@osdl.org>
In-Reply-To: <20050627002429.40231fdf.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 27/06/2005 7:24 p.m., Andrew Morton wrote:
> Reuben Farrelly <reuben-lkml@reub.net> wrote:
>> ...
>>
>> Some bad stuff seems to be happening here (this is new to -mm2; -mm1 did not 
>> have this problem).
>>
>> It's 100% reproduceable, although seems to happen at slightly different places 
>> in the bootup, especially at the end.  Did I miss a patch for this?
>>
> 
> Why do you keep breaking my kernel?

Sadistic enjoyment ;-)

>> Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing enabled
>> ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
>> ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
>>   [<c0103ad0>] dump_stack+0x17/0x19
>>   [<c01cab4b>] spin_bug+0x5b/0x67
>>   [<c01cac9c>] _raw_spin_lock+0x78/0x7a
>>   [<c0314ad9>] _spin_lock+0x8/0xa
>>   [<c0313370>] schedule+0x6c0/0xd68
>>   [<c0100d31>] cpu_idle+0x64/0x66
>>   [<c01002c5>] rest_init+0x25/0x27
>>   [<c03fe8af>] start_kernel+0x154/0x167
>>   [<c010020f>] 0xc010020f
>> Kernel panic - not syncing: bad locking
> 
> That's odd - we lost a printk there:
> 
> 	printk("BUG: spinlock %s on CPU#%d, %s/%d, %p\n", msg,
> 		smp_processor_id(), current->comm, current->pid, lock);
> 
> which is a shame, because it would have told us stuff.  Do you have any
> traces which do have that message?

Uh. Likely got munged within hyperterm.

Here's a better one just created using QVT:

usbcore: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
usb 3-1: new full speed USB device using uhci_hcd and address 2
hub 3-1:1.0: USB hub found
hub 3-1:1.0: 4 ports detected
usbcore: registered new driver hiddev
usb 4-1: new full speed USB device using uhci_hcd and address 2
drivers/usb/class/usblp.c: usblp0: USB Bidirectional printer dev 2 if 0 alt 0 
proto 2 vid 0x03F0 pid 0x6204
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.01:USB HID core driver
mice: PS/2 mouse device common for all mice
input: PC Speaker
md: raid1 personality registered as nr 3
md: md driver 0.90.2 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 3.38
NET: Registered protocol family 2
IP: routing cache hash table of 1024 buckets, 24Kbytes
TCP established hash table entries: 32768 (order: 7, 786432 bytes)
TCP bind hash table entries: 32768 (order: 7, 655360 bytes)
TCP: Hash tables configured (established 32768 bind 32768)
TCP reno registered
GRE over IPv4 tunneling driver
ip_conntrack version 2.1 (4095 buckets, 32760 max) - 212 bytes per conntrack
usb 3-1.1: new low speed USB device using uhci_hcd and address 3
BUG: spinlock recursion on CPU#0, swapper/0, c1407160
  [<c0103ad0>] dump_stack+0x17/0x19
  [<c01cab4b>] spin_bug+0x5b/0x67
  [<c01cac9c>] _raw_spin_lock+0x78/0x7a
  [<c0314ad9>] _spin_lock+0x8/0xa
  [<c0117399>] scheduler_tick+0xd0/0x37c
  [<c01256b3>] update_process_times+0x58/0xd7
  [<c0110f50>] smp_apic_timer_interrupt+0xde/0xe0
  [<c0103614>] apic_timer_interrupt+0x1c/0x24
  [<c0100d1e>] cpu_idle+0x51/0x66
  [<c01002c5>] rest_init+0x25/0x27
  [<c03fe8af>] start_kernel+0x154/0x167
  [<c010020f>] 0xc010020f
Kernel panic - not syncing: bad locking
  Badness in smp_call_function at arch/i386/kernel/smp.c:553
  [<c0103ad0>] dump_stack+0x17/0x19
  [<c010f980>] smp_call_function+0x137/0x13c
  [<c010fb49>] smp_send_stop+0x1e/0x27
  [<c011c2cf>] panic+0x4c/0x102
  [<c01cab57>] __spin_lock_debug+0x0/0xcd
  [<c01cac9c>] _raw_spin_lock+0x78/0x7a
  [<c0314ad9>] _spin_lock+0x8/0xa
  [<c0117399>] scheduler_tick+0xd0/0x37c
  [<c01256b3>] update_process_times+0x58/0xd7
  [<c0110f50>] smp_apic_timer_interrupt+0xde/0xe0
  [<c0103614>] apic_timer_interrupt+0x1c/0x24
  [<c0100d1e>] cpu_idle+0x51/0x66
  [<c01002c5>] rest_init+0x25/0x27
  [<c03fe8af>] start_kernel+0x154/0x167
  [<c010020f>] 0xc010020f

> Anyway, scary trace.  It look like some spinlock is thought to be in the
> wrong state in schedule().  Send the .config, please.

Now online at  http://www.reub.net/kernel/.config

Reuben


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262500AbVFIWlU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262500AbVFIWlU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 18:41:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262501AbVFIWlN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 18:41:13 -0400
Received: from rrcs-24-199-11-214.west.biz.rr.com ([24.199.11.214]:45275 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262500AbVFIWjL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 18:39:11 -0400
Message-ID: <42A861F8.9000301@cyte.com>
Date: Thu, 09 Jun 2005 08:36:24 -0700
From: Jeff Wiegley <jeffw@cyte.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050402)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: amd64 cdrom access locks system
References: <42A64556.4060405@cyte.com> <20050608052354.7b70052c.akpm@osdl.org>
In-Reply-To: <20050608052354.7b70052c.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Jeff Wiegley <jeffw@cyte.com> wrote:
> 
>>I've been having this problem in 2.6.12-rc2 and 2.6.12-rc6.
>>
>> Any continued access to /dev/hda causes a complete and total
>> lock up of the system. Nothing is logged to /var/log/kernel
>> or /var/log/messages. Just a solid freeze.
>>
>> This happens with at least cdparanoia and cdrecord as well.
>>
>> The machine is an AMD64 FX55 CPU running in a shuttle
>> ST20G5 chassis.
> 
> 
> Can you identify an earlier kernel which worked OK?
> 
> How locked up is it?  Does sysrq-P not work?  Is it pingable?  Tried
> enabling the nmi watchdog?

Sorry for the length of this message. Based on you suggestions I
tried lots of various tests and although none of them fixed the
problem I at least have a wealth of information (possibly useless)
to report here...

When it locks up while running cdparanoia the machine is *not* pingable.

The NMI watchdog doesn't seem to be resetting anything. (Though I've
never used it before so maybe it's not enabled at all even though
I did compile in ACPI and passed nmi_watchdog=1 on the kernel
command line. (/proc/sys/kernel/unknown_nmi_panic is present, if that
helps)

sysrq-P does work. (I won't provide what it spat out since I have a
panic trace instead.)

Ah.. You need to be at a real console and not in X-windows to get
anything from sysrq. (I didn't know that.) anyhow, when I run
"cdparanoia -d /dev/hda 5" from a real console it fires up, copies
a few sectors from the drive and then panics with this... (I didn't
see the panic before because I was in X11)

warning: many lost ticks.
Your time source seems to be instable or some driver is hogging interupts
rip default_idle+0x24/0x30
Falling back to HPET
divide error: 0000 [1] PREEMPT
CPU 0
Modules linked in: deflate zlib_deflate twofish serpent aes blowfish des 
sha256 sha1 crypto_null xfrm_user xfrm4_tunnel ipcomp esp4 ah4 af_key 
ipv6 alim15x3 ide_generic reiserfs tun thermal processor fan button ac 
battery i2c_ali15x3 i2c_ali1535 i2c_core ehci_hcd usbhid ohci_hcd tg3 
ohci1394 sbp2 ieee1394 psmouse ide_disk ide_cd ide_core sata_uli sr_mod 
cdrom sd_mod sata_promise libata sg usb_storage scsi_mod unix
Pid: 0, comm: swapper Not tainted 2.6.12-rc6-jw9
RIP: 0010:[<ffffffff80112704>] <ffffffff80112704>{timer_interrupt+244}
RSP: 0000:ffffffff803a09c0  EFLAGS: 00010046
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 00000000ffffffff R08: 0000000000000000 R09: 0000000000010101
R10: 000000000000000e R11: 0000000000000000 R12: ffffffff803a0a38
R13: 0000000000000000 R14: 0000000000000000 R15: ffffffff803e1fb0
FS:  00002aaaab1a2640(0000) GS:ffffffff803d9f40(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 00002aaaab51f430 CR3: 0000000074704000 CR4: 00000000000006e0
Process swapper (pid: 0, threadinfo ffffffff803e0000, task ffffffff802f62c0)
Stack: 0000000000000086 ffffffff802f6e00 0000000000000000 ffffffff803a0a38
        0000000000000000 ffffffff801547fc 0000000000000000 0000000000000000
        ffffffff803da040 ffffffff802f6e00
Call Trace: <IRQ> <ffffffff801547fc>{handle_IRQ_event+44} 
<ffffffff80154905>{__do_IRQ+213}
        <ffffffff80111402>{do_IRQ+66} <ffffffff8010edbd>{ret_from_intr+0}
        <ffffffff80138108>{__do_softirq+72} 
<ffffffff801381a5>{do_softirq+53}
        <ffffffff801382bc>{irq_exit+76} <ffffffff80111407>{do_IRQ+71}
        <ffffffff8010edbd>{ret_from_intr+0}  <EOI> 
<ffffffff8010eeed>{retint_kernel+38}
        <ffffffff8010c820>{default_idle+0} 
<ffffffff8010c844>{default_idle+36}
        <ffffffff8010c991>{cpu_idle+49} <ffffffff803e2863>{start_kernel+435}
        <ffffffff803e223f>{x86_64_start_kernel+319}

Code: 48 f7 f6 48 01 05 ba 67 29 00 e9 dd 00 00 00 83 f8 03 75 0d
RIP <ffffffff80112704>{timer_interrupt+244} RSP <ffffffff803a09c0>
  <0>Kernel panic - not syncing: Aiee, killing interrupt handler!

Ummm... I have no idea what to do with all of that; I hope it's
highly meaningful to you. From what I can read it looks like an
interrupt problem since the call trace is all IRQ-thingies.

Would it do any good to try a different physical CDRom drive? The
current one is listed as
     hda: SONY DVD RW DRU-500A, ATAPI CD/DVD-ROM drive.
(I have had problems with it being unable to burn DVD-R under windows 
(blech!) which it should be able to, so maybe the drive is
dead/misbehaving. But I don't want to rip apart my cases and swap
drives if it's a higher level IRQ/driver problem.)

I can use an external USB cdrom reader without problems.

By the way. This shuttle case/motherboard is relatively new and
it seems to have a lot of the chipsets in it that are not recognized
by the kernel:

lspci: [with recognized stuff snipped out]

0000:00:00.0 Host bridge: ATI Technologies Inc: Unknown device 5950 (rev 01)
0000:00:01.0 PCI bridge: ATI Technologies Inc: Unknown device 5a3f
0000:00:06.0 PCI bridge: ATI Technologies Inc: Unknown device 5a38
0000:00:1d.0 0403: ALi Corporation: Unknown device 5461
0000:00:1e.0 ISA bridge: ALi Corporation: Unknown device 1573 (rev 31)
0000:00:1f.0 IDE interface: ALi Corporation M5229 IDE (rev c7)
0000:00:1f.1 RAID bus controller: ALi Corporation: Unknown device 5287 
(rev 02)
0000:01:05.0 VGA compatible controller: ATI Technologies Inc: Unknown 
device 5954

Maybe these unknown devices are causing problems with interrupt
assignments or service? I would be willing to help in any way possible
to get this case/motherboard fully supported but I'm not a chipset
or kernel guru. But I've got some time and I'm willing to reboot
and test as much as is needed.

Back to the CD burner. I think 2.6.8 worked and was the highest
working kernel. And if I remember correctly it worked really slow
(max speed 4 or 8) because DMA couldn't be enabled for the device. But
I can't confirm that now since I had to switch to 2.6.9 or higher to
get the ULI serial ATA driver. So now I can't boot 2.6.8 on this machine
because it won't find a root filesystem. (I borrowed a promise SATA
card to do the original install.)

Hmmm.. hdparm /dev/hda:
  IO_support   =  0 (default 16-bit)
  unmaskirq    =  0 (off)
  using_dma    =  0 (off)
  keepsettings =  0 (off)
  readonly     =  0 (off)
  readahead    = 256 (on)
  HDIO_GETGEO failed: Invalid argument

and I cannot manually enable DMA either (I kind of expected to be able
to)...
root@mail:~# hdparm -d 1 /dev/hda

/dev/hda:
  setting using_dma to 1 (on)
  HDIO_SET_DMA failed: Operation not permitted
  using_dma    =  0 (off)

Sorry I can't help more. The deepest I ever got in to the kernel
workings was a port mapped non-interrupt driven device driver for
an NTSC capture device (subject to NDA) in the 2.2 kernel. Everything
else is grand voodoo to me.

I hope you can help with this. Thanks.

-- 
Jeff Wiegley, PhD
Cyte.Com, LLC
(ignore:cea2d3a38843531c7def1deff59114de)

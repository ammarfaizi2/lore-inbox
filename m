Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316895AbSFCOcz>; Mon, 3 Jun 2002 10:32:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317031AbSFCOcy>; Mon, 3 Jun 2002 10:32:54 -0400
Received: from [195.63.194.11] ([195.63.194.11]:20743 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S316895AbSFCOcx>; Mon, 3 Jun 2002 10:32:53 -0400
Message-ID: <3CFB7063.4070805@evision-ventures.com>
Date: Mon, 03 Jun 2002 15:34:27 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, pl
MIME-Version: 1.0
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Oops Linux 2.5.20
In-Reply-To: <Pine.LNX.4.33.0206021853030.1383-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The folowing happens during module load time:

  <6>note: modprobe[251] exited with preempt_count 1
kernel BUG at /usr/src/linux/include/linux/device.h:115!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c01924d7>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000000   ebx: cafaa000   ecx: cd074f50   edx: cd074f48
esi: 00000000   edi: 00000000   ebp: bfffeba8   esp: cafabf30
ds: 0018   es: 0018   ss: 0018
Stack: 00000010 00000246 c0125450 cafaa000 cd074f48 00000000 bfffeba8 c01911fb
        cd074f48 cd074f48 c0191170 c0192628 cd074f48 c025abe8 00000000 00000000
        cd0715b9 cd074f48 cd06d000 fffffff0 c0119763 cd06d000 cd06d000 fffffff0
Call Trace: [<c0125450>] [<cd074f48>] [<c01911fb>] [<cd074f48>] [<cd074f48>]
    [<c0191170>] [<c0192628>] [<cd074f48>] [<cd0715b9>] [<cd074f48>] [<c0119763>]

    [<c011894c>] [<c010740f>]
Code: 0f 0b 73 00 c0 73 23 c0 e9 26 ff ff ff 8d b6 00 00 00 00 8d

 >>EIP; c01924d7 <driver_for_each_dev+e7/130>   <=====
Trace; c0125450 <exec_usermodehelper+190/240>
Trace; cd074f48 <[parport].bss.end+9369/b421>
Trace; c01911fb <pci_assign_resource+35b/360>
Trace; cd074f48 <[parport].bss.end+9369/b421>
Trace; cd074f48 <[parport].bss.end+9369/b421>
Trace; c0191170 <pci_assign_resource+2d0/360>
Trace; c0192628 <put_driver+68/c80>
Trace; cd074f48 <[parport].bss.end+9369/b421>
Trace; cd0715b9 <[parport].bss.end+59da/b421>
Trace; cd074f48 <[parport].bss.end+9369/b421>
Trace; c0119763 <try_inc_mod_count+f53/1860>
Trace; c011894c <try_inc_mod_count+13c/1860>
Trace; c010740f <__up_wakeup+1243/2874>
Code;  c01924d7 <driver_for_each_dev+e7/130>
00000000 <_EIP>:
Code;  c01924d7 <driver_for_each_dev+e7/130>   <=====
    0:   0f 0b                     ud2a      <=====
Code;  c01924d9 <driver_for_each_dev+e9/130>
    2:   73 00                     jae    4 <_EIP+0x4> c01924db <driver_for_each_
dev+eb/130>
Code;  c01924db <driver_for_each_dev+eb/130>
    4:   c0                        (bad)
Code;  c01924dc <driver_for_each_dev+ec/130>
    5:   73 23                     jae    2a <_EIP+0x2a> c0192501 <driver_for_eac
h_dev+111/130>
Code;  c01924de <driver_for_each_dev+ee/130>
    7:   c0 e9 26                  shr    $0x26,%cl
Code;  c01924e1 <driver_for_each_dev+f1/130>
    a:   ff                        (bad)
Code;  c01924e2 <driver_for_each_dev+f2/130>
    b:   ff                        (bad)
Code;  c01924e3 <driver_for_each_dev+f3/130>
    c:   ff 8d b6 00 00 00         decl   0xb6(%ebp)
Code;  c01924e9 <driver_for_each_dev+f9/130>
   12:   00 8d 00 00 00 00         add    %cl,0x0(%ebp)


The module in question is apparently:

IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 1024 buckets, 8Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 240k freed
usb.c: registered new driver usbfs
usb.c: registered new driver hub
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,5), internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,1), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Adding Swap: 400640k swap-space (priority -1)
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI IS
APNP enabled
ttyS01 at 0x02f8 (irq = 3) is a 16550A
PCI: Found IRQ 5 for device 00:00.2
PCI: Sharing IRQ 5 with 00:06.0
PCI: Sharing IRQ 5 with 00:0c.1
register_serial(): autoconfig failed
kernel BUG at /usr/src/linux/include/linux/device.h:115!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c01924d7>]    Not tainted
EFLAGS: 00010246
eax: 00000000   ebx: cafaa000   ecx: cd074f50   edx: cd074f48
esi: 00000000   edi: 00000000   ebp: bfffeba8   esp: cafabf30
ds: 0018   es: 0018   ss: 0018
Process modprobe (pid: 251, threadinfo=cafaa000 task=cbc0e080)
Stack: 00000010 00000246 c0125450 cafaa000 cd074f48 00000000 bfffeba8 c01911fb
        cd074f48 cd074f48 c0191170 c0192628 cd074f48 c025abe8 00000000 00000000
        cd0715b9 cd074f48 cd06d000 fffffff0 c0119763 cd06d000 cd06d000 fffffff0
Call Trace: [<c0125450>] [<cd074f48>] [<c01911fb>] [<cd074f48>] [<cd074f48>]
    [<c0191170>] [<c0192628>] [<cd074f48>] [<cd0715b9>] [<cd074f48>] [<c0119763>]

    [<c011894c>] [<c010740f>]

Code: 0f 0b 73 00 c0 73 23 c0 e9 26 ff ff ff 8d b6 00 00 00 00 8d
  <6>note: modprobe[251] exited with preempt_count 1
8139too Fast Ethernet driver 0.9.24
PCI: Found IRQ 11 for device 00:09.0
eth0: RealTek RTL8139 Fast Ethernet at 0xcd081000, 00:e0:18:19:6b:77, IRQ 11
eth0:  Identified 8139 chip type 'RTL-8139C'
eth0: Setting 100mbps half-duplex based on auto-negotiated partner ability 40a1.
Linux Kernel Card Services 3.1.22
   options:  [pci] [cardbus] [pm]
PCI: Found IRQ 11 for device 00:0c.0
PCI: Sharing IRQ 11 with 00:02.0
PCI: Found IRQ 5 for device 00:0c.1
PCI: Sharing IRQ 5 with 00:00.2
PCI: Sharing IRQ 5 with 00:06.0

This corresponds to the following BUG_ON

static inline struct device_driver * get_driver(struct device_driver * drv)
{
	BUG_ON(!atomic_read(&drv->refcount));
	atomic_inc(&drv->refcount);
	return drv;
}

So apparently the module initialization there is
broken in the case of a box without a serial port at all on it.


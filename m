Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289272AbSDAVvi>; Mon, 1 Apr 2002 16:51:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312638AbSDAVv3>; Mon, 1 Apr 2002 16:51:29 -0500
Received: from [194.106.46.201] ([194.106.46.201]:1603 "EHLO
	asus.verdurin.priv") by vger.kernel.org with ESMTP
	id <S289272AbSDAVvT>; Mon, 1 Apr 2002 16:51:19 -0500
Date: Mon, 1 Apr 2002 22:51:08 +0100
From: Adam Huffman <bloch@verdurin.com>
To: linux-kernel@vger.kernel.org
Subject: Oops in emu10k1 driver
Message-ID: <20020401215107.GA28180@asus.verdurin.priv>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

VMware died when I put an audio CD into my DVD drive.  I wouldn't have
mentioned it here but for the fact that there was an Oops and when
decoded it pointed to the emu10k1 driver:


ksymoops 2.4.1 on i686 2.4.19-pre5.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.19-pre5/ (default)
     -m /boot/System.map-2.4.19-pre5 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_maps): mismatch on symbol usb_devfs_handle  , usbcore says f08e7254, /lib/modules/2.4.19-pre5/kernel/drivers/usb/usbcore.o says f08e6d14.  Ignoring /lib/modules/2.4.19-pre5/kernel/drivers/usb/usbcore.o entry
kernel BUG at audio.c:1474!
invalid operand: 0000
CPU:    0
EIP:    0010:[<f091a316>]    Tainted: PF
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00013006
eax: 0000000e   ebx: ecad44c8   ecx: 0000000e   edx: 00003556
esi: 00000002   edi: 0000ffff   ebp: 0000001c   esp: e6465eb8
ds: 0018   es: 0018   ss: 0018
Process vmware (pid: 2674, stackpage=e6465000)
Stack: 00000007 00018000 0001c000 00010000 00014000 00003202 00000000 00000000
       bffff688 f0919637 ecad4480 00000001 00000003 00000003 f0912582 e8fbe0c0
       cfb4fc40 00014560 ecad4480 e6a6e9c0 00000000 00000010 00001f40 02020110
Call Trace: [<f0919637>] [<f0912582>] [<c0131556>] [<c0130503>] [<c013d336>]
   [<c01088bb>]
Code: 0f 0b c2 05 d8 36 92 f0 83 c4 14 5b 5e 5f 5d c3 8d 76 00 8d

>>EIP; f091a316 <[emu10k1]calculate_ifrag+1c6/1e0>   <=====
Trace; f0919637 <[emu10k1]emu10k1_audio_ioctl+11a7/1450>
Trace; f0912582 <[soundcore]soundcore_open+f2/160>
Trace; c0131556 <chrdev_open+36/40>
Trace; c0130503 <dentry_open+e3/180>
Trace; c013d336 <sys_ioctl+176/190>
Trace; c01088bb <system_call+33/38>
Code;  f091a316 <[emu10k1]calculate_ifrag+1c6/1e0>
00000000 <_EIP>:
Code;  f091a316 <[emu10k1]calculate_ifrag+1c6/1e0>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  f091a318 <[emu10k1]calculate_ifrag+1c8/1e0>
   2:   c2 05 d8                  ret    $0xd805
Code;  f091a31b <[emu10k1]calculate_ifrag+1cb/1e0>
   5:   36                        ss
Code;  f091a31c <[emu10k1]calculate_ifrag+1cc/1e0>
   6:   92                        xchg   %eax,%edx
Code;  f091a31d <[emu10k1]calculate_ifrag+1cd/1e0>
   7:   f0 83 c4 14               lock add $0x14,%esp
Code;  f091a321 <[emu10k1]calculate_ifrag+1d1/1e0>
   b:   5b                        pop    %ebx
Code;  f091a322 <[emu10k1]calculate_ifrag+1d2/1e0>
   c:   5e                        pop    %esi
Code;  f091a323 <[emu10k1]calculate_ifrag+1d3/1e0>
   d:   5f                        pop    %edi
Code;  f091a324 <[emu10k1]calculate_ifrag+1d4/1e0>
   e:   5d                        pop    %ebp
Code;  f091a325 <[emu10k1]calculate_ifrag+1d5/1e0>
   f:   c3                        ret    
Code;  f091a326 <[emu10k1]calculate_ifrag+1d6/1e0>
  10:   8d 76 00                  lea    0x0(%esi),%esi
Code;  f091a329 <[emu10k1]calculate_ifrag+1d9/1e0>
  13:   8d 00                     lea    (%eax),%eax


2 warnings issued.  Results may not be reliable.


00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 03)
00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP]
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 40)
00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06)
00:07.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 1a)
00:07.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 1a)
00:07.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
00:07.5 Multimedia audio controller: VIA Technologies, Inc. AC97 Audio Controller (rev 50)
00:09.0 Unknown mass storage controller: Promise Technology, Inc.: Unknown device 4d69 (rev 02)
00:0a.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 10)
00:0c.0 Multimedia audio controller: Creative Labs SB Live! EMU10000 (rev 08)
00:0c.1 Input device controller: Creative Labs SB Live! (rev 08)
00:0d.0 FireWire (IEEE 1394): Lucent Microelectronics: Unknown device 5811 (rev 04)
01:00.0 VGA compatible controller: nVidia Corporation NV15 (Geforce2 GTS) (rev a3)

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275857AbRJGAJd>; Sat, 6 Oct 2001 20:09:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275859AbRJGAJX>; Sat, 6 Oct 2001 20:09:23 -0400
Received: from tmhoyle.gotadsl.co.uk ([195.149.46.162]:47122 "EHLO
	mail.cvsnt.org") by vger.kernel.org with ESMTP id <S275857AbRJGAJL>;
	Sat, 6 Oct 2001 20:09:11 -0400
From: "Tony Hoyle" <tmh@nothing-on.tv>
Subject: Oops using ohci1394 on 2.4.10-ac4
Date: Sun, 07 Oct 2001 01:09:36 +0100
Organization: Magenta netLogic
Message-ID: <9po6g0$9qu$1@sisko.my.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: sisko.my.home 1002413376 10078 192.168.100.2 (7 Oct 2001 00:09:36 GMT)
X-Complaints-To: abuse@cvsnt.org
User-Agent: Pan/0.10.0.91 (Unix)
X-Comment-To: ALL
X-No-Productlinks: Yes
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been trying to get my 1394 card working on Linux...  It's possible
this card (D-Link DFW500) isn't supported, but it probably shouldn't oops
:-)

No devices are connected to the card at this point.  Booted into the
console.  SMP kernel with noapic,nosmp to eliminate smp bugs...

testlibraw gives:

spock:~# testlibraw
successfully got handle
current generation number: 1
1 card(s) found
  nodes on bus:  1, card name: ohci1394
using first card found: 1 nodes on bus, local ID is 0, IRM is 63

doing transactions with custom tag handler
trying to send read request to node 0... completed with value 0xa9e91744

using standard tag handler and synchronous calls
trying to read from node 0... completed with value 0xc9f01744

testing FCP monitoring on local node
Segmentation fault

The following oops is generated:
Unable to handle kernel NULL pointer dereference at virtual address 00000039
d2952105
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<d2952105>]    Tainted: P
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010002
eax: cdd42a60   ebx: cdd42a60   ecx: 00000001   edx: cdd42afc
esi: 00000202   edi: 00000001   ebp: cdd42afc   esp: cd009e74
ds: 0018   es: 0018   ss: 0018
Process testlibraw (pid: 417, stackpage=cd009000)
Stack: cdd42a60 cc90f768 cc90f750 d2952707 cdd42afc cc90f800 cc90f760 00000000
       00000008 cd009ea8 cc90f7ec cc90f740 00000283 cd009ea8 cd009ea8 d2941961
       d294d000 0000ffc0 00000000 00000000 cc90f760 00000008 0000ffc0 d294d000
Call Trace: [<d2952707>] [<d2941961>] [<d29424d1>] [<d2941a99>] [<d2952cbe>]
   [<d2953303>] [<d29533ec>] [<c0133b3b>] [<c0106d7b>]
Warning (Oops_read): Code line not seen, dumping what data is available

>>EIP; d2952104 <[raw1394]queue_complete_req+c/6c>   <=====
Trace; d2952706 <[raw1394]fcp_request+192/1b0>
Trace; d2941960 <[ieee1394]highlevel_fcp_request+50/6c>
Trace; d29424d0 <[ieee1394]write_fcp+50/5c>
Trace; d2941a98 <[ieee1394]highlevel_write+68/bc>
Trace; d2952cbe <[raw1394]handle_local_request+c6/1c8>
Trace; d2953302 <[raw1394]state_connected+e6/f8>
Trace; d29533ec <[raw1394]raw1394_write+d8/fc>
Trace; c0133b3a <sys_write+8e/c4>
Trace; c0106d7a <system_call+32/38>

Other info:

Linux version 2.4.10-ac4 (root@spock) (gcc version 2.95.4 20010902 (Debian prerelease)) #1 SMP Fri Oct 5 00:39:46 BST 2001

Module                  Size  Used by
raw1394                 7280   2 
ohci1394               16896   2 
ieee1394               24968   0  [raw1394 ohci1394]
rtc                     6136   0  (autoclean)
nfs                    72192   1  (autoclean)
lockd                  47520   1  (autoclean) [nfs]
sunrpc                 63732   1  (autoclean) [nfs lockd]
nls_iso8859-15          3392   1  (autoclean)
nls_cp437               4384   1  (autoclean)
vfat                    9340   1  (autoclean)
fat                    29976   0  (autoclean) [vfat]
serial                 44064   0  (autoclean)
emu10k1                53760   0 
sound                  55756   0  [emu10k1]
soundcore               3844   7  [emu10k1 sound]
ac97_codec              9472   0  [emu10k1]
mousedev                3904   2 
hid                    12512   0  (unused)
input                   3456   0  [mousedev hid]
usb-uhci               21860   0  (unused)
usbcore                50080   1  [hid usb-uhci]
i810_rng                2584   0  (unused)
isofs                  24704   0  (unused)
inflate_fs             18272   0  [isofs]
sg                     23556   0  (unused)
sr_mod                 11160   0  (unused)
cdrom                  29248   0  [sr_mod]
ide-scsi                7456   0 
scsi_mod               80696   3  [sg sr_mod ide-scsi]
ide-floppy             11040   0 
eepro100               16208   1 

00:00.0 Host bridge: Intel Corporation 82840 840 (Carmel) Chipset Host Bridge (Hub A) (rev 01)
00:01.0 PCI bridge: Intel Corporation 82840 840 (Carmel) Chipset AGP Bridge (rev 01)
00:02.0 PCI bridge: Intel Corporation 82840 840 (Carmel) Chipset PCI Bridge (Hub B) (rev 01)
00:1e.0 PCI bridge: Intel Corporation 82801AA PCI Bridge (rev 02)
00:1f.0 ISA bridge: Intel Corporation 82801AA ISA Bridge (LPC) (rev 02)
00:1f.1 IDE interface: Intel Corporation 82801AA IDE (rev 02)
00:1f.2 USB Controller: Intel Corporation 82801AA USB (rev 02)
00:1f.3 SMBus: Intel Corporation 82801AA SMBus (rev 02)
01:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8029(AS)
01:06.0 Multimedia audio controller: Creative Labs SB Live! EMU10000 (rev 04)
01:06.1 Input device controller: Creative Labs SB Live! (rev 01)
01:07.0 FireWire (IEEE 1394): Texas Instruments TSB12LV23 OHCI Compliant IEEE-1394 Controller
01:08.0 Ethernet controller: Intel Corporation 82820 820 (Camino 2) Chipset Ethernet (rev 08)
02:1f.0 PCI bridge: Intel Corporation 82806AA PCI64 Hub PCI Bridge (rev 02)
03:00.0 PIC: Intel Corporation 82806AA PCI64 Hub Advanced Programmable Interrupt Controller (rev 01)
04:00.0 VGA compatible controller: nVidia Corporation NV15 (Geforce2 GTS) (rev a3)

           CPU0       
  0:      89315          XT-PIC  timer
  1:       3323          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  8:          1          XT-PIC  rtc
  9:       8207          XT-PIC  acpi, usb-uhci, ohci1394
 11:      42220          XT-PIC  eth0, EMU10K1
 14:       8763          XT-PIC  ide0
 15:         13          XT-PIC  ide1
NMI:          0 
LOC:          0 
ERR:          0
MIS:          0

Tony

-- 
"Only wimps use tape backup: _real_ men just upload their important stuff on
 ftp, and let the rest of the world mirror it ;)"  -- Linus Torvalds

tmh@nothing-on.tv	http://www.nothing-on.tv

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131297AbRCRXfL>; Sun, 18 Mar 2001 18:35:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131296AbRCRXfB>; Sun, 18 Mar 2001 18:35:01 -0500
Received: from mrelay.cc.umr.edu ([131.151.1.89]:53252 "EHLO smtp.umr.edu")
	by vger.kernel.org with ESMTP id <S131292AbRCRXeq>;
	Sun, 18 Mar 2001 18:34:46 -0500
Date: Sun, 18 Mar 2001 17:32:08 -0600
From: David Fries <dfries@mail.win.org>
To: linux-kernel@vger.kernel.org
Subject: pcmcia "plug and hang" 2.4
Message-ID: <20010318173208.A32115@d-131-151-189-65.dynamic.umr.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As long as I don't plugin or unplug any of my pcmcia devices the
system is fine, I can even do cardctl eject, and cardctl insert, but
if I physically remove or insert the cards it hangs without any
messages.

Also, if I don't load the usb drivers then I can yank and plug them
all day, but as soon as I load hte usb drivers it hangs.  The pcmcia
driver doesn't register an irq.  The usb drivers use irq 11.  Windows
on the same machine lists the cardbus driver as using irq 11, so I'm
guessing some kind of irq problem here.

It used to work in the 2.3 series, then again I don't remember if I
just wasn't using USB at the time.

System is a Laptop Toshiba Portege 3015CT.

NoSpace:~$ cat /proc/modules 
xirc2ps_cs             12080   1
serial_cs               4832   0 (unused)
ds                      6700   2 [xirc2ps_cs serial_cs]
i82365                 13332   2
pcmcia_core            39744   0 [xirc2ps_cs serial_cs ds i82365]
snd-card-opl3sa2        8964   0
snd-cs4231             13864   0 [snd-card-opl3sa2]
snd-opl3                6164   0 [snd-card-opl3sa2]
snd-hwdep               4044   0 [snd-opl3]
snd-mpu401-uart         3120   0 [snd-card-opl3sa2]
snd-rawmidi            10444   0 [snd-mpu401-uart]
snd-pcm-oss            39232   0 (unused)
snd-pcm                38584   0 [snd-cs4231 snd-pcm-oss]
snd-timer               9336   0 [snd-cs4231 snd-opl3 snd-pcm]
snd-mixer-oss           9612   0 [snd-pcm-oss]
snd                    27768   1 [snd-card-opl3sa2 snd-cs4231 snd-opl3 snd-hwdep snd-mpu401-uart snd-rawmidi snd-pcm-oss snd-pcm snd-timer snd-mixer-oss]
soundcore               3748   5 [snd]
usb-ohci               16516   0 (unused)
hid                    11920   0 (unused)
evdev                   3732   0 (unused)
mousedev                4164   1
input                   3264   0 [hid evdev mousedev]
usbcore                46372   1 [usb-ohci hid]
serial                 42468   0 [serial_cs]

PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: Toshiba America Info Systems 601 (rev 162).
  Bus  0, device   4, function  0:
    VGA compatible controller: Neomagic Corporation NM2160 [MagicGraph 128XD] (rev 1).
      IRQ 11.
      Master Capable.  Latency=64.  Min Gnt=16.Max Lat=255.
      Prefetchable 32 bit memory at 0xfd000000 [0xfdffffff].
      Non-prefetchable 32 bit memory at 0xffc00000 [0xffdfffff].
      Non-prefetchable 32 bit memory at 0xffb00000 [0xffbfffff].
  Bus  0, device  11, function  0:
    USB Controller: NEC Corporation USB (rev 2).
      IRQ 11.
      Master Capable.  Latency=16.  Min Gnt=1.Max Lat=21.
      Non-prefetchable 32 bit memory at 0xffaff000 [0xffafffff].
  Bus  0, device  17, function  0:
    Communication controller: Toshiba America Info Systems FIR Port (rev 35).
      IRQ 11.
      Master Capable.  Latency=64.  
      I/O at 0xffc0 [0xffdf].
  Bus  0, device  19, function  0:
    CardBus bridge: Toshiba America Info Systems ToPIC97 (rev 6).
      Non-prefetchable 32 bit memory at 0x10000000 [0x10000fff].
  Bus  0, device  19, function  1:
    CardBus bridge: Toshiba America Info Systems ToPIC97 (#2) (rev 6).
      Non-prefetchable 32 bit memory at 0x10001000 [0x10001fff].

relavant boot messages
Kernel command line: auto BOOT_IMAGE=2.4.3-pre4 root=302 BOOT_FILE=/boot/kernel/2.4.3-pre4
PCI: PCI BIOS revision 2.10 entry at 0xfd837, last bus=21
PCI: Using configuration type 1
PCI: Probing PCI hardware
  got res[10000000:10000fff] for resource 0 of Toshiba America Info Systems ToPIC97
  got res[10001000:10001fff] for resource 0 of Toshiba America Info Systems ToPIC97 (#2)
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
mice: PS/2 mouse device common for all mice
usb.c: registered new driver hid
usb-ohci.c: USB OHCI at membase 0xc303c000, IRQ 11
usb-ohci.c: usb-00:0b.0, NEC Corporation USB
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
Linux PCMCIA Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
Intel PCIC probe: 
  Intel i82365sl B step ISA-to-PCMCIA at port 0x3e0 ofs 0x00, 2 sockets
    host opts [0]: none
    host opts [1]: none
    ISA irqs (scanned) = 3,4,7,9,10,15 status change on irq 15
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0800-0x08ff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x220-0x22f 0x330-0x337 0x378-0x37f 0x480-0x48f 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
cs: memory probe 0x0d0000-0x0dffff: clean.
xirc2ps_cs.c 1.31 1998/12/09 19:32:55 (dd9jn+kvh)
eth0: Intel: port 0x300, irq 3, hwaddr 00:A0:C9:7A:CE:D5
eth0: autonegotiation failed; using 10mbs
eth0: MII detected; using 10mbs
eth0: media 10BaseT, silicon revision 4
ttyS01 at port 0x02f8 (irq = 9) is a 16550A
inet6_ifa_finish_destroy
xirc2ps_cs.c 1.31 1998/12/09 19:32:55 (dd9jn+kvh)
eth0: Intel: port 0x300, irq 3, hwaddr 00:A0:C9:7A:CE:D5
eth0: autonegotiation failed; using 10mbs
eth0: MII detected; using 10mbs
eth0: media 10BaseT, silicon revision 4
eth0: no IPv6 routers present

-- 
		+---------------------------------+
		|      David Fries                |
		|      dfries@mail.win.org        |
		+---------------------------------+

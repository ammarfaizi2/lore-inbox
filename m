Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312927AbSDTQxr>; Sat, 20 Apr 2002 12:53:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312928AbSDTQxq>; Sat, 20 Apr 2002 12:53:46 -0400
Received: from smtp017.mail.yahoo.com ([216.136.174.114]:39177 "HELO
	smtp017.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S312927AbSDTQxn>; Sat, 20 Apr 2002 12:53:43 -0400
Subject: 2.4.19-pre7-ac1 breaks my USB mouse
From: Thomas Hood <jdthood@yahoo.co.uk>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 20 Apr 2002 12:55:44 -0400
Message-Id: <1019321746.1092.11.camel@thanatos>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just upgraded from 2.4.19-pre5 to 2.4.19-pre7-ac1 and
now my Logitech marble trackball USB mouse no longer 
works.  This despite the fact that the syslog looks OK.
The problem also afflicts 2.4.19-pre7-ac2.
The problem also occurs when the ltmodem driver is not loaded.

Machine: ThinkPad 600X

.config: http://panopticon.csustan.edu/thood/config-2.4.19-pre7-ac2

/var/log/syslog:
Apr 20 11:17:00 thanatos kernel: hub.c: USB new device connect on bus1/1, assigned device number 2
Apr 20 11:17:00 thanatos kernel: usb.c: USB device 2 (vend/prod 0x46d/0xc401) is not claimed by any active driver.
Apr 20 11:17:00 thanatos /etc/usb/policy: ... loaded mousedev
Apr 20 11:17:00 thanatos kernel: usb.c: registered new driver hid
Apr 20 11:17:00 thanatos kernel: hiddev0: USB HID v1.00 Mouse [Logitech USB-PS/2 Trackball] on usb1:2.0
Apr 20 11:17:00 thanatos kernel: hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
Apr 20 11:17:00 thanatos kernel: hid-core.c: USB HID support drivers

/proc/ioports:
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
01f0-01f7 : ide0
02f8-02ff : Lucent Microelectronics WinModem 56k
  02f8-02ff : serial(auto)
03bc-03be : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(set)
04d0-04d1 : PnPBIOS PNP0c02
0cf8-0cff : PCI conf1
15e0-15ef : PnPBIOS PNP0c02
4000-401f : Intel Corp. 82371AB/EB/MB PIIX4 USB
  4000-401f : usb-uhci
4400-44ff : Lucent Microelectronics WinModem 56k
  4400-44ff : ltserial
4800-48ff : PCI CardBus #02
4c00-4cff : PCI CardBus #02
5000-50ff : PCI CardBus #05
5400-54ff : PCI CardBus #05
d000-dfff : PCI Bus #01
ef00-ef3f : Intel Corp. 82371AB/EB/MB PIIX4 ACPI
efa0-efbf : Intel Corp. 82371AB/EB/MB PIIX4 ACPI
fcf0-fcff : Intel Corp. 82371AB/EB/MB PIIX4 IDE
  fcf0-fcf7 : ide0
  fcf8-fcff : ide1

/proc/interrupts:
           CPU0       
  0:     460641          XT-PIC  timer
  1:       2285          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  8:         11          XT-PIC  rtc
 10:    1096858          XT-PIC  Texas Instruments PCI1450, cs46xx, ltserial
 11:         28          XT-PIC  usb-uhci, Texas Instruments PCI1450 (#2)
 12:      71157          XT-PIC  PS/2 Mouse
 14:      27862          XT-PIC  ide0
NMI:          0 
ERR:          0

lsmod:
Module                  Size  Used by    Tainted: PF 
ppp_deflate             2944   0  (autoclean)
zlib_inflate           18336   0  (autoclean) [ppp_deflate]
zlib_deflate           17472   0  (autoclean) [ppp_deflate]
bsd_comp                3968   0  (autoclean)
ppp_async               6400   1  (autoclean)
ppp_generic            15692   3  (autoclean) [ppp_deflate bsd_comp ppp_async]
slhc                    4368   1  (autoclean) [ppp_generic]
hid                     8576   0  (autoclean) (unused)
cs46xx                 54408   4  (autoclean)
soundcore               3556   3  (autoclean) [cs46xx]
ac97_codec              9824   0  (autoclean) [cs46xx]
lt_serial              19648   2  (autoclean)
lt_modem              314432   0  (autoclean) [lt_serial]
ds                      6496   2 
yenta_socket            8704   2 
pcmcia_core            35392   0  [ds yenta_socket]
parport_pc             22120   1  (autoclean)
lp                      6528   0  (autoclean)
parport                24608   1  (autoclean) [parport_pc lp]
smapi                   3048   0  (autoclean)
thinkpad                2540   0  (autoclean) [smapi]
mousedev                3808   1 
input                   3328   0  [mousedev]
usb-uhci               20996   0  (unused)
usbcore                54784   1  [hid usb-uhci]
floppy                 45248   0  (autoclean)
serial                 42144   0  (autoclean)
ide-cd                 26944   0  (autoclean)
cdrom                  28928   0  (autoclean) [ide-cd]
rtc                     5916   0  (autoclean)

lspci:
00:00.0 Host bridge: Intel Corp. 440BX/ZX - 82443BX/ZX Host bridge (rev 03)
00:01.0 PCI bridge: Intel Corp. 440BX/ZX - 82443BX/ZX AGP bridge (rev 03)
00:02.0 CardBus bridge: Texas Instruments PCI1450 (rev 03)
00:02.1 CardBus bridge: Texas Instruments PCI1450 (rev 03)
00:03.0 Communication controller: Lucent Microelectronics WinModem 56k (rev 01)
00:06.0 Multimedia audio controller: Cirrus Logic CS 4614/22/24 [CrystalClear SoundFusion Audio Accelerator] (rev 01)
00:07.0 Bridge: Intel Corp. 82371AB PIIX4 ISA (rev 02)
00:07.1 IDE interface: Intel Corp. 82371AB PIIX4 IDE (rev 01)
00:07.2 USB Controller: Intel Corp. 82371AB PIIX4 USB (rev 01)
00:07.3 Bridge: Intel Corp. 82371AB PIIX4 ACPI (rev 03)
01:00.0 VGA compatible controller: Neomagic Corporation NM2360 [MagicMedia 256ZX]

--
Thomas Hood



_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com


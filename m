Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270657AbRIAMzj>; Sat, 1 Sep 2001 08:55:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270661AbRIAMzb>; Sat, 1 Sep 2001 08:55:31 -0400
Received: from dsl027-137-030.nyc1.dsl.speakeasy.net ([216.27.137.30]:65091
	"EHLO perl") by vger.kernel.org with ESMTP id <S270657AbRIAMzV>;
	Sat, 1 Sep 2001 08:55:21 -0400
Date: Sat, 1 Sep 2001 12:55:39 +0000
To: linux-kernel@vger.kernel.org
Subject: PPC kernel compiles fail (2.4.5 to 2.4.9 inclusive) due to ide problems/vt problems
Message-ID: <20010901125539.A17935@216.254.117.126>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="EeQfGwPcQSOJBaQU"
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
From: xsdg <xsdg@softhome.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Please CC me as I am not subscribed to the list.  My only goal now is to get
a kernel running (2.4 is necessary for Airport support).  The computer is a
brand-new Apple TiBook.

I downloaded the 2.4.9 kernel, and attempted to build it (on my PPC); 
`make dep clean vmlinux modules` failed with the following errors (make errors
given for context):

make[3]: Entering directory `/usr/src/9.4.2k/drivers/char'
gcc -D__KERNEL__ -I/usr/src/9.4.2k/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -D__powerpc__ -fsigned-char -msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring    -c -o vt.o vt.c
vt.c: In function `vt_ioctl':
vt.c:507: `kbd_rate' undeclared (first use in this function)
vt.c:507: (Each undeclared identifier is reported only once
vt.c:507: for each function it appears in.)
vt.c:514: `kbd_rate' used prior to declaration
vt.c:514: warning: implicit declaration of function `kbd_rate'
make[3]: *** [vt.o] Error 1
make[3]: Leaving directory `/usr/src/9.4.2k/drivers/char'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/usr/src/9.4.2k/drivers/char'
make[1]: *** [_subdir_char] Error 2
make[1]: Leaving directory `/usr/src/9.4.2k/drivers'
make: *** [_dir_drivers] Error 2

Then I downloaded 2.4.5 (which is working on all my other boxes, albeit x86).
I attempted to build it with the same command, and it failed with the following
errors:

make[1]: Leaving directory `/usr/src/5.4.2k/arch/ppc/lib'
ld -T arch/ppc/vmlinux.lds -Ttext 0xc0000000 -Bstatic arch/ppc/kernel/head.o init/main.o init/version.o \
	--start-group \
	arch/ppc/kernel/kernel.o arch/ppc/mm/mm.o arch/ppc/lib/lib.o kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o \
	 drivers/char/char.o drivers/block/block.o drivers/misc/misc.o drivers/net/net.o drivers/media/media.o drivers/char/drm/drm.o drivers/net/appletalk/appletalk.o drivers/ide/idedriver.o drivers/scsi/scsidrv.o drivers/cdrom/driver.o drivers/pci/driver.o drivers/macintosh/macintosh.o drivers/video/video.o drivers/usb/usbdrv.o drivers/input/inputdrv.o drivers/i2c/i2c.o \
	net/network.o \
	/usr/src/5.4.2k/lib/lib.a \
	--end-group \
	-o vmlinux
mm/mm.o: In function `__free_pages_ok':
mm/mm.o(.text+0xdcd0): undefined reference to `__test_and_change_bit'
mm/mm.o(.text+0xdcd0): relocation truncated to fit: R_PPC_REL24 __test_and_change_bit
mm/mm.o: In function `rmqueue':
mm/mm.o(.text+0xdf04): undefined reference to `__change_bit'
mm/mm.o(.text+0xdf04): relocation truncated to fit: R_PPC_REL24 __change_bit
mm/mm.o(.text+0xdfa0): undefined reference to `__change_bit'
mm/mm.o(.text+0xdfa0): relocation truncated to fit: R_PPC_REL24 __change_bit
make: *** [vmlinux] Error 1

I then patched up to 2.4.6, when I encountered the following error:

make[1]: Leaving directory `/usr/src/6.4.2k/arch/ppc/lib'
ld -T arch/ppc/vmlinux.lds -Ttext 0xc0000000 -Bstatic arch/ppc/kernel/head.o init/main.o init/version.o \
	--start-group \
	arch/ppc/kernel/kernel.o arch/ppc/mm/mm.o arch/ppc/lib/lib.o kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o \
	 drivers/char/char.o drivers/block/block.o drivers/misc/misc.o drivers/net/net.o drivers/media/media.o drivers/char/drm/drm.o drivers/net/appletalk/appletalk.o drivers/ide/idedriver.o drivers/scsi/scsidrv.o drivers/cdrom/driver.o drivers/pci/driver.o drivers/net/wireless/wireless_net.o drivers/macintosh/macintosh.o drivers/video/video.o drivers/usb/usbdrv.o drivers/input/inputdrv.o drivers/i2c/i2c.o \
	net/network.o \
	/usr/src/6.4.2k/lib/lib.a \
	--end-group \
	-o vmlinux
drivers/ide/idedriver.o: In function `pci_init_sl82c105':
drivers/ide/idedriver.o(.text+0xa1b8): undefined reference to `ide_special_settings'
drivers/ide/idedriver.o(.text+0xa1b8): relocation truncated to fit: R_PPC_REL24 ide_special_settings
make: *** [vmlinux] Error 1

I encountered the above error (idedriver.o) on kernels 2.4.6 to 2.4.8 inclusive.
If any more info is necessary, please ask.


--System info (kernel .config's are attachments):

$uname -a	# default Debian Potato 2.2-r3 install
Linux java 2.2.19 #1 Sat Apr 14 23:20:24 CDT 2001 ppc unknown

$cat cpuinfo 
processor       : 0
cpu             : 750
temperature     : 0 C
clock           : 499MHz
revision        : 34.20
bogomips        : 976.98
zero pages      : total 0 (0Kb) current: 0 (0Kb) hits: 0/187 (0%)
machine         : PowerBook4,1
motherboard     : PowerBook4,1 PowerBook2,2 MacRISC2 MacRISC Power Macintosh
L2 cache        : 256K unified
memory          : 64MB
pmac-generation : NewWorld

$cat pci 
PCI devices found:
  Bus  0, device  11, function  0:
    Host bridge: Apple Unknown device (rev 0).
      Vendor id=106b. Device id=27.
      Medium devsel.  Master Capable.  Latency=16.  
  Bus  0, device  16, function  0:
    VGA compatible controller: ATI Unknown device (rev 2).
      Vendor id=1002. Device id=4c46.
      Medium devsel.  Fast back-to-back capable.  IRQ 48.  Master Capable.  Latency=255.  Min Gnt=8.
      Prefetchable 32 bit memory at 0x94000000 [0x94000008].
      I/O at 0x400 [0x401].
      Non-prefetchable 32 bit memory at 0x90000000 [0x90000000].
  Bus  0, device  23, function  0:
    Hot Swap Controller: Apple Unknown device (rev 0).
      Vendor id=106b. Device id=25.
      Medium devsel.  Master Capable.  Latency=16.  
      Non-prefetchable 32 bit memory at 0x80000000 [0x80000000].
  Bus  0, device  24, function  0:
    USB Controller: Apple Unknown device (rev 0).
      Vendor id=106b. Device id=26.
      Medium devsel.  IRQ 27.  Master Capable.  Latency=16.  Min Gnt=3.Max Lat=86.
      Non-prefetchable 32 bit memory at 0x80081000 [0x80081000].
  Bus  0, device  25, function  0:
    USB Controller: Apple Unknown device (rev 0).
      Vendor id=106b. Device id=26.
      Medium devsel.  IRQ 28.  Master Capable.  Latency=16.  Min Gnt=3.Max Lat=86.
      Non-prefetchable 32 bit memory at 0x80080000 [0x80080000].

# lspci -vv
00:0b.0 Host bridge: Apple Computer Inc.: Unknown device 0027
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 16, cache line size 08
	Capabilities: [80] AGP version 1.0
		Status: RQ=7 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:10.0 VGA compatible controller: ATI Technologies Inc Mobility M3 AGP 2x (rev 02) (prog-if 00 [VGA])
	Subsystem: ATI Technologies Inc Mobility M3 AGP 2x
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 255 (2000ns min), cache line size 08
	Interrupt: pin A routed to IRQ 48
	Region 0: Memory at 94000000 (32-bit, prefetchable)
	Region 1: I/O ports at 0400 [disabled]
	Region 2: Memory at 90000000 (32-bit, non-prefetchable)
	Expansion ROM at 90020000 [disabled]
	Capabilities: [50] AGP version 2.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA+ AGP- 64bit- FW- Rate=<none>
	Capabilities: [5c] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:17.0 Class ff00: Apple Computer Inc.: Unknown device 0025
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 16, cache line size 08
	Region 0: Memory at 80000000 (32-bit, non-prefetchable)

00:18.0 USB Controller: Apple Computer Inc.: Unknown device 0026 (prog-if 10 [OHCI])
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 16 (750ns min, 21500ns max)
	Interrupt: pin A routed to IRQ 27
	Region 0: Memory at 80081000 (32-bit, non-prefetchable)
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-

00:19.0 USB Controller: Apple Computer Inc.: Unknown device 0026 (prog-if 10 [OHCI])
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 16 (750ns min, 21500ns max)
	Interrupt: pin A routed to IRQ 28
	Region 0: Memory at 80080000 (32-bit, non-prefetchable)
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-

$

	--xsdg
-- 
|---------------------------------------------------|
|             Hit any user to continue.             |
|---------------------------------------------------|
| http://xsdg.hypermart.net       xsdg@softhome.net |
|---------------------------------------------------|

--EeQfGwPcQSOJBaQU
Content-Type: application/x-bzip2
Content-Disposition: attachment; filename="configs.tar.bz2"
Content-Transfer-Encoding: base64

QlpoOTFBWSZTWcjQqgEAkxL/k/CQAEBY5//yP///8P///+ABAEAAAAQAGGAy3z6CVKElFCqX
1lEqSBUGtUqVIAKFCgKJJCVSCqqIJJFKKqShIUElBRQElKpIFABQUEIKoFUFUVIJJUUFIgol
VEFIVSiUoBVEKqSpURHGRpkxNBkyYTTIGQ0BoDTJoYATQGOMjTJiaDJkwmmQMhoDQGmTQwAm
gMcZGmTE0GTJhNMgZDQGgNMmhgBNAYZSTQDQaA0AAAADQA0AAAAmqSICGgEJk0p6J6k/U09Q
aT0hk9I0wymjTQPU9QKUkQEyAEE01EaE9JNpptKM1PUzU9Qep+pHohoaf4Lhkzz9J8/9f96z
hmYs5In0+/0ff78OpanXRyzXHb7+fPnX+2YvZYjoX/L/pixMJ/E0mlqwaWLFyWJqTbNSxaWN
LFkwZlMmJgyaYmqamZlqy1aE8pH6T/mGxqan/ObT/lNnhbTlNpxT6TdP85uGphZMk6SBhOF/
lNTerZjNNThOM0m6ZN0xP8pk1bWS/Yk7zeMmTUw1OulWTRpeK20VbVm6xarJiwbLJbLBja0M
WSzTNFMWDFixYi2Wxk1Nk2mJk1TaZtNaFk1NNYrFkWpYMWBiyTJZLZa0rUwyYTRtqaTJibNo
2n85k3mTexqZN5kxMm0xMmTJtNFYMlpYppZLSyGyyWyyxZJbTKtJk2mRLJkDUybTJkxMmQ2m
0ybbYzaZNTJqZNpiajBZkpm2Y1VThMgbzEt6srWYZCamSZMbzbQYZqZNLbStmjUaZaWTTJMZ
VYtlqWmGMtlmlixYsWKYlVaWlo0mpkyYba4fE0nCYnCmTSYmosMmTDFk9JpNTaxpMmTJpe65
rYt1zlrUYuC1LFoaGLDExMTaamptNTJiampqtppltNTJrY57VfWbTebThNJtMgZNpqLU1MmB
hlWTZNTU2mppYtlqWLMW1aH3rZaGSxbLctTaamibTSamTJmTaYvtMmycp0m02TOE1NVYmBia
GmXFpNWFibTXyvePlcBqby8J5DU97V/TP9s1Ok6T/XNdZ/RMnzMJ/CYf0203tlIH2LF3sXRY
v5n+ixq3eixb20v85hOFg/W9ZpPeZN7BvZV6Tnd5i2l81kriyX86xaYVcFg8FzXJtLrOM0Nk
7zU4TEutlTtfE/snnP+E7vm8Lwncan/vOs2nMfxG1XnPpes5z3Xm6Nl/IxfrXZuui3Wni8V0
XB7Lg+ldC/ISIYI0QUIQqQgCImRrITLYLEYiM50kKEbgGF/zcl8Vqui8luvJc1yXFf3OTufm
ea4sf4J2ntNtvJ/0n756nWeU/tn+U9Z3nhOR7TU5T/E57zrPL52nTJ8TnPBOM1PifwnacVpc
VxW60vNei/YvgtLFxLmv6Vi/Uan4P7p9p7XnnlOnrOk850nzOc1t7233nzPmcJyOU/h8zf6T
OM7TnOE/tnKd+bM5z2nSb3C6zpPrPGcZz6z3m48fQ9J53nn3naeC91yXoviaXcvktlwWy9Vs
vZd17r06L9q5r7F3LgvWeNdFzXp9rfovKWDFvbnvOqcp6J4T3OTWNvb1Oc5T4n98950n2Wls
tl6LdfNfRcV8l9VyWLitlpcVxm81NTjOE1Oc2npPdO0/SfWan0nr7nu/M8ZqfR1mT4n4nCek
+s7zwnc1O69V7rZeS7l0X+S7LguK7pfcua+9cVsuC0visWlxXquy6LgvFd65L2XZYvacZunG
fec55fqzOc++07TD8XLU4T8TrMT6TJ7TtO8+k+DM0nSeJ07nIw9Djr7zRrJ9s5x5ztNjjNnc
5/d4zhNjjxn7K5TvOBvPzPN6zg79J5z5ntPVdznPabT5nLrOc8fY9Zynac5o5T9nhNTecZ1T
znM+87TScZ0TnOM+k4T8TJxnWvrfnrddl9i0uy7V7rgt1xXiuGw+S/MvKbz1cMdZyNfee04J
3ntO/Wec8vrMTkuPX6V6rndl9F9l9F0X0/ic34ruX8bV+g4sX4vyfqWKQP9X8q/pXJ7LGy8F
0dFIGy91/trov7FwXcucvxXsuF1H9a9F4LdvVjZ0bLzXnVs/hX7F+uj9yxJIv1L+yk4r86+q
+ix5t17rd9F4r9L9fRbPRf1tEXCGwASI7EPCPZEw2yMBC6+FdRyDOBvAhUhYj4vF/c+K+a7J
93lr9Er0Wy1NLycJst1/QvSbbzM5Tbb6TJx3nvMm05piZOU95tNrgtLFi4r6cVvuLkuXThN1
ixZzNKcJsvBMmT9EcpwX+zhOM2mppO6vuXKcJ3LfjrJ0L8Vw2WLguM2Wk2XesXFbLebLdbLk
t1usWLXdxm67H9nCeM4zaf3Tmcp4z/jOfXomdJ/xnT/dPxPTdfl+tdl8l6+X6FzX9S/snZcF
817LryXxn+i2nSan98/vnz/3TpOE/nn+5PWaf1MvtNWiuZxnrPGantPqnJMn5nCeE/RfafCe
3Je0/Ou9fWvmt52XBa/FfJ8FyXBc14r7r9k6z9Z958Twn4p7zy7zu/VbzlPecOvJbz3X4Lmv
CXzWl54u9YtLC9lt6Yuy6rkMWRg/B9vwXkvFeiyaXq+xfNbrxXv3dJ7T7ThOsyfaeE/3z8zl
NTnNT6TpO/n5zz+s813myfXynbrN5xm6cJwnTpNwvKYbqHRPCZPTnMnhOU9J3MnScp2T/zm/
lMnzvPI8fKbHGYd5ynitpwnGe/nP495zn1XtVue0Xabz3TJ5cp3bT1nhOZXhP5PF6T9s5Tad
51mp4TnOE9+C/iuDjPidp8TnPtNJ4T7TlOU4zebT0+yfrMTJlD7TU6cp49+U6zpPdN14Tec8
gfP2mp1Tn0yec6JvPKanCe03q9uc7TnN/Od+i4zfgan4m3FNpvMm3wnjMm02cvvOvefacZ0m
/bOWPacJ2XUd657rxlz7l5rZeWy57LhsvZdV7Lnw8FynWeE6z0G0x3my8frOU49zxnjK7HHM
n5TlOc67Tz8bedJk06TU905p+s/dNT+VWSeShgn2mT4n1/tn4KvxN/8Z3T+Sfeecp/hNJ6J/
NO8XsfmfebLr9y+Wl8vHwWl9v1XRdJbrFg4LKNHhNo2ntP2bT/TPqn5OJ5FXM+/88/hPxOc9
E8J2m82TSfmZqdD4Z+6aeE5frfPefu6TJ4T1nn0njxmeE9jadJie0+Z6TlN5/JO85bRwntqb
zjOryzwy9ek9J5zU6L0XRbr5reW68FyWhpaX9y0t1vXKc5xcuCd595znKfi1O89J4zlOc7rU
4205W9o1fum84TY6HibzZ6zThPKbn7vKc5zneZPKe0+Z4JqeM5T2nvPCdp3nhP85xnWbJznx
POeE3nGaTxNTXs4T0nrPKcJt4tT+WcZ2mp5zecz9ycuiec5pyn6H6TynJ6TwnTE27T4n7Z95
4z6zrN05znPOdZ8T7pk9pxnWZPWb71svZYsXSfBfyL5Lkua0u34Lsu5br2XKek7zabThMmT7
Tum02TrOM8521HCbz1mT9TfhOc4zJ4p1mTSuS6zJ/LO6cpvN1ZMi7zgmpkZVqfgfJbr+9ZLF
wRbrYO5cZalkuC0HCWLzW64qTButxXSWCtlW07TYX0ne8cnvNHU2rpZMm84qsmk9p0m844nF
OU1HVOs1V8zYtLst1svNeKwuixPPgu8eC812Xgt1uvFdVpbrgsXRbDmsXpLguw3M8MnaeM1P
6Z1nrOM5TsmTwie07zU7J1naYcKD0n1nKbTlOVW87TJ4znOMz2nlPCZNpkyaTkd50lOc7TtO
0yc04TbrsnZNTsmTJtP1m5ah1WLoucuixdVtLqvFbjdYNlkvfxHpJ7LstHNYPAZWLFpanZMo
eU/WeaZOs4TjMTm8J7zeclwClxXOtLS6LS25rUvFdz3WLaT3pMTUdJpOkynSbzEyjBdVi0pi
71qWlssWhstLQxYsWy0tTJZLIxYVYMXjH6VznM8TvPQ29p4TrNpk5HvxMOf7ZxWTpO4cZk/n
TnN55pxTkLhOMyU7TJyn+g1PedeepwT0nWeCcDeamJk4zPKbTJxnGcpvO09TU9acJtPfiriu
M0TU1GTzmTU6ziTaamp4Vi6r6ritqW6LgPmsWLJYxWWF3TJwnCbzYnO7THWcZiZVkyvRd65r
kt1ktByXgsW20J8V0uLzmrTjOE6TCannP++YhhMJiYMWRhmLCslkslkmLIZGVZkWTCZMJiZM
mUMizCsWDFiwVksWLFixZLFMWLFgxZLJYlmFgxZLFiwYsGSyjKWLFMGLJYsixMSyYGTJkyrE
xMmKyYmTKsmJiZMmJkyZMmJkyYzDKZMqwyTJkyZMJkxMkmTJkxVkWTJkyYmJkxGTEyZMTJiZ
MmSmRYJiwwYsWSxZKsxYsSxWLFixYsWAsWDFkpiyWTEyZVkyYmTMTEyGRZMmTJkyZMJgmTFZ
iZMmTAyYCxYsllLFixYMWSmLJZLJTMYsEsWSYphiyYyGGEyrJkyoyZMmEyZVkyZMVkyhiYsT
BMybRfEyfihifsnNOm07zxE9U2q1NZQ0vaXBbLvW5clwKK+q2W8tj1n2m85z6K0mpzmyek0m
pxmpunWam0ybKxNp7pqbTrw1OE/qnrLyWC3XFcl4rovRbr4y+S5LosX8C4Rwn2nzNpxT4vCc
7QwnKL9PieibzlPWdJznzPpOM3mTaf+M5T6p+ZidfjJ4T9s2VfNOCec4zrPmec41cp3DrMpd
NlqWnasUzJaWLF0Wy0C2DJkxN5k4RLbVWkyrU/Uydlr717rmuEnuslStSxDkOktz8z1TecP1
necpwmTmnBMEycZl6rda7LFrhLUsGLFMXxvWXyWy6qbrcdy3W61LVS9Fi6zF3PdYamTtNJ2J
qc1zmLridZhMmppPCdZon1mThOG9W3eZNsTeZP0Juuc814r32Gy26rS3XOWlsvwWy3rrO84H
85nLt6zrPCYe08J4b1es8YOdwN/3z07T+ud5rJ3mTjPNMHNMfE2nGeE4TaZOh99p2nnPGrjO
qj5T7TSfScJqeE1NT1n+c8+M8p4TjNJk8J0mDmtgW63itpd68orUu7ilxWl5LotLgO6Xzl2X
Nb1wH0XcuS6L1njk400mpqbzpFsm07R1nIeKaEN9eE1P2zxnWnxO81PKfqmraZD6zynnLxmK
cE6D9k95xqyc5uuc6zvT6T4ntPaeMybzE9ZsmTY4zhPjLxXisqXRaWi4rotDlLB3LmvNNpT4
JzmqtJi1NJqjgnKhymCFtP7LZPOYTknE5RLpOs5zpN53TJkyZPWbJv+U/fOc7Ton5mTvP1mT
rMn3pyJoT9ZhK/MynOfmfM8ZALabp2mTJ+k9Nk8KxYsXyXKWkjSxaWDSxcllF81i4LBwlxXZ
cF6rkuy5r6rvXqvh3n6TlOs/E7zieM8Z4zacZtMTeYnlO07TZN5uRqck2JkykfpMmllS+Uvo
sl1Nhj0WhoYsNLFxnnO08Z4T1T3m8/E/E4TxnCdjafpMT2E3FXjOaYq1PxPGc5ynGc5hicaj
1nXjNk4FRDzmRKXpPcfpMLwnGraeCc5vNG01Oc7pk3m8yYnJNTSe9pPpMnnk3nCea2hsNLzW
y2h1WDweS2qx4cHks+OU4H4TVXzMnI3+/RG8+ExNTwnUnjMT2TdcLiaaLGtB8zJ1mleirFyT
0m8yfid/kXacpOU1Os6ek6rrS2WqxaXMeTJfBYtDynBdVk0n7psKtp2TUpqdZ6p6Tacpwg+J
4zlOs1OU8j9JALxmTUyL2m88BxnWZPKcZ6zeePhxmyZPonrPafSZPSeU9JzqxOZPCbCd5ieM
4zpOG0ybTabTvNTn5zknGTzmEZMnjXhOc6zrNj1me06UOc9E0TfEzFI9fGdTU8hbzynSeIbR
95hbrF3raXQTaKvJde5dl5LotF6LygxfVb1uui4LqtlpcZeSxcVtNJvMnjOswjtMmTKlzyhx
mEyZNpiL3nKaq+JkWjeai4rS8ivJeC5LBst27F+DvWrvW91Wy+68Jwm03m02nFPvOs4zJhMn
rMTabTimTafExPfodKukwqjkTvyl4LrLo8FgyWFxWP1LyclsOK9Z9k6TtOs37HjMMnKeU+J9
pynlO848rZa+qyxfBaHRey+C6V1lg3XnDacZ6Twn+mZPaek7zE8pzO1xnWcJlXdQnrN5tPGZ
NZ3nrNous/Ump6j1XCpTv5rF2UwaWS4rJd6uy2Xs0tLS5Lkuy+9eK6ryWLvWy5y85wsfiZd5
4z1nBynCYZfEx1mTU5zV6T0njP5U5TzmHh+Zwm0d5m6frMpznke8yZPtNk0nGYmkwmTCd59J
qc5tNJzTIGSnecKtp0nmmk6TVWJqaphO3E1O88R4TlN0/ZNJ2m09cTaamk4YnGcD1nGbrZZ5
y+a1S+KxeUsWDFusHBbTCeU+JznBOMwnsnhNJ+2fKeS4TeLU9pr4npNGTaN5ibsTrMm0+ifs
mJbzyMnGZNTJid5xnebTaammTIyZG+U8pxnCcJk4TgXlMnZLc4fKdJyQ3nCJcZwq2pvPScZw
mRam023KnLk+2pqeM+8/ZOqeKfM6zlNtVcjnM3J4zKtpgTJ4cJALSbJJhNTJwm52m06TEycJ
hvP0m6aJirBk5CLhOMyaJ7qam4nCMm9WyrhOU4Jg4VcE7zinGZMmCbzeePnPtlwd6wNlkaXV
c11l60bOq459iyrlMmHWZymTae0DJ5zJiYu8/E9JxTmnpMnGbU+k9pkyJZMnSaTjOicJunzO
Ym6fCeVXFO83Mq/bMm08CZc52mpxN1XY3TymEawPmea4TlVkgFk6TnNpwritDSwfYi4NLdcN
Q868ui2WLyNpqdZq8pxnBOM5TxnGcpqaJ4cJyn1NJ6k41dmTpOaYdplW83q4+88J3n6zE8lF
wnoVcCdE853TJqbT2Tn7T2mn7PpNr6npNTJkyZNY7Txm81N00eU9bU+J7zXvNT1nec56C8VJ
hOlZGYHdS3XhbLmsXNXVZPNdOq3XBeq6roto4rMWJYsXesXks6y7lougxd4xbrFpfWrU6ruX
ksKuUuK+bmu/vXous5LFwGTtMTtMi6pk6jExlcJk81ymGk2mRbzeZVtNhPNNjZVxm8xMm2Tw
xLhOM0nerU4bz7zgm09BOE2pk6KyeyaTymTJk8Jsm9NpiI8JtG0yeqrunQ3nShk4rS8lg2l0
5LgXhLF3rF5LktL1WJqeVqZZNTJzKsHKYXWampuuS0tL1WLel9VpdVg6VizF0WHOYmJznLjN
5hN55zUzzmpqbzefec02q3PKaTjPtOk0uqYJvpVwxNp6zrPOfM4DjN5ymTlPuuk3nxOE4TmY
nAyfmZN5wnHvNzZV1Teck4ziddTEsT+0cJvVtNTvPKe83m6ZPpO05T5mTtMnvqe0yeJMnQco
MXFYVbrcvkOa2li+Uv0rZzn0nlMnafnU9O88R5Tean5nWbpvHmvisXmvgu0tLzXEuqxeK7Vo
c18zRO846JzTpO817zrOE8pqdp5TW3xPvPaZMnJOU6zVHKdZvN5vNk7zJueU3qzE6zvNJwmT
tNJ6zhF5VTy8DU1esyNUJvNE+LlMRlqxkIcp0mp95xT1q1Npk3nMW1YMWLqsHh85c5cFPZdy
5LaWpiZPVLeYmpsnOfM1JvVBlchMG6ylg4rFpd8t1VaXkPWaHrMmTKk3mTUyecxO05zmnY5z
JynCanOdpwTnOM6pquHWZNRckycJ0njNlTacZrFgtTCcliXNcV4r1Unet1stliGyyMmTpMJs
oYq2n7J7raLeZTvPcXaXSsXPxXVcVvwnZfevFbq7uC5r1WLZbryXP7lt7DByXw5LqunesXBd
Fk0cjwnGZP0myfMxdpk+06T0mJ4zyTqNpxnVPCcJt7TDhOG4mpwmy0mjD3mlpFvT5TjNTzm8
8U1qrw7TsnjO3JPSb2TGVdJtOqbp3TnMmyeE6znOk6GpqeE4UG07qmLgt1qXmtuY6LZcFuvR
cl4Q/k5rHiu+lyl5y717ryW681yHkuq3X4rqdJtNJyTE8p5zacpk2c56zjPic56TLlMp6TJq
Z4zpPKZOicCcZ8TvHusWyyXEYslg1LKWyxaGy5rZcVgZLxWl2rKnBfEeK8F1WTJ3nzPqnCes
4pznScJk8JpMN5fFVaWLQxcF8F0XVtO5TitLY8ZwThOE3nOdlbTyTWFTfRk2JqGyZN7wnCeE
9TI4TXlU2uMxpXMSc6l3m8W04zcmp3VcJvRdo3lwWy2S8luu1LS2WLkt4cThN02nCrFXnNSa
TtMnZO84zhOq85pOKcsmpVpYKHsTadp3mk9J8zSdJ5TSZVv5TvN+cyNe/GdjdeCdp8T5nun9
0yeVPOdZk/omx65P6JlPaZNpk/m8Z+9PicE57z5TJy2my1WLFtLS9Vi0vOrFg91g2XCdpy0a
mT+rU1P3zJkyfdX9c6zKNpwmThNYmjlpNTE2m02k5zKsWDFkuq+xaXnPoth3LuXkuFdlusXs
uC+Y4VinNYvR+C6VsuqyXNYWy2X18F3V9q8ZaXZffDzXBcl8FuuJ/NNJ1mpqdJump33V+zeB
xnnPSanCcpwi5zzm8eE4zVMnjNRduqes5zabwtExMyl0nFO0ycJxnCcZkyehtNzczImpknWr
0nGcp7zgnSbTjNpJMmK6zE5zE4cVcl4rsuC8OlaWqXVbrqtx964rwGx1ngtTlEt5k/CcZk8Z
+6ek8pwnjOk4TefKbTwnhNck1MnedpqbTJynDV9bynGfM4zgye05TtxnpN55Th8zymh1nVeq
2XpLgkOCxTFimLEtvC81jotq4rB2W8vwWxV1W60NTVXGbBwnxNpz4YeE7z+ac1umZONaWLJc
l5LsuC5riuIlYtL1W06T5mpxnBPGfKb0Pbynah1nSa3mR5LzWl9iyXZdlqNLJfBdlpeiyPDv
O05T3npPefWZOMyamqOSZOs8pqLaZMnOepsTxnKdZynVOE50MmKsqyYmRZPmaTUxMg3XctSy
Wy1UuaxeC9F3rYYOy0EvVYtljksONDF4r1WpcFgxYN5ZT+FdlzWxfFcV4LZdVi0tLFyW0uyy
HOWLvXJcFi0i4LyXZcZdFutUug81sthzHlwXgt5dj2mpxq4z6zZPJMTZPKdJ4zbc2nktZLst
IvRbymjquy1Cei2Wh2WLpRVpcFtAuy4r0XZcV7rvXInOanzNT3PE/E+/GdJhznWanOfodPec
U5Tymk9p5z7T6vifkydZ0nCb+k6TjNTU+n0N06zebe82m0yYvSYus4T0ml9+M2nAxPvNk2Ta
ZPtMcq6rQ+xYJ5LFxXqvgtpZuuK2XylxpqbExPOfE0nCfE1PxNTtP2zwp6risXuvdbLisli7
LzXp5S6ei5S0fSdZtMmT5q9JpO85zt3vY4TebzgmxIZMmx7TLpMbVbzE4zjMm63W/Zea0tpY
u5ZL0WS7LAXVcJqYmvrM6E3nKes7JtVcvA7JwT/VOs3nFOsynGcZzn4noJqc538pxm52nRan
GanGbzrNh9uU4T7fWd5xK85YOqygtLzlyWl6r1XYey5LgsXquVdWZ5LfisXFYMWUuiycFzOq
2mT4nrOk3nCfmcJtPsv7x/XP/kdF/gv0r8l/G91sv/i/xc1i6rdf2rF+xYuq4PJdaX7H4Lmn
iycl9F+aXVaX87m6rc8JtMmk53xNpvPZP4znes/hP7b0eC/xvdObItMS0sDwXB0W6+MsXCrV
+tcHdfu/f/n+/8v+vJO5dX7JeyyXZMXmuFXBeLg5D1WUXpNquMv7Wl9Fwkui6L7l+xk4svB+
9fN/itl/m5LjLZdy/MuFsvF3rS4y00sXKrouzm3XBzfivtuDHBdnOryXe9n0XmtLF3rmvF5O
5fcsl4r8V6rsu53LiP4ltLVX6F+S7pcZdmUeC/yaapXxWVW69FIHUY0vwXrWy1Jqdpun9c+k
qwZfA+Z6TlOqXOe1wWzJstLlPqtS+i5LSfg3X1XNcGm1cJicZ5Tocp+Z++es3m9iaGTsPJaX
2r3RWqv9j0k/qli2q2fmX3r71+S+LS7Lsu0ukq+r4L9C7LFyogfmebm/1WL90uq9lixS9XOa
T7l2l8nZfbfebzjMG82fBNTlfa/1J++fy35nOec7TacbmOs5T8zynab2TrZP7E1PScJwus8A
4nhPCfxqcZioPSfwuk53987TaZd52HC3TpN5iauEtraampkt1qlu5rThLUvRcZOQcF9q+9c1
hkSqvAcUdLVyTa2ZPO2T5n+E/hXnL7L8XivuX2rgv5l9bqvZ+K6r+V2l6sXU4TVzk7TUslyP
Cckf6J6LkP/hGq4v4ETyWl3FAe1eN4r3eC+9+1f/n1W7/V9yYvd4wXsyYsn8C5JTsuDE5XkO
M5TvN1wmpymTVOU0n6zhPWbTU/fPebTmn3XBOg6JqZOEuE+6vtsLLKriLcfF+e1LZkmImLma
mp9Zi7zT+kan+u3m9iyMTpNTQ9VqxaWNVaqsXZeDHaiBpflNT+ieD2oge7F4rhV3L/7O9cnW
fInORfiZOFFPEXSZFaAlYrrLlVstn7l4NTgpAxbscZY0uQ+s8143dNVfpP2znOA4TnMnU6T/
BOc3nQaGk8Jl6y2us2nN5TqcbwGpwmI/hdJ2vedpycZ2P+s9pqZftvpP9ifN/ze71X3LwQ/B
YVeC8Zbrg/nX758Kv4l7rnLIr2WNIrkucr7Rp+39q/wl/ksHBc3985t1/iv+y5r/ekS9F+df
mX5nSfl7zV/CfWfaZPceaP/8XckU4UJDI0KoBA==

--EeQfGwPcQSOJBaQU--

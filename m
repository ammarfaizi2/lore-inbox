Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261196AbTFXJBx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 05:01:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261292AbTFXJBw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 05:01:52 -0400
Received: from ppp-62-245-242-20.mnet-online.de ([62.245.242.20]:55198 "EHLO
	mail.gagern.sytes.net") by vger.kernel.org with ESMTP
	id S261196AbTFXJBH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 05:01:07 -0400
Message-ID: <3EF81690.8070009@gmx.net>
Date: Tue, 24 Jun 2003 11:14:56 +0200
From: Martin von Gagern <Martin.vGagern@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030612
X-Accept-Language: de-de, de, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: hippm@informatik.uni-tuebingen.de, keil@isdn4linux.de
Subject: Patch to isdn_ppp_xmit in 2.4.20 to resolve NULL pointer exception
X-Enigmail-Version: 0.74.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigDB4F5EA65B5A9D5460BA90EB"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigDB4F5EA65B5A9D5460BA90EB
Content-Type: multipart/mixed;
 boundary="------------030402020103050909010103"

This is a multi-part message in MIME format.
--------------030402020103050909010103
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

You don't have to read all this, just jump to the end of this mail,
Section 8, for the interesting part.

[1.] One line summary of the problem:
Kernel NULL pointer in ISDN subsystem resulting in Oops and panic

[2.] Full description of the problem/report:
Kernel Oops and resulting panic in isdn_ppp_xmit.
Happened several times so far, during normal operation with heavy load
on ISDN link.
I've got a patch solving at least the NULL pointer exception, but the
real cause is commented as "should not happen", so maybe someone should
have a look. See Section 8 at the end of this report.

[3.] Keywords (i.e., modules, networking, kernel):
isdn ppp isdn_ppp_xmit NULL pointer

[4.] Kernel version (from /proc/version):
Linux version 2.4.20 (root@server.gagern.sytes.net) (gcc version 3.2.2)
 #14 SMP Wed Jun 4 20:44:10 CEST 2003

[5.] Output of Oops.. message (if applicable) with symbolic information
     resolved (see Documentation/oops-tracing.txt)

Unable to handle kernel NULL pointer dereference at virtual address 0000012c
*pde=00000000
Oops: 0002
CPU: 0
EIP: 0010:[<c02d4d9c>] Not tainted
EFLAGS: 00010286
eax: 00000029 esi: dfd91800 edi: 00000000 ebp: 0000000a
ds: 0018 es: 0018 ss: 0018
Stack: c03bcd40 de44ba10 ...
Code: c6 87 2c 01 00 00 01 b8 00 e0 ff ff 21 e0 8b 40 30 c1 e0 05
<0> Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing

>>EIP; c02d4d9c <isdn_ppp_xmit+26c/6f0>   <=====

>>esi; dfd91800 <_end+1f8ca2a8/208c5b08>
>>esp; ca7d7a6c <_end+a310514/208c5b08>

Code;  c02d4d9c <isdn_ppp_xmit+26c/6f0>
00000000 <_EIP>:
Code;  c02d4d9c <isdn_ppp_xmit+26c/6f0>   <=====
   0:   c6 87 2c 01 00 00 01      movb   $0x1,0x12c(%edi)   <=====
Code;  c02d4da3 <isdn_ppp_xmit+273/6f0>
   7:   b8 00 e0 ff ff            mov    $0xffffe000,%eax
Code;  c02d4da8 <isdn_ppp_xmit+278/6f0>
   c:   21 e0                     and    %esp,%eax
Code;  c02d4daa <isdn_ppp_xmit+27a/6f0>
   e:   8b 40 30                  mov    0x30(%eax),%eax
Code;  c02d4dad <isdn_ppp_xmit+27d/6f0>
  11:   c1 e0 05                  shl    $0x5,%eax

[6.] A small shell script or example program which triggers the
     problem (if possible)
Impossible.

[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)
Gentoo Linux
Linux server.gagern.sytes.net 2.4.20 #14 SMP Wed Jun 4 20:44:10 CEST
2003 i686 Pentium III (Coppermine) GenuineIntel GNU/Linux

Gnu C                  3.2.2
Gnu make               3.80
util-linux             2.11y
mount                  2.11y
modutils               2.4.25
e2fsprogs              1.33
reiserfsprogs          3.6.8
Linux C Library        2.3.1
Dynamic linker (ldd)   2.3.1
Procps                 3.1.8
Net-tools              1.60
Kbd                    1.06
Sh-utils               2.0.15
Modules Loaded         snd-pcm-oss tvmixer snd-mixer-oss tuner tvaudio
msp3400 bttv i2c-algo-bit i2c-core videodev snd-emu10k1 snd-pcm
snd-timer snd-hwdep snd-util-mem snd-page-alloc snd-rawmidi
snd-seq-device snd-ac97-codec snd

[7.2.] Processor information (from /proc/cpuinfo):
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 10
cpu MHz         : 999.690
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 mmx fxsr sse
bogomips        : 1992.29

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 10
cpu MHz         : 999.690
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 mmx fxsr sse
bogomips        : 1998.84

[7.3.] Module information (from /proc/modules):
snd-pcm-oss            40132   0 (autoclean)
tvmixer                 3760   1 (autoclean)
snd-mixer-oss          13880   1 (autoclean) [snd-pcm-oss]
tuner                  10240   1 (autoclean)
tvaudio                12924   0 (autoclean) (unused)
msp3400                16972   1 (autoclean)
bttv                   70304   1 (autoclean)
i2c-algo-bit            7624   1 (autoclean) [bttv]
i2c-core               13124   0 (autoclean) [tvmixer tuner tvaudio
msp3400 bttv i2c-algo-bit]
videodev                6304   3 (autoclean) [bttv]
snd-emu10k1            73396   1
snd-pcm                62688   0 [snd-pcm-oss snd-emu10k1]
snd-timer              15592   0 [snd-pcm]
snd-hwdep               5312   0 [snd-emu10k1]
snd-util-mem            1296   0 [snd-emu10k1]
snd-page-alloc          4960   0 [snd-emu10k1 snd-pcm]
snd-rawmidi            13888   0 [snd-emu10k1]
snd-seq-device          4388   0 [snd-emu10k1 snd-rawmidi]
snd-ac97-codec         37760   0 [snd-emu10k1]
snd                    31012   0 [snd-pcm-oss snd-mixer-oss snd-emu10k1
snd-pcm snd-timer snd-hwdep snd-util-mem snd-rawmidi snd-seq-device
snd-ac97-codec]

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)

0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
02f8-02ff : serial(auto)
0376-0376 : ide1
03c0-03df : vesafb
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
5000-500f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
9000-90ff : ATI Technologies Inc Rage XL
9400-940f : VIA Technologies, Inc. VT82C586B PIPC Bus Master IDE
  9400-9407 : ide0
  9408-940f : ide1
9800-981f : VIA Technologies, Inc. USB
9c00-9c1f : VIA Technologies, Inc. USB (#2)
a000-a007 : Promise Technology, Inc. 20267
  a000-a007 : ide2
a400-a403 : Promise Technology, Inc. 20267
  a402-a402 : ide2
a800-a807 : Promise Technology, Inc. 20267
  a800-a807 : ide3
ac00-ac03 : Promise Technology, Inc. 20267
  ac02-ac02 : ide3
b000-b03f : Promise Technology, Inc. 20267
  b000-b007 : ide2
  b008-b00f : ide3
  b010-b03f : PDC20267
b400-b43f : Intel Corp. 82557/8/9 [Ethernet Pro 100]
  b400-b43f : eepro100
b800-b83f : Intel Corp. 82557/8/9 [Ethernet Pro 100] (#2)
  b800-b83f : eepro100
bc00-bc1f : Creative Labs SB Live! EMU10k1
  bc00-bc1f : EMU10K1
c000-c007 : Creative Labs SB Live! MIDI/Game Port
c400-c41f : AVM Audiovisuelles MKTG & Computer System GmbH A1 ISDN [Fritz]

  c400-c41f : avm PCI
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000cffff : Extension ROM
000f0000-000fffff : System ROM
00100000-1ffeffff : System RAM
  00100000-0036d96b : Kernel code
  0036d96c-003fdda7 : Kernel data
1fff0000-1fff2fff : ACPI Non-volatile Storage
1fff3000-1fffffff : ACPI Tables
d0000000-d3ffffff : VIA Technologies, Inc. VT82C693A/694x [Apollo PRO133x]
d4000000-d4ffffff : ATI Technologies Inc Rage XL
  d4000000-d43fffff : vesafb
d6000000-d60fffff : Intel Corp. 82557/8/9 [Ethernet Pro 100]
d6100000-d61fffff : Intel Corp. 82557/8/9 [Ethernet Pro 100] (#2)
d6200000-d621ffff : Promise Technology, Inc. 20267
d6220000-d6220fff : ATI Technologies Inc Rage XL
d6221000-d6221fff : Intel Corp. 82557/8/9 [Ethernet Pro 100] (#2)
  d6221000-d6221fff : eepro100
d6222000-d6222fff : Intel Corp. 82557/8/9 [Ethernet Pro 100]
  d6222000-d6222fff : eepro100
d6223000-d6223fff : Brooktree Corporation Bt878 Video Capture
  d6223000-d6223fff : bttv
d6224000-d6224fff : Brooktree Corporation Bt878 Audio Capture
d6225000-d622501f : AVM Audiovisuelles MKTG & Computer System GmbH A1
ISDN [Fritz]
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffff0000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)
PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: VIA Technologies, Inc. VT82C693A/694x [Apollo PRO133x]
(rev 196
).
      Prefetchable 32 bit memory at 0xd0000000 [0xd3ffffff].
  Bus  0, device   1, function  0:
    PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo
MVP3/Pro133x AGP] (
rev 0).
      Master Capable.  No bursts.  Min Gnt=4.
  Bus  0, device   6, function  0:
    VGA compatible controller: ATI Technologies Inc Rage XL (rev 39).
      IRQ 19.
      Master Capable.  Latency=32.  Min Gnt=8.
      Non-prefetchable 32 bit memory at 0xd4000000 [0xd4ffffff].
      I/O at 0x9000 [0x90ff].
      Non-prefetchable 32 bit memory at 0xd6220000 [0xd6220fff].
  Bus  0, device   7, function  0:
    ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South]
(rev 64).
  Bus  0, device   7, function  1:
    IDE interface: VIA Technologies, Inc. VT82C586B PIPC Bus Master IDE
(rev 6).
      Master Capable.  Latency=32.
      I/O at 0x9400 [0x940f].
  Bus  0, device   7, function  2:
    USB Controller: VIA Technologies, Inc. USB (rev 22).
      IRQ 19.
      Master Capable.  Latency=32.
      I/O at 0x9800 [0x981f].
  Bus  0, device   7, function  3:
    USB Controller: VIA Technologies, Inc. USB (#2) (rev 22).
      IRQ 19.
      Master Capable.  Latency=32.
      I/O at 0x9c00 [0x9c1f].
  Bus  0, device   7, function  4:
    Non-VGA unclassified device: VIA Technologies, Inc. VT82C686 [Apollo
Super A
CPI] (rev 64).
      IRQ 9.
  Bus  0, device  12, function  0:
    RAID bus controller: Promise Technology, Inc. 20267 (rev 2).
      IRQ 16.
      Master Capable.  Latency=32.
      I/O at 0xa000 [0xa007].
      I/O at 0xa400 [0xa403].
      I/O at 0xa800 [0xa807].
      I/O at 0xac00 [0xac03].
      I/O at 0xb000 [0xb03f].
      Non-prefetchable 32 bit memory at 0xd6200000 [0xd621ffff].
  Bus  0, device  13, function  0:
    Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 8).
      IRQ 17.
      Master Capable.  Latency=32.  Min Gnt=8.Max Lat=56.
      Non-prefetchable 32 bit memory at 0xd6222000 [0xd6222fff].
      I/O at 0xb400 [0xb43f].
      Non-prefetchable 32 bit memory at 0xd6000000 [0xd60fffff].
  Bus  0, device  14, function  0:
    Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (#2)
(rev 8).
      IRQ 18.
      Master Capable.  Latency=32.  Min Gnt=8.Max Lat=56.
      Non-prefetchable 32 bit memory at 0xd6221000 [0xd6221fff].
      I/O at 0xb800 [0xb83f].
      Non-prefetchable 32 bit memory at 0xd6100000 [0xd61fffff].
  Bus  0, device  15, function  0:
    Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 7).
      IRQ 17.
      Master Capable.  Latency=32.  Min Gnt=2.Max Lat=20.
      I/O at 0xbc00 [0xbc1f].
  Bus  0, device  15, function  1:
    Input device controller: Creative Labs SB Live! MIDI/Game Port (rev 7).
      Master Capable.  Latency=32.
      I/O at 0xc000 [0xc007].
  Bus  0, device  16, function  0:
    Multimedia video controller: Brooktree Corporation Bt878 Video
Capture (rev
17).
      IRQ 18.
      Master Capable.  Latency=32.  Min Gnt=16.Max Lat=40.
      Prefetchable 32 bit memory at 0xd6223000 [0xd6223fff].
  Bus  0, device  16, function  1:
    Multimedia controller: Brooktree Corporation Bt878 Audio Capture
(rev 17).
      IRQ 18.
      Master Capable.  Latency=32.  Min Gnt=4.Max Lat=255.
      Prefetchable 32 bit memory at 0xd6224000 [0xd6224fff].
  Bus  0, device  17, function  0:
    Network controller: AVM Audiovisuelles MKTG & Computer System GmbH
A1 ISDN [
Fritz] (rev 2).
      IRQ 19.
      Non-prefetchable 32 bit memory at 0xd6225000 [0xd622501f].
      I/O at 0xc400 [0xc41f].

[7.6.] SCSI information (from /proc/scsi/scsi)
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: PLEXTOR  Model: CD-R   PX-W2410A Rev: 1.01
  Type:   CD-ROM                           ANSI SCSI revision: 02

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):
grep -iE isdn\|fritz\|hisax .config
# ISDN subsystem
CONFIG_ISDN=y
CONFIG_ISDN_BOOL=y
CONFIG_ISDN_PPP=y
CONFIG_ISDN_PPP_VJ=y
CONFIG_ISDN_MPP=y
CONFIG_ISDN_PPP_BSDCOMP=y
CONFIG_ISDN_AUDIO=y
CONFIG_ISDN_TTY_FAX=y
# ISDN feature submodules
CONFIG_ISDN_DRV_LOOP=m
CONFIG_ISDN_DIVERSION=m
# Passive ISDN cards
CONFIG_ISDN_DRV_HISAX=y
CONFIG_ISDN_HISAX=y
CONFIG_HISAX_EURO=y
# CONFIG_HISAX_NO_SENDCOMPLETE is not set
# CONFIG_HISAX_NO_LLC is not set
# CONFIG_HISAX_NO_KEYPAD is not set
# CONFIG_HISAX_1TR6 is not set
# CONFIG_HISAX_NI1 is not set
CONFIG_HISAX_MAX_CARDS=2
# CONFIG_HISAX_TELESPCI is not set
# CONFIG_HISAX_S0BOX is not set
CONFIG_HISAX_FRITZPCI=y
# CONFIG_HISAX_AVM_A1_PCMCIA is not set
# CONFIG_HISAX_ELSA is not set
# CONFIG_HISAX_DIEHLDIVA is not set
# CONFIG_HISAX_SEDLBAUER is not set
# CONFIG_HISAX_NETJET is not set
# CONFIG_HISAX_NETJET_U is not set
# CONFIG_HISAX_NICCY is not set
# CONFIG_HISAX_BKM_A4T is not set
# CONFIG_HISAX_SCT_QUADRO is not set
# CONFIG_HISAX_GAZEL is not set
# CONFIG_HISAX_HFC_PCI is not set
# CONFIG_HISAX_W6692 is not set
# CONFIG_HISAX_HFC_SX is not set
# CONFIG_HISAX_ENTERNOW_PCI is not set
CONFIG_HISAX_DEBUG=y
# CONFIG_HISAX_SEDLBAUER_CS is not set
# CONFIG_HISAX_ELSA_CS is not set
# CONFIG_HISAX_AVM_A1_CS is not set
# CONFIG_HISAX_ST5481 is not set
CONFIG_HISAX_FRITZ_PCIPNP=m
# Active ISDN cards
# CONFIG_ISDN_DRV_ICN is not set
# CONFIG_ISDN_DRV_PCBIT is not set
# CONFIG_ISDN_DRV_SC is not set
# CONFIG_ISDN_DRV_ACT2000 is not set
# CONFIG_ISDN_DRV_EICON is not set
# CONFIG_ISDN_DRV_TPAM is not set
# CONFIG_ISDN_CAPI is not set

[8.] Other notes, patches, fixes, workarounds:

Now this is the interesting part!









[8.1.] Patch to avoid NULL pointer exception
The label "unlock" would result in "spin_unlock_bh(&lp->xmit_lock)",
which is a bad idea if lp is NULL.

--- linux/drivers/isdn/isdn_ppp.c 2003-05-06 16:51:15.000000000 +0200
+++ linux/drivers/isdn/isdn_ppp.c 2003-06-24 10:42:53.000000000 +0200
@@ -1176,7 +1176,7 @@
 	if (!lp) {
 		printk(KERN_WARNING "%s: all channels busy - requeuing!\n",
netdev->name);
 		retval = 1;
-		goto unlock;
+		goto out;
 	}
 	/* we have our lp locked from now on */

[8.2.] Corresponding part in isdn_net.h, lines 70-96
I believe the NULL pointer came from the line marked "should never
happen". Otherwise we'd have a NULL pointer exception right here, in the
spin_lock_bh.
As you can see, there should be no locks left over, so at least jumping
to out instead of unlock in the above patch should be correct in any case.

/*
 * For the given net device, this will get a non-busy channel out of the
 * corresponding bundle. The returned channel is locked.
 */
static __inline__ isdn_net_local * isdn_net_get_locked_lp
 (isdn_net_dev *nd)
{
  unsigned long flags;
  isdn_net_local *lp;

  spin_lock_irqsave(&nd->queue_lock, flags);
  lp = nd->queue;         /* get lp on top of queue */
  spin_lock_bh(&nd->queue->xmit_lock);
  while (isdn_net_lp_busy(nd->queue)) {
    spin_unlock_bh(&nd->queue->xmit_lock);
    nd->queue = nd->queue->next;
    if (nd->queue == lp) { /* not found -- should never happen */
      lp = NULL;
      goto errout;
    }
    spin_lock_bh(&nd->queue->xmit_lock);
  }
  lp = nd->queue;
  nd->queue = nd->queue->next;
errout:
  spin_unlock_irqrestore(&nd->queue_lock, flags);
  return lp;
}

--------------030402020103050909010103
Content-Type: text/plain;
 name="isdn_ppp_xmit.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="isdn_ppp_xmit.patch"

--- linux/drivers/isdn/isdn_ppp.c	2003-05-06 16:51:15.000000000 +0200
+++ linux/drivers/isdn/isdn_ppp.c	2003-06-24 10:42:53.000000000 +0200
@@ -1176,7 +1176,7 @@
 	if (!lp) {
 		printk(KERN_WARNING "%s: all channels busy - requeuing!\n", netdev->name);
 		retval = 1;
-		goto unlock;
+		goto out;
 	}
 	/* we have our lp locked from now on */
 

--------------030402020103050909010103--

--------------enigDB4F5EA65B5A9D5460BA90EB
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE++BaV1uxO6mboU6gRAt6rAJ4otXc+IlyGmbHPJi3GbOzg+O/V9gCfQDfb
vBMjDNjKeSsa2HVb66fcRHk=
=fgWg
-----END PGP SIGNATURE-----

--------------enigDB4F5EA65B5A9D5460BA90EB--


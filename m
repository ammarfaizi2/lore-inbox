Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261195AbUCCVQP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 16:16:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261203AbUCCVQP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 16:16:15 -0500
Received: from BOFH.binhex.EU.org ([212.30.223.106]:37894 "EHLO binhex.EU.org")
	by vger.kernel.org with ESMTP id S261195AbUCCVP6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 16:15:58 -0500
Date: Wed, 3 Mar 2004 21:15:53 +0000
From: =?iso-8859-1?Q?Gu=F0mundur_D=2E?= Haraldsson <gdh@binhex.EU.org>
To: linux-kernel@vger.kernel.org
Subject: Kernel panic on kernel 2.6.3 with AIC-7770 SCSI controller
Message-ID: <20040303211553.GA2902@binhex.EU.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="h31gzZEtNLTqOjlF"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-Organization: binhex.EU.org
X-To-Spammer: You spam me and you will get an anal probe.
X-Spam-Search-By: binhex.EU.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,=20

I have a HP NetServer machine which I want to upgrade to kernel 2.6.3, but =
I am unable
to do so since the machine panics when probing the SCSI controller, which i=
s an Adaptec=20
AIC-7770. Please note that the driver for the card is built into the kernel=
, so it has=20
not even started init when this happens. This problem also happens with ker=
nel 2.4.22, but
2.4.7 works fine.

My environment is this:

HP NetServer LC 133MHz, 64MB RAM, 4 SCSI Hard-drives, 1 tape drive and 1 cd=
-rom drive -=20
all of those are connected to the AIC-7770. More info about the hardware is=
 in the bottom
of the message.

Gnu C                  2.96
Gnu make               3.79.1
util-linux             2.11f
mount                  2.11g
module-init-tools      writing
e2fsprogs              1.26
pcmcia-cs              3.1.22
quota-tools            3.06.
Linux C Library        2.2.4
Dynamic linker (ldd)   2.2.4
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.3.3
Sh-utils               2.0.11
Modules Loaded         ipv6 ipt_REJECT iptable_nat ip_conntrack iptable_fil=
ter ip_tables eepro100 st aic7xxx sd_mod scsi_mod

---

I was able to catch the oops and after I ran it through the ksymoops progra=
m, I get this:

ksymoops 2.4.1 on i586 2.4.7-10.  Options used
     -v /home/gdh/linux-2.6.3/vmlinux (specified)
     -K (specified)
     -L (specified)
     -o /lib/modules/2.6.3/ (specified)
     -m /home/gdh/linux-2.6.3/System.map (specified)

No modules in ksyms, skipping objects
Intel Pentium with F0 0F bug - workaround enabled.
  Receiver lock-up bug exists -- enabling work-around.
Unable to handle kernel NULL pointer dereference at virtual address 00000088
c0178749
*pde =3D 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c0178749>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: 00000070   ebx: 00000070   ecx: 00000005   edx: c3f50cc0
esi: c3f50cc0   edi: c3f50d1e   ebp: c3f50cc0   esp: c10bff84
ds: 007b   es: 007b   ss: 0068
Stack: c3f50d18 c01a1011 00000070 c01a0f3b 0000004c 0000004c c3f50c00 c02b4=
960=20
       c3f50cc0 c01cce40 c3f50cc0 c3f50c00 c02b49d4 c02b4960 00000000 c02ee=
a9e=20
       c3f50c00 00000000 c0335d28 00000000 00000000 c02de68b c0105060 00000=
000=20
 [<c01a1011>] get_device+0x11/0x20
 [<c01a0f3b>] device_add+0x3b/0xe0
 [<c01cce40>] scsi_add_host+0x80/0xf0
 [<c02eea9e>] init_this_scsi_driver+0x7e/0xe0
 [<c02de68b>] do_initcalls+0x3b/0x90
 [<c0105060>] init+0x0/0xe0
 [<c010507a>] init+0x1a/0xe0
 [<c0105060>] init+0x0/0xe0
 [<c0106f95>] kernel_thread_helper+0x5/0x10
Code: 8b 43 18 85 c0 75 21 68 af 01 00 00 68 80 a7 26 c0 68 8e a7=20

>>EIP; c0178749 <kobject_get+9/40>   <=3D=3D=3D=3D=3D
Code;  c0178749 <kobject_get+9/40>
00000000 <_EIP>:
Code;  c0178749 <kobject_get+9/40>   <=3D=3D=3D=3D=3D
   0:   8b 43 18                  mov    0x18(%ebx),%eax   <=3D=3D=3D=3D=3D
Code;  c017874c <kobject_get+c/40>
   3:   85 c0                     test   %eax,%eax
Code;  c017874e <kobject_get+e/40>
   5:   75 21                     jne    28 <_EIP+0x28> c0178771 <kobject_g=
et+31/40>
Code;  c0178750 <kobject_get+10/40>
   7:   68 af 01 00 00            push   $0x1af
Code;  c0178755 <kobject_get+15/40>
   c:   68 80 a7 26 c0            push   $0xc026a780
Code;  c017875a <kobject_get+1a/40>
  11:   68 8e a7 00 00            push   $0xa78e

 <0>Kernel panic: Attempted to kill init!

---

More about the hardware:

=2E. and the PCI devices:
00:00.0 Host bridge: Intel Corporation 82434LX [Mercury/Neptune] (rev 11)
00:03.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (re=
v 01)
00:04.0 Non-VGA unclassified device: Intel Corporation 82375EB (rev 03)

=2E. and the SCSI controller seen by the 2.4.7 kernel, which works (!):
SCSI subsystem driver Revision: 1.00
(scsi0) <Adaptec AIC-7770 SCSI host adapter> found at EISA slot 11
(scsi0) Twin Channel, A SCSI ID 7, B SCSI ID 7, 4/255 SCBs
(scsi0) Downloading sequencer code... 426 instructions downloaded
scsi0 : Adaptec AHA274x/284x/294x (EISA/VLB/PCI-Fast SCSI) 5.2.4/5.2.0
       <Adaptec AIC-7770 SCSI host adapter>
  Vendor: IBM       Model: DCAS-34330W       Rev: S65A
  Type:   Direct-Access                      ANSI SCSI revision: 02
(scsi0:0:1:0) Synchronous at 10.0 Mbyte/sec, offset 15.
  Vendor: COMPAQ    Model: ST32171W          Rev: 0388
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: SONY      Model: CD-ROM CDU-76S    Rev: 1.1c
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: HP        Model: C1533A            Rev: A708
  Type:   Sequential-Access                  ANSI SCSI revision: 02
  Vendor: Quantum   Model: XP32150W          Rev: L912
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: IBM       Model: DCAS-34330W       Rev: S65A
  Type:   Direct-Access                      ANSI SCSI revision: 02
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi disk sdb at scsi0, channel 0, id 1, lun 0
Attached scsi disk sdc at scsi0, channel 1, id 0, lun 0
Attached scsi disk sdd at scsi0, channel 1, id 1, lun 0
(scsi0:0:0:0) Synchronous at 10.0 Mbyte/sec, offset 15.
SCSI device sda: 8467200 512-byte hdwr sectors (4335 MB)
 sda: sda1 sda4
SCSI device sdb: 4110000 512-byte hdwr sectors (2104 MB)
 sdb: sdb1 sdb2 < sdb5 sdb6 >
(scsi0:1:0:0) Synchronous at 10.0 Mbyte/sec, offset 15.
SCSI device sdc: 4406960 512-byte hdwr sectors (2256 MB)
 sdc: sdc1
(scsi0:1:1:0) Synchronous at 10.0 Mbyte/sec, offset 15.
SCSI device sdd: 8467200 512-byte hdwr sectors (4335 MB)
 sdd: sdd1

=2E. and the CPU:
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 5
model		: 2
model name	: Pentium 75 - 200
stepping	: 12
cpu MHz		: 133.335
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: yes
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr mce cx8
bogomips	: 265.42

=2E. and iomem:
00000000-0009efff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000cffff : Extension ROM
000f0000-000fffff : System ROM
00100000-03ffffff : System RAM
  00100000-0024007f : Kernel code
  00240080-00256a6b : Kernel data
fecff000-fecfffff : Intel Corporation 82557 [Ethernet Pro 100]
  fecff000-fecfffff : eepro100
fed00000-fedfffff : Intel Corporation 82557 [Ethernet Pro 100]

=2E. and ioports:
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
02f8-02ff : serial(auto)
03b0-03bf : ega
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cfb : PCI conf2
bc00-bcfe : aic7xxx
fce0-fcff : Intel Corporation 82557 [Ethernet Pro 100]
  fce0-fcff : eepro100

=2E. and interrupts:
           CPU0      =20
  0:    7781679          XT-PIC  timer
  1:         21          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  8:          1          XT-PIC  rtc
 11:      66644          XT-PIC  eth0
 12:          0          XT-PIC  PS/2 Mouse
 14:         12          XT-PIC  ide0
 15:      85576          XT-PIC  aic7xxx
NMI:          0=20
ERR:          0



I really hope that this is enough info, just let me know if there is someth=
ing I'm missing.

If needed, I can try to pin down when this problem started to happen (which=
 is somewhere 2.4.7=20
and 2.4.22), I'll do so if requested.


Thank you very much,=20
best regards,=20
Gudmundur D. Haraldsson.


--=20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
| Gu=F0mundur D. Haraldsson               | When you have eliminated the im=
possible,|
| gdh@binhex.EU.org                     | what ever remains, however improb=
able,  |
| http://www.binhex.EU.org/             | must be the truth.			  |
|                                       | - Sherlock Holmes, "The sign of f=
our"	  |
|--------------------------------------------------------------------------=
-------|
| GPG key: lynx -dump http://vlug.eyjar.is/gdh/gpgkey.asc | gpg --import   =
       |
| Key fingerprint =3D DE6D A875 EA92 0699 9B49  8C49 2DBB 76BF ADD4 C933		 =
 |
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
// Spammers will be asphyxiated in pat=E9!

--h31gzZEtNLTqOjlF
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFARksILbt2v63UyTMRAulGAKC9dh3Ar8+E10QBSMQuGzr3nbuaUgCeMYPh
h3uQFjv73Dk3gmbIdc+6vU4=
=FNE4
-----END PGP SIGNATURE-----

--h31gzZEtNLTqOjlF--

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271662AbTGRA4P (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 20:56:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271665AbTGRA4P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 20:56:15 -0400
Received: from adsl-66-159-224-106.dslextreme.com ([66.159.224.106]:41227 "EHLO
	zork.ruvolo.net") by vger.kernel.org with ESMTP id S271662AbTGRA4G
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 20:56:06 -0400
Date: Thu, 17 Jul 2003 18:11:01 -0700
From: Chris Ruvolo <chris+lkml@ruvolo.net>
To: LKML <linux-kernel@vger.kernel.org>
Subject: 2.6.0-t1 garbage in /proc/ioports and oops
Message-ID: <20030718011101.GD15716@ruvolo.net>
Mail-Followup-To: LKML <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zaRBsRFn0XYhEU69"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--zaRBsRFn0XYhEU69
Content-Type: multipart/mixed; boundary="kvUQC+jR9YzypDnK"
Content-Disposition: inline


--kvUQC+jR9YzypDnK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi, I am seeing some garbage data in /proc/ioports.  Currently, I can cat
the file without an oops, but on a previous boot, the following oops came
up when catting the file.

Exact output from /proc/ioports is attached (some 8-bit garbage), as well as
lsmod output.  Let me know if further data is needed.

I suspect that this is a problem in one of the drivers I am using, but
how do I track down which one it is (since the name is not there)?

Thanks,
-Chris


  printing eip:
 c01a123a
 Oops: 0000 [#1]
 CPU:    0
 EIP:    0060:[<c01a123a>]    Not tainted
 EFLAGS: 00010297
 EIP is at vsnprintf+0x31a/0x450
 eax: cca060f5   ebx: 0000000a   ecx: cca060f5   edx: fffffffe
 esi: c3e7f10d   edi: 00000000   ebp: c45bdec0   esp: c45bde88
 ds: 007b   es: 007b   ss: 0068
 Process cat (pid: 1661, threadinfo=3Dc45bc000 task=3Dc44a9340)
 Stack: c3e7f106 c3e7ffff 0000038b 00000000 00000010 00000004 00000002 0000=
0001=20
        ffffffff ffffffff c3e7ffff c32971e0 00000000 c0241301 c45bdedc c016=
7426=20
        c3e7f101 00000eff c024131a c45bdef8 c76fc580 c45bdf04 c011cf64 c329=
71e0=20
 Call Trace:
  [<c0167426>] seq_printf+0x36/0x60
  [<c011cf64>] do_resource_list+0x64/0xa0
  [<c011cfeb>] ioresources_show+0x4b/0x70
  [<c0166e0f>] seq_read+0xef/0x300
  [<c0149b3a>] vfs_read+0xaa/0x130
  [<c0149def>] sys_read+0x3f/0x60
  [<c010940b>] syscall_call+0x7/0xb
=20
 Code: 80 38 00 74 07 40 4a 83 fa ff 75 f4 29 c8 83 e7 10 89 c3 75=20
  <6>note: cat[1661] exited with preempt_count 1

--kvUQC+jR9YzypDnK
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: attachment; filename=proc-ioports
Content-Transfer-Encoding: quoted-printable

0000-001f : dma1
0020-0021 : pic1
0040-005f : timer
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
02f8-02ff : serial
0376-0376 : ide1
0378-037a : parport0
037b-037f : parport0
0388-038b : =85=FF=B8=C6=C6=8E=C8=C7=04$=C7=C6=8E=C8=BA=CC=C6=8E=C8=0FD=D0G=
=89T$=04=E8=AB=E4=82=F7=8BC=10=A8=10t+=C7D$=08=CE=C6=8E=C8=85=FF=B8=C6=C6=
=8E=C8=C7=04$=C7=C6=8E=C8=BA=CC=C6=8E=C8=0FD=D0G=89T$=04=E8|=E4=82=F7=8BC=
=10=A8=04t+=C7D$=08=D5=C6=8E=C8=85=FF=B8=C6=C6=8E=C8=C7=04$=C7=C6=8E=C8=BA=
=CC=C6=8E=C8=0FD=D0G=89T$=04=E8M=E4=82=F7=8BC=10=A8=08t+=C7D$=08=EA=C4=8E=
=C8=85=FF=B8=C6=C6=8E=C8=C7=04$=C7=C6=8E=C8=BA=CC=C6=8E=C8=0FD=D0G=89T$=04=
=E8=1E=E4=82=F7=8BC=10=A8 t'=C7D$=08=D9=C6=8E=C8=BA=CC=C6=8E=C8=85=FF=C7=04=
$=C7=C6=8E=C8=B8=C6=C6=8E=C8=0FD=D0=89T$=04=E8=F0=E3=82=F7=C7=04$=DD=C6=8E=
=C8=E8=E4=E3=82=F7=C7=04$=E4=C6=8E=C8=E8=D8=E3=82=F7=83=BD
03c0-03df : vga+
03f6-03f6 : ide0
0cf8-0cff : PCI conf1
4000-403f : Intel Corp. 82371AB/EB/MB PIIX4=20
5000-501f : Intel Corp. 82371AB/EB/MB PIIX4=20
  5000-5007 : piix4-smbus
d000-dfff : PCI Bus #01
  d000-d0ff : 3Dfx Interactive, In Voodoo 3
e000-e01f : Intel Corp. 82371AB/EB/MB PIIX4=20
e400-e4ff : Lite-On Communicatio LNE100TX
  e400-e4ff : tulip
e800-e87f : VIA Technologies, In IEEE 1394 Host Contr
ec00-ec07 : US Robotics/3Com 56K FaxModem Model 5
  ec00-ec07 : serial
f000-f00f : Intel Corp. 82371AB/EB/MB PIIX4=20
  f000-f007 : ide0
  f008-f00f : ide1

--kvUQC+jR9YzypDnK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=lsmod
Content-Transfer-Encoding: quoted-printable

Module                  Size  Used by
raw1394                24652  0=20
ohci1394               30216  0=20
ieee1394               69676  2 raw1394,ohci1394
w83781d                33856  0=20
i2c_sensor              2400  1 w83781d
i2c_piix4               5996  0=20
i2c_core               20136  3 w83781d,i2c_sensor,i2c_piix4
tdfx                   34248  0=20
visor                  15404  0=20
usbserial              23940  1 visor
usb_storage            27328  0=20
sd_mod                 11104  0=20
usbcore                96380  4 visor,usbserial,usb_storage
loop                   13352  0=20
sr_mod                 12260  0=20
cdrom                  32992  1 sr_mod
ide_scsi               12832  0=20
sg                     29720  0=20
scsi_mod               94152  5 usb_storage,sd_mod,sr_mod,ide_scsi,sg
rtc                    10388  0=20
floppy                 55796  0=20
8250_pci                9856  0=20
8250                   17008  1 8250_pci
core                   19488  1 8250
lp                      7936  0=20
parport_pc             19512  1=20
parport                22656  2 lp,parport_pc
unix                   22288  16=20
apm                    15300  0=20
snd_opl3_lib            9120  0=20
snd_sb16_dsp            9952  0=20
snd_sb16_csp           19296  0=20
snd_sb_common          13408  2 snd_sb16_dsp,snd_sb16_csp
snd_hwdep               6752  2 snd_opl3_lib,snd_sb16_csp
snd_mpu401_uart         5856  0=20
snd_pcm                87204  1 snd_sb16_dsp
snd_page_alloc          7780  1 snd_pcm
snd_emux_synth         34784  0=20
snd_seq_virmidi         5728  1 snd_emux_synth
snd_rawmidi            19936  2 snd_mpu401_uart,snd_seq_virmidi
snd_seq_midi_event      5760  1 snd_seq_virmidi
snd_seq_midi_emul       6944  1 snd_emux_synth
snd_seq                50800  4 snd_emux_synth,snd_seq_virmidi,snd_seq_midi=
_event,snd_seq_midi_emul
snd_timer              21220  3 snd_opl3_lib,snd_pcm,snd_seq
snd_seq_device          6120  3 snd_opl3_lib,snd_emux_synth,snd_rawmidi
snd_util_mem            3200  1 snd_emux_synth
snd                    43364  15 snd_opl3_lib,snd_sb16_dsp,snd_sb16_csp,snd=
_sb_common,snd_hwdep,snd_mpu401_uart,snd_pcm,snd_emux_synth,snd_seq_virmidi=
,snd_rawmidi,snd_seq_midi_event,snd_seq,snd_timer,snd_seq_device,snd_util_m=
em
soundcore               6784  1 snd
nls_cp437               5312  0=20
nls_iso8859_1           3648  0=20
vfat                   12704  0=20
msdos                   8672  0=20
isofs                  30872  0=20
zlib_inflate           21312  1 isofs
fat                    41920  2 vfat,msdos
af_packet              12616  2=20
tulip                  36288  0=20
crc32                   3808  1 tulip
ipchains               49224  33=20

--kvUQC+jR9YzypDnK--

--zaRBsRFn0XYhEU69
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE/F0klKO6EG1hc77ERAuMoAKDKohCPch0EY5znuiYAu/KLjuXOzgCg9tgn
qGDWlMrnZssDm2t4Oiz1KJQ=
=VQzC
-----END PGP SIGNATURE-----

--zaRBsRFn0XYhEU69--

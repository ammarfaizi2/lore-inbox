Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267415AbUHDUv0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267415AbUHDUv0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 16:51:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267418AbUHDUv0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 16:51:26 -0400
Received: from postimies.kymp.net ([80.248.96.135]:49668 "EHLO janus.kymp.net")
	by vger.kernel.org with ESMTP id S267415AbUHDUr7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 16:47:59 -0400
Date: Wed, 4 Aug 2004 23:47:53 +0300
To: linux-kernel@vger.kernel.org
Subject: ALSA oops with OSS emulation; 2.6.7 and 2.6.8-rc3
Message-ID: <20040804204753.GA31441@bostik.iki.fi>
Reply-To: Mika Bostrom <bostik+lkml@bostik.iki.fi>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pWyiEgJYm5f9v55/"
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
From: bostik@bostik.iki.fi (Mika Bostrom)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

  I have managed to reproduce an oops with the following steps:

  * Play some old Sierra game inside FreeSCI for a few hours
  * Quit FreeSCI

  It's irrelevant which audio driver is used for FreeSCI, as the oops
happens with null driver as well.

  Pre-empt is off. IO-APIC is off. ACPI is off. 4k stacks is off.
Difference between kernel configurations is minimal: only the new AES
option was selected in 2.6.8-rc3 in addition to those in 2.6.7. Sound
card, according to lspci -vvv:

0000:00:0b.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (r=
ev 10)
        Subsystem: C-Media Electronics Inc CMI8738/C3DX PCI Audio Device
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping+ SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (500ns min, 6000ns max)
        Interrupt: pin A routed to IRQ 3
        Region 0: I/O ports at b800 [size=3D256]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)=20
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

  In each case the following modules were loaded:
radeon sd_mod 8250 serial_core ehci_hcd uhci_hcd usbcore dm_mod it87
eeprom i2c_sensor i2c_isa i2c_viapro i2c_core via_agp agpgart ip_tables
isofs ide_cd sg scsi_mod snd_cmipci snd_pcm_oss snd_mixer_oss snd_pcm
snd_page_alloc snd_opl3_lib snd_timer snd_hwdep snd_mpu401_uart
snd_rawmidi snd_seq_device snd soundcore 3c59x parport_pc lp parport apm
cdrom rtc

  Relevant lines from .configs:

CONFIG_SND_CMIPCI=3Dm
CONFIG_SND=3Dm
CONFIG_SND_TIMER=3Dm
CONFIG_SND_PCM=3Dm
CONFIG_SND_HWDEP=3Dm
CONFIG_SND_RAWMIDI=3Dm
CONFIG_SND_SEQUENCER=3Dm
CONFIG_SND_SEQ_DUMMY=3Dm
CONFIG_SND_OSSEMUL=3Dy
CONFIG_SND_MIXER_OSS=3Dm
CONFIG_SND_PCM_OSS=3Dm
CONFIG_SND_SEQUENCER_OSS=3Dy
CONFIG_SND_RTCTIMER=3Dm
CONFIG_SND_VERBOSE_PRINTK=3Dy
# CONFIG_SND_DEBUG is not set
CONFIG_SND_MPU401_UART=3Dm
CONFIG_SND_OPL3_LIB=3Dm
CONFIG_SND_DUMMY=3Dm
CONFIG_SND_VIRMIDI=3Dm
# CONFIG_SND_MTPAV is not set
# CONFIG_SND_SERIAL_U16550 is not set
CONFIG_SND_MPU401=3Dm

  Any more info I should provide? I'm willing to try if there's a patch to
fix this.=20

  Below are three ksymoops-processed messages. First was 2.6.7 with
normal audio driver (defaults to OSS). Second was 2.6.7 with null audio
driver. Third was 2.6.8-rc3 with null audio driver. Normal ksymoops
whines about not specifying files are omitted.

[-- Number 1]
ksymoops 2.4.9 on i686 2.6.7.  Options used
[...]
Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Unable to handle kernel NULL pointer dereference at virtual address 00000d80
c029c489
*pde =3D 00000000
Oops: 0002 [#1]
CPU:    0
EIP:    0060:[<c029c489>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246   (2.6.7)=20
eax: 00000000   ebx: 00001000   ecx: 00001000   edx: 0819d7f0
esi: 0819c7f0   edi: 00000d80   ebp: c158cde0   esp: d7ae4e78
ds: 007b   es: 007b   ss: 0068
Stack: 00000000 00001000 00001350 927335c3 000d498a 00000000 00000d80 c01f9=
482=20
       00000d80 0819c7f0 00001000 00001000 e0913360 df88f000 e0901896 00000=
d80=20
       0819c7f0 00001000 c011ab90 c59d3470 11486360 00000400 00002000 df88f=
000=20
Call Trace:
 [<c01f9482>] copy_from_user+0x42/0x80
 [<e0901896>] snd_pcm_lib_write_transfer+0x96/0xb0 [snd_pcm]
 [<c011ab90>] process_timeout+0x0/0x10
 [<e0901afe>] snd_pcm_lib_write1+0x24e/0x3e0 [snd_pcm]
 [<c0110ab0>] default_wake_function+0x0/0x20
 [<e0901d17>] snd_pcm_lib_write+0x87/0xa0 [snd_pcm]
 [<e0901800>] snd_pcm_lib_write_transfer+0x0/0xb0 [snd_pcm]
 [<e08fcd6a>] snd_pcm_playback_ioctl1+0x29a/0x300 [snd_pcm]
 [<c0154315>] sys_ioctl+0xd5/0x240
 [<c0103d69>] sysenter_past_esp+0x52/0x71
Code: f3 aa 58 59 e9 38 cf f5 ff b8 f2 ff ff ff e9 3d 1b f6 ff b8=20


>>EIP; c029c489 <__sched_text_end+a31/ef2>   <=3D=3D=3D=3D=3D

>>ebp; c158cde0 <pg0+120cde0/3fc7e000>
>>esp; d7ae4e78 <pg0+17764e78/3fc7e000>

Trace; c01f9482 <copy_from_user+42/80>
Trace; e0901896 <pg0+20581896/3fc7e000>
Trace; c011ab90 <process_timeout+0/10>
Trace; e0901afe <pg0+20581afe/3fc7e000>
Trace; c0110ab0 <default_wake_function+0/20>
Trace; e0901d17 <pg0+20581d17/3fc7e000>
Trace; e0901800 <pg0+20581800/3fc7e000>
Trace; e08fcd6a <pg0+2057cd6a/3fc7e000>
Trace; c0154315 <sys_ioctl+d5/240>
Trace; c0103d69 <sysenter_past_esp+52/71>

Code;  c029c489 <__sched_text_end+a31/ef2>
00000000 <_EIP>:
Code;  c029c489 <__sched_text_end+a31/ef2>   <=3D=3D=3D=3D=3D
   0:   f3 aa                     repz stos %al,%es:(%edi)   <=3D=3D=3D=3D=
=3D
Code;  c029c48b <__sched_text_end+a33/ef2>
   2:   58                        pop    %eax
Code;  c029c48c <__sched_text_end+a34/ef2>
   3:   59                        pop    %ecx
Code;  c029c48d <__sched_text_end+a35/ef2>
   4:   e9 38 cf f5 ff            jmp    fff5cf41 <_EIP+0xfff5cf41>
Code;  c029c492 <__sched_text_end+a3a/ef2>
   9:   b8 f2 ff ff ff            mov    $0xfffffff2,%eax
Code;  c029c497 <__sched_text_end+a3f/ef2>
   e:   e9 3d 1b f6 ff            jmp    fff61b50 <_EIP+0xfff61b50>
Code;  c029c49c <__sched_text_end+a44/ef2>
  13:   b8 00 00 00 00            mov    $0x0,%eax


[-- Number 2]
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Unable to handle kernel paging request at virtual address 00007990
c029c489
*pde =3D 00000000
Oops: 0002 [#1]
CPU:    0
EIP:    0060:[<c029c489>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246   (2.6.7)=20
eax: 00000000   ebx: 00000670   ecx: 00000670   edx: 0819ce70
esi: 0819c800   edi: 00007990   ebp: c158dde0   esp: d1d2fe78
ds: 007b   es: 007b   ss: 0068
Stack: 00000000 00000670 00000e1c 0a405d3b 00001057 00000000 00007990 c01f9=
482=20
       00007990 0819c800 00000670 00000670 e0913360 df251400 e0901896 00007=
990=20
       0819c800 00000670 c011ab90 d050f690 085b5e64 0000019c 00002000 df251=
400=20
Call Trace:
 [<c01f9482>] copy_from_user+0x42/0x80
 [<e0901896>] snd_pcm_lib_write_transfer+0x96/0xb0 [snd_pcm]
 [<c011ab90>] process_timeout+0x0/0x10
 [<e0901afe>] snd_pcm_lib_write1+0x24e/0x3e0 [snd_pcm]
 [<c0110ab0>] default_wake_function+0x0/0x20
 [<c0103f28>] common_interrupt+0x18/0x20
 [<e0901d17>] snd_pcm_lib_write+0x87/0xa0 [snd_pcm]
 [<e0901800>] snd_pcm_lib_write_transfer+0x0/0xb0 [snd_pcm]
 [<e08fcd6a>] snd_pcm_playback_ioctl1+0x29a/0x300 [snd_pcm]
 [<c0154315>] sys_ioctl+0xd5/0x240
 [<c0103d69>] sysenter_past_esp+0x52/0x71
Code: f3 aa 58 59 e9 38 cf f5 ff b8 f2 ff ff ff e9 3d 1b f6 ff b8=20


>>EIP; c029c489 <__sched_text_end+a31/ef2>   <=3D=3D=3D=3D=3D

>>ebp; c158dde0 <pg0+120dde0/3fc7e000>
>>esp; d1d2fe78 <pg0+119afe78/3fc7e000>

Trace; c01f9482 <copy_from_user+42/80>
Trace; e0901896 <pg0+20581896/3fc7e000>
Trace; c011ab90 <process_timeout+0/10>
Trace; e0901afe <pg0+20581afe/3fc7e000>
Trace; c0110ab0 <default_wake_function+0/20>
Trace; c0103f28 <common_interrupt+18/20>
Trace; e0901d17 <pg0+20581d17/3fc7e000>
Trace; e0901800 <pg0+20581800/3fc7e000>
Trace; e08fcd6a <pg0+2057cd6a/3fc7e000>
Trace; c0154315 <sys_ioctl+d5/240>
Trace; c0103d69 <sysenter_past_esp+52/71>

Code;  c029c489 <__sched_text_end+a31/ef2>
00000000 <_EIP>:
Code;  c029c489 <__sched_text_end+a31/ef2>   <=3D=3D=3D=3D=3D
   0:   f3 aa                     repz stos %al,%es:(%edi)   <=3D=3D=3D=3D=
=3D
Code;  c029c48b <__sched_text_end+a33/ef2>
   2:   58                        pop    %eax
Code;  c029c48c <__sched_text_end+a34/ef2>
   3:   59                        pop    %ecx
Code;  c029c48d <__sched_text_end+a35/ef2>
   4:   e9 38 cf f5 ff            jmp    fff5cf41 <_EIP+0xfff5cf41>
Code;  c029c492 <__sched_text_end+a3a/ef2>
   9:   b8 f2 ff ff ff            mov    $0xfffffff2,%eax
Code;  c029c497 <__sched_text_end+a3f/ef2>
   e:   e9 3d 1b f6 ff            jmp    fff61b50 <_EIP+0xfff61b50>
Code;  c029c49c <__sched_text_end+a44/ef2>
  13:   b8 00 00 00 00            mov    $0x0,%eax


[-- Number 3]
Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Unable to handle kernel paging request at virtual address 00005af0
c029b23d
*pde =3D 00000000
Oops: 0002 [#1]
CPU:    0
EIP:    0060:[<c029b23d>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246   (2.6.8-rc3)=20
eax: 00000000   ebx: 00001000   ecx: 00001000   edx: 0819d800
esi: 0819c800   edi: 00005af0   ebp: c15d1de0   esp: d23d4e78
ds: 007b   es: 007b   ss: 0068
Stack: 00000000 00001000 000008b0 8bc4bb92 000008e4 00000000 00005af0 c01f7=
282=20
       00005af0 0819c800 00001000 00001000 e091f360 d2214400 e090d896 00005=
af0=20
       0819c800 00001000 c011b050 c16f6bd0 0b4ff6bc 00000400 00002000 d2214=
400=20
Call Trace:
 [<c01f7282>] copy_from_user+0x42/0x80
 [<e090d896>] snd_pcm_lib_write_transfer+0x96/0xb0 [snd_pcm]
 [<c011b050>] process_timeout+0x0/0x10
 [<e090dafe>] snd_pcm_lib_write1+0x24e/0x3e0 [snd_pcm]
 [<c0110d50>] default_wake_function+0x0/0x20
 [<e090dd17>] snd_pcm_lib_write+0x87/0xa0 [snd_pcm]
 [<e090d800>] snd_pcm_lib_write_transfer+0x0/0xb0 [snd_pcm]
 [<e0908d6a>] snd_pcm_playback_ioctl1+0x29a/0x300 [snd_pcm]
 [<c0155b95>] sys_ioctl+0xd5/0x240
 [<c0103e39>] sysenter_past_esp+0x52/0x71
Code: f3 aa 58 59 e9 84 bf f5 ff b8 f2 ff ff ff e9 09 0b f6 ff b8=20


>>EIP; c029b23d <__sched_text_end+a25/ee6>   <=3D=3D=3D=3D=3D

>>ebp; c15d1de0 <pg0+1253de0/3fc80000>
>>esp; d23d4e78 <pg0+12056e78/3fc80000>

Trace; c01f7282 <copy_from_user+42/80>
Trace; e090d896 <pg0+2058f896/3fc80000>
Trace; c011b050 <process_timeout+0/10>
Trace; e090dafe <pg0+2058fafe/3fc80000>
Trace; c0110d50 <default_wake_function+0/20>
Trace; e090dd17 <pg0+2058fd17/3fc80000>
Trace; e090d800 <pg0+2058f800/3fc80000>
Trace; e0908d6a <pg0+2058ad6a/3fc80000>
Trace; c0155b95 <sys_ioctl+d5/240>
Trace; c0103e39 <sysenter_past_esp+52/71>

Code;  c029b23d <__sched_text_end+a25/ee6>
00000000 <_EIP>:
Code;  c029b23d <__sched_text_end+a25/ee6>   <=3D=3D=3D=3D=3D
   0:   f3 aa                     repz stos %al,%es:(%edi)   <=3D=3D=3D=3D=
=3D
Code;  c029b23f <__sched_text_end+a27/ee6>
   2:   58                        pop    %eax
Code;  c029b240 <__sched_text_end+a28/ee6>
   3:   59                        pop    %ecx
Code;  c029b241 <__sched_text_end+a29/ee6>
   4:   e9 84 bf f5 ff            jmp    fff5bf8d <_EIP+0xfff5bf8d>
Code;  c029b246 <__sched_text_end+a2e/ee6>
   9:   b8 f2 ff ff ff            mov    $0xfffffff2,%eax
Code;  c029b24b <__sched_text_end+a33/ee6>
   e:   e9 09 0b f6 ff            jmp    fff60b1c <_EIP+0xfff60b1c>
Code;  c029b250 <__sched_text_end+a38/ee6>
  13:   b8 00 00 00 00            mov    $0x0,%eax


--=20
 Mika Bostr=F6m      +358-40-525-7347  \-/  "World peace will be achieved
 Bostik@iki.fi    www.iki.fi/bostik   X    when the last man has killed
 Security freak, and proud of it.    /-\   the second-to-last." -anon?

--pWyiEgJYm5f9v55/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBEUt5v829VwOfGI4RApPQAJ9WHH3NWfQnSo/G9pweUt3+18taZgCgu+Eg
VcGKFJiZNh+4U974Iz7Sl5M=
=/1vE
-----END PGP SIGNATURE-----

--pWyiEgJYm5f9v55/--

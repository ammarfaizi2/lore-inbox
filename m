Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130315AbRCBEf4>; Thu, 1 Mar 2001 23:35:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130320AbRCBEfs>; Thu, 1 Mar 2001 23:35:48 -0500
Received: from toscano.org ([64.50.191.142]:36819 "HELO bubba.toscano.org")
	by vger.kernel.org with SMTP id <S130315AbRCBEfi>;
	Thu, 1 Mar 2001 23:35:38 -0500
Date: Thu, 1 Mar 2001 23:35:32 -0500
From: Pete Toscano <pete.lkml@toscano.org>
To: linux-kernel@vger.kernel.org
Subject: 2.4.2 + SMP + EMU10k1 == lock?
Message-ID: <20010301233532.A1748@bubba.toscano.org>
Mail-Followup-To: Pete Toscano <pete.lkml@toscano.org>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="5vNYLRcllDrimb99"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Unexpected: The Spanish Inquisition
X-Uptime: 11:30pm  up 9 min,  3 users,  load average: 0.33, 0.29, 0.15
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

I asked here about a week ago for help with debugging a random lock I've
been experiencing.  With the help of Mr. Owens, I seem to have gotten a
bit further.  (Long winded way of saying, "Sorry about the messy
looking, clueless debugging.")

I'm running 2.4.2 + KDB 1.8 on my SMP machine (2xp3-600).  I have a
serial console connected to my box.  It looks like things might be
locking up in the EMU10k1 driver.  Anyone else?  Is there any further
info I can provide to someone who might be working on this?

Thanks,
pete

[0]kdb> rd
eax =3D 0xc983cca0 ebx =3D 0x00000000 ecx =3D 0xc02c8794 edx =3D 0xffffffff=
=20
esi =3D 0x00003296 edi =3D 0x00000000 esp =3D 0xc028bf34 eip =3D 0xe08ac8bd=
=20
ebp =3D 0xc028bf40 xss =3D 0x00000018 xcs =3D 0x00000010 eflags =3D 0x00013=
096=20
xds =3D 0xffff0018 xes =3D 0x00000018 origeax =3D 0xffffffff &regs =3D 0xc0=
28bf00
[0]kdb> bt
    EBP       EIP         Function(args)
0xc028bf40 0xe08ac8bd [emu10k1]emu10k1_waveout_bh+0x11 (0xc983cca0, 0x1, 0x=
c02c7680)
                               emu10k1 .text 0xe08aa060 0xe08ac8ac 0xe08ac9=
50
0xc028bf58 0xc011bd6b tasklet_hi_action+0x4f (0xc02c7680, 0x0, 0xc02be800)
                               kernel .text 0xc0100000 0xc011bd1c 0xc011bda4
0xc028bf78 0xc011bbfd do_softirq+0x5d (0xc01071d0, 0xc028a000)
                               kernel .text 0xc0100000 0xc011bba0 0xc011bc30
0xc028bf94 0xc010b09e do_IRQ+0xda (0xc01071d0, 0x0, 0xc028a000, 0xc028a000,=
 0xc01071d0)
                               kernel .text 0xc0100000 0xc010afc4 0xc010b0b0
           0xc010919c ret_from_intr
                               kernel .text 0xc0100000 0xc010919c 0xc01091bc
Interrupt registers:
eax =3D 0x00000000 ebx =3D 0xc01071d0 ecx =3D 0x00000000 edx =3D 0xc028a000=
=20
esi =3D 0xc028a000 edi =3D 0xc01071d0 esp =3D 0xc028bfd0 eip =3D 0xc01071ff=
=20
ebp =3D 0xc028bfd0 xss =3D 0x00000018 xcs =3D 0x00000010 eflags =3D 0x00003=
246=20
xds =3D 0xc0100018 xes =3D 0xc0280018 origeax =3D 0xffffff00 &regs =3D 0xc0=
28bf9c
           0xc01071ff default_idle+0x2f
                               kernel .text 0xc0100000 0xc01071d0 0xc0107208
0xc028bfe4 0xc0107272 cpu_idle+0x42
                               kernel .text 0xc0100000 0xc0107230 0xc0107288
[0]kdb> rd
eax =3D 0xc983cca0 ebx =3D 0x00000000 ecx =3D 0xc02c8794 edx =3D 0xffffffff=
=20
esi =3D 0x00003296 edi =3D 0x00000000 esp =3D 0xc028bf34 eip =3D 0xe08ac8bd=
=20
ebp =3D 0xc028bf40 xss =3D 0x00000018 xcs =3D 0x00000010 eflags =3D 0x00013=
096=20
xds =3D 0xffff0018 xes =3D 0x00000018 origeax =3D 0xffffffff &regs =3D 0xc0=
28bf00
[0]kdb> bt
    EBP       EIP         Function(args)
0xc028bf40 0xe08ac8bd [emu10k1]emu10k1_waveout_bh+0x11 (0xc983cca0, 0x1, 0x=
c02c7680)
                               emu10k1 .text 0xe08aa060 0xe08ac8ac 0xe08ac9=
50
0xc028bf58 0xc011bd6b tasklet_hi_action+0x4f (0xc02c7680, 0x0, 0xc02be800)
                               kernel .text 0xc0100000 0xc011bd1c 0xc011bda4
0xc028bf78 0xc011bbfd do_softirq+0x5d (0xc01071d0, 0xc028a000)
                               kernel .text 0xc0100000 0xc011bba0 0xc011bc30
0xc028bf94 0xc010b09e do_IRQ+0xda (0xc01071d0, 0x0, 0xc028a000, 0xc028a000,=
 0xc01071d0)
                               kernel .text 0xc0100000 0xc010afc4 0xc010b0b0
           0xc010919c ret_from_intr
                               kernel .text 0xc0100000 0xc010919c 0xc01091bc
Interrupt registers:
eax =3D 0x00000000 ebx =3D 0xc01071d0 ecx =3D 0x00000000 edx =3D 0xc028a000=
=20
esi =3D 0xc028a000 edi =3D 0xc01071d0 esp =3D 0xc028bfd0 eip =3D 0xc01071ff=
=20
ebp =3D 0xc028bfd0 xss =3D 0x00000018 xcs =3D 0x00000010 eflags =3D 0x00003=
246=20
xds =3D 0xc0100018 xes =3D 0xc0280018 origeax =3D 0xffffff00 &regs =3D 0xc0=
28bf9c
           0xc01071ff default_idle+0x2f
                               kernel .text 0xc0100000 0xc01071d0 0xc0107208
0xc028bfe4 0xc0107272 cpu_idle+0x42
                               kernel .text 0xc0100000 0xc0107230 0xc0107288
[0]kdb> bt
    EBP       EIP         Function(args)
0xc028bf40 0xe08ac8bd [emu10k1]emu10k1_waveout_bh+0x11 (0xc983cca0, 0x1, 0x=
c02c7680)
                               emu10k1 .text 0xe08aa060 0xe08ac8ac 0xe08ac9=
50
0xc028bf58 0xc011bd6b tasklet_hi_action+0x4f (0xc02c7680, 0x0, 0xc02be800)
                               kernel .text 0xc0100000 0xc011bd1c 0xc011bda4
0xc028bf78 0xc011bbfd do_softirq+0x5d (0xc01071d0, 0xc028a000)
                               kernel .text 0xc0100000 0xc011bba0 0xc011bc30
0xc028bf94 0xc010b09e do_IRQ+0xda (0xc01071d0, 0x0, 0xc028a000, 0xc028a000,=
 0xc01071d0)
                               kernel .text 0xc0100000 0xc010afc4 0xc010b0b0
           0xc010919c ret_from_intr
                               kernel .text 0xc0100000 0xc010919c 0xc01091bc
Interrupt registers:
eax =3D 0x00000000 ebx =3D 0xc01071d0 ecx =3D 0x00000000 edx =3D 0xc028a000=
=20
esi =3D 0xc028a000 edi =3D 0xc01071d0 esp =3D 0xc028bfd0 eip =3D 0xc01071ff=
=20
ebp =3D 0xc028bfd0 xss =3D 0x00000018 xcs =3D 0x00000010 eflags =3D 0x00003=
246=20
xds =3D 0xc0100018 xes =3D 0xc0280018 origeax =3D 0xffffff00 &regs =3D 0xc0=
28bf9c
           0xc01071ff default_idle+0x2f
                               kernel .text 0xc0100000 0xc01071d0 0xc0107208
0xc028bfe4 0xc0107272 cpu_idle+0x42
                               kernel .text 0xc0100000 0xc0107230 0xc0107288
[0]kdb> id 0xe08ac8bd
0xe08ac8bd emu10k1_waveout_bh+0x11lock decb 0x17c(%ebx)
0xe08ac8c4 emu10k1_waveout_bh+0x18js     0xe08b31a6 .text.lock+0x280
0xe08ac8ca emu10k1_waveout_bh+0x1etestb  $0x2,(%ebx)
0xe08ac8cd emu10k1_waveout_bh+0x21jne    0xe08ac8e0 emu10k1_waveout_bh+0x34
0xe08ac8cf emu10k1_waveout_bh+0x23movb   $0x1,0x17c(%ebx)
0xe08ac8d6 emu10k1_waveout_bh+0x2apush   %esi
0xe08ac8d7 emu10k1_waveout_bh+0x2bpopf  =20
0xe08ac8d8 emu10k1_waveout_bh+0x2cjmp    0xe08ac940 emu10k1_waveout_bh+0x94
0xe08ac8da emu10k1_waveout_bh+0x2elea    0x0(%esi),%esi
0xe08ac8e0 emu10k1_waveout_bh+0x34push   %ebx
0xe08ac8e1 emu10k1_waveout_bh+0x35call   0xe08ae7e4 emu10k1_waveout_update
0xe08ac8e6 emu10k1_waveout_bh+0x3alea    0xfffffffc(%ebp),%eax
0xe08ac8e9 emu10k1_waveout_bh+0x3dpush   %eax
0xe08ac8ea emu10k1_waveout_bh+0x3epush   %ebx
0xe08ac8eb emu10k1_waveout_bh+0x3fcall   0xe08ae438 emu10k1_waveout_getxfer=
size
0xe08ac8f0 emu10k1_waveout_bh+0x44add    $0xc,%esp
[0]kdb> id 0xe08ac89d
0xe08ac89d emu10k1_wavein_bh+0x7dmov    0xf4658ddf(%esi),%eax
0xe08ac8a3 emu10k1_wavein_bh+0x83pop    %ebx
0xe08ac8a4 emu10k1_wavein_bh+0x84pop    %esi
0xe08ac8a5 emu10k1_wavein_bh+0x85mov    %ebp,%esp
0xe08ac8a7 emu10k1_wavein_bh+0x87pop    %ebp
0xe08ac8a8 emu10k1_wavein_bh+0x88ret   =20
0xe08ac8a9 emu10k1_wavein_bh+0x89lea    0x0(%esi),%esi
0xe08ac8ac emu10k1_waveout_bhpush   %ebp
0xe08ac8ad emu10k1_waveout_bh+0x1mov    %esp,%ebp
0xe08ac8af emu10k1_waveout_bh+0x3sub    $0x4,%esp
0xe08ac8b2 emu10k1_waveout_bh+0x6push   %esi
0xe08ac8b3 emu10k1_waveout_bh+0x7push   %ebx
0xe08ac8b4 emu10k1_waveout_bh+0x8mov    0x8(%ebp),%eax
0xe08ac8b7 emu10k1_waveout_bh+0xbmov    0x8(%eax),%ebx
0xe08ac8ba emu10k1_waveout_bh+0xepushf =20
0xe08ac8bb emu10k1_waveout_bh+0xfpop    %esi
[0]kdb> id 0xe08ac8bc
0xe08ac8bc emu10k1_waveout_bh+0x10cli   =20
0xe08ac8bd emu10k1_waveout_bh+0x11lock decb 0x17c(%ebx)
0xe08ac8c4 emu10k1_waveout_bh+0x18js     0xe08b31a6 .text.lock+0x280
0xe08ac8ca emu10k1_waveout_bh+0x1etestb  $0x2,(%ebx)
0xe08ac8cd emu10k1_waveout_bh+0x21jne    0xe08ac8e0 emu10k1_waveout_bh+0x34
0xe08ac8cf emu10k1_waveout_bh+0x23movb   $0x1,0x17c(%ebx)
0xe08ac8d6 emu10k1_waveout_bh+0x2apush   %esi
0xe08ac8d7 emu10k1_waveout_bh+0x2bpopf  =20
0xe08ac8d8 emu10k1_waveout_bh+0x2cjmp    0xe08ac940 emu10k1_waveout_bh+0x94
0xe08ac8da emu10k1_waveout_bh+0x2elea    0x0(%esi),%esi
0xe08ac8e0 emu10k1_waveout_bh+0x34push   %ebx
0xe08ac8e1 emu10k1_waveout_bh+0x35call   0xe08ae7e4 emu10k1_waveout_update
0xe08ac8e6 emu10k1_waveout_bh+0x3alea    0xfffffffc(%ebp),%eax
0xe08ac8e9 emu10k1_waveout_bh+0x3dpush   %eax
0xe08ac8ea emu10k1_waveout_bh+0x3epush   %ebx
0xe08ac8eb emu10k1_waveout_bh+0x3fcall   0xe08ae438 emu10k1_waveout_getxfer=
size
[0]kdb> rd
eax =3D 0xc983cca0 ebx =3D 0x00000000 ecx =3D 0xc02c8794 edx =3D 0xffffffff=
=20
esi =3D 0x00003296 edi =3D 0x00000000 esp =3D 0xc028bf34 eip =3D 0xe08ac8bd=
=20
ebp =3D 0xc028bf40 xss =3D 0x00000018 xcs =3D 0x00000010 eflags =3D 0x00013=
096=20
xds =3D 0xffff0018 xes =3D 0x00000018 origeax =3D 0xffffffff &regs =3D 0xc0=
28bf00
[0]kdb>=20

--5vNYLRcllDrimb99
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6nyMUsMikd2rK89sRAtaOAJ9YVY03naudanVZt/2+z4WcHCzLfgCfXmOU
kgb96Ciq50vYEVYD/U76tL0=
=K73m
-----END PGP SIGNATURE-----

--5vNYLRcllDrimb99--

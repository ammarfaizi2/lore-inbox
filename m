Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285331AbRLSPrj>; Wed, 19 Dec 2001 10:47:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285336AbRLSPra>; Wed, 19 Dec 2001 10:47:30 -0500
Received: from 213-96-125-217.uc.nombres.ttd.es ([213.96.125.217]:43136 "EHLO
	matrix.jaimedelamo.eu.org") by vger.kernel.org with ESMTP
	id <S285331AbRLSPrV>; Wed, 19 Dec 2001 10:47:21 -0500
Date: Wed, 19 Dec 2001 16:47:17 +0100
To: linux-kernel@vger.kernel.org
Subject: kjournald tries to access beyond raid device
Message-ID: <20011219154717.GA646@jaimedelamo.eu.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2B/JsCI69OhZNC5r"
Content-Disposition: inline
User-Agent: Mutt/1.3.24i
From: Jose Carlos Garcia Sogo <jose@jaimedelamo.eu.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--2B/JsCI69OhZNC5r
Content-Type: multipart/mixed; boundary="AhhlLboLdkugWU4S"
Content-Disposition: inline


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


  Hello!

   I'm suffering some problems last two days with (seems ext3)
   It happens both for 2.4.16 and 2.4.15 (I have not checked yet what
  happens with 2.4.17).

   The log I get is attached below, but seems that kjournald is trying
  to access beyond the device limits. This makes all access to that
  device impossible (even trying to umount it) and I have to reboot=20
  the system. After that, the journal is played and all seems fine.=20
  But after a while the error appears again. It seems that it has nothing
  to do with an concrete event, but some process trying to write
  something to disk (usually exim/procmail)

   The device that fails is a software RAID 5 device (/dev/md3) with
  three SCSI hard disks attached to an adaptec UW controller 19160.

   I have another 3 raid devices (RAID 5 and RAID 0 levels), which have
  not suffered any problem at the moment. I have also other RAID 0
  device with reiserfs.

   Anyway, currently I have returned to ext2 in all my devices for
  safety (this is a production server)
 =20
   The modules I have loaded are:
    Module                  Size  Used by    Not tainted
    ipt_MASQUERADE          1248   1  (autoclean)
    iptable_nat            12884   0  (autoclean) [ipt_MASQUERADE]
    ip_conntrack           13324   1  (autoclean) [ipt_MASQUERADE
    iptable_nat]
    ip_tables              10560   4  [ipt_MASQUERADE iptable_nat]
    nfsd                   66624   8  (autoclean)
    lockd                  48288   1  (autoclean) [nfsd]
    sunrpc                 59604   1  (autoclean) [nfsd lockd]
    reiserfs              148448   1  (autoclean)
    ne2k-pci                5056   1
    8390                    6016   0  [ne2k-pci]
    3c59x                  24968   1

   I also can send you my configure file if you need it.
   Also, if you need any other info, please e-mail me. I have the
   SysRQ+T and the SysRQ+P log just after the failure.

     Thank you

     Jos=E9 Carlos Garc=EDa Sogo
     jsogo@jaimedelamo.eu.org

--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=kjournald_failure

Dec 19 16:03:54 matrix kernel: attempt to access beyond end of device
Dec 19 16:03:54 matrix kernel: 09:03: rw=1, want=1625616132, limit=10249216
Dec 19 16:03:54 matrix kernel: attempt to access beyond end of device
Dec 19 16:03:54 matrix kernel: 09:03: rw=1, want=134217732, limit=10249216
Dec 19 16:03:54 matrix kernel: Assertion failure in __journal_remove_journal_hea
d() at journal.c:1668: "buffer_jbd(bh)"
Dec 19 16:03:54 matrix kernel: invalid operand: 0000
Dec 19 16:03:54 matrix kernel: CPU:    0
Dec 19 16:03:54 matrix kernel: EIP:    0010:[__journal_remove_journal_head+125/2
24]    Not tainted
Dec 19 16:03:54 matrix kernel: EFLAGS: 00010282
Dec 19 16:03:54 matrix kernel: eax: 0000005c   ebx: d0acbc90   ecx: dea9a000   e
dx: 00000001
Dec 19 16:03:54 matrix kernel: esi: ce1c49c0   edi: ddd51540   ebp: 0000000a   e
sp: df18be64
Dec 19 16:03:54 matrix kernel: ds: 0018   es: 0018   ss: 0018
Dec 19 16:03:54 matrix kernel: Process kjournald (pid: 122, stackpage=df18b000)
Dec 19 16:03:54 matrix kernel: Stack: c0222b20 c02232ef c0222af1 00000684 c02233
0d ce1c49c0 d0acbc90 c015cb5c
Dec 19 16:03:54 matrix kernel:        ce1c49c0 ce1c49c0 c0159515 d0acbc90 de9942
50 de994200 de994200 00000000
Dec 19 16:03:54 matrix kernel:        de994294 de994250 00000000 00000fdc ce78d0
24 d5db7930 00000000 00000000
Dec 19 16:03:54 matrix kernel: Call Trace: [journal_unlock_journal_head+76/96] [journal_commit_transaction+1877/3408] [schedule+704/752] [kjournald+267/416] [co
mmit_timeout+0/16]
Dec 19 16:03:54 matrix kernel:    [kernel_thread+40/64]
Dec 19 16:03:54 matrix kernel:
Dec 19 16:03:54 matrix kernel: Code: 0f 0b 83 c4 14 39 33 74 2a 68 1c 33 22 c0 6
8 85 06 00 00 68

--AhhlLboLdkugWU4S--

--2B/JsCI69OhZNC5r
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8ILaFS+BYJZB4jhERArFuAJ94Z/9cph1dYJ/3kVqGWGSF+rNlJQCdE1VZ
hfgS8ugMTWc23FFZRY1fH00=
=tcfy
-----END PGP SIGNATURE-----

--2B/JsCI69OhZNC5r--

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131182AbRCKBAU>; Sat, 10 Mar 2001 20:00:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131183AbRCKBAK>; Sat, 10 Mar 2001 20:00:10 -0500
Received: from toscano.org ([64.50.191.142]:40950 "HELO bubba.toscano.org")
	by vger.kernel.org with SMTP id <S131182AbRCKA77>;
	Sat, 10 Mar 2001 19:59:59 -0500
Date: Sat, 10 Mar 2001 19:59:17 -0500
From: Pete Toscano <pete.lkml@toscano.org>
To: linux-kernel@vger.kernel.org
Subject: 2.4.2 Lockup in SCSI Error Handler
Message-ID: <20010310195917.A1350@bubba.toscano.org>
Mail-Followup-To: Pete Toscano <pete.lkml@toscano.org>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="u3/rZRmxL6MmkK24"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Unexpected: The Spanish Inquisition
X-Uptime: 7:53pm  up 20 min,  3 users,  load average: 0.31, 0.22, 0.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

I'm running 2.4.2 with KDB patch on an SMP system.  I have an Adaptec
2940 SCSI card that my CD burner is connected to.  When this happened, I
was not using the CD at all.  This is on a Tyan Tiger 133 motherboard
(with the Via Apollo Pro 133a chipset).  I'm running with "noapic" due
to the Via PCI IRQ routing problem, so that I can use USB devices.

I'm not very good with debuggers or hunting down kernel bugs, so I
apologize in advance.  Here's what I found:

Stack traceback for pid 448
    EBP       EIP         Function(args)
0xe68f1f6c 0xc011524a schedule+0x41e (0xe76021c0, 0xe68f0000)
                               kernel .text 0xc0100000 0xc0114e2c 0xc0115460
0xe68f1f9c 0xc0107bb8 __down_interruptible+0x94
                               kernel .text 0xc0100000 0xc0107b24 0xc0107c24
0xe68f1fac 0xc0107c96 __down_failed_interruptible+0xa (0x100, 0xe694dd14, 0=
xe694dd6c, 0xe68f1fd8, 0x0)
                               kernel .text 0xc0100000 0xc0107c8c 0xc0107c9c
           0xe8f4edbf [scsi_mod].text.lock+0x1fb
                               scsi_mod .text.lock 0xe8f4ebc4 0xe8f4ebc4 0x=
e8f4eee8
0xe68f1fec 0xe8f4a2bf [scsi_mod]scsi_error_handler+0x107
                               scsi_mod .text 0xe8f45060 0xe8f4a1b8 0xe8f4a=
330
           0xc0107547 kernel_thread+0x23
                               kernel .text 0xc0100000 0xc0107524 0xc010755c
[0]kdb> id 0xe8f4eba0
0xe8f4eba0 scan_scsis_single+0x594cmp    $0x1,%dl
0xe8f4eba3 scan_scsis_single+0x597jne    0xe8f4ebaf scan_scsis_single+0x5a3
0xe8f4eba5 scan_scsis_single+0x599testb  $0xf,0x3(%eax)
0xe8f4eba9 scan_scsis_single+0x59dje     0xe8f4e6f5 scan_scsis_single+0xe9
0xe8f4ebaf scan_scsis_single+0x5a3mov    $0x1,%eax
0xe8f4ebb4 scan_scsis_single+0x5a8lea    0xffffff68(%ebp),%esp
0xe8f4ebba scan_scsis_single+0x5aepop    %ebx
0xe8f4ebbb scan_scsis_single+0x5afpop    %esi
0xe8f4ebbc scan_scsis_single+0x5b0pop    %edi
0xe8f4ebbd scan_scsis_single+0x5b1mov    %ebp,%esp
0xe8f4ebbf scan_scsis_single+0x5b3pop    %ebp
0xe8f4ebc0 scan_scsis_single+0x5b4ret   =20
0xe8f4ebc1 scan_scsis_single+0x5b5nop   =20
0xe8f4ebc2 scan_scsis_single+0x5b6nop   =20
0xe8f4ebc3 scan_scsis_single+0x5b7nop   =20
0xe8f4ebc4 .text.lockcall   0xc0107cac __up_wakeup
[0]kdb> id 0xe8f4ebb0
0xe8f4ebb0 scan_scsis_single+0x5a4add    %eax,(%eax)
0xe8f4ebb2 scan_scsis_single+0x5a6add    %al,(%eax)
0xe8f4ebb4 scan_scsis_single+0x5a8lea    0xffffff68(%ebp),%esp
0xe8f4ebba scan_scsis_single+0x5aepop    %ebx
0xe8f4ebbb scan_scsis_single+0x5afpop    %esi
0xe8f4ebbc scan_scsis_single+0x5b0pop    %edi
0xe8f4ebbd scan_scsis_single+0x5b1mov    %ebp,%esp
0xe8f4ebbf scan_scsis_single+0x5b3pop    %ebp
0xe8f4ebc0 scan_scsis_single+0x5b4ret   =20
0xe8f4ebc1 scan_scsis_single+0x5b5nop   =20
0xe8f4ebc2 scan_scsis_single+0x5b6nop   =20
0xe8f4ebc3 scan_scsis_single+0x5b7nop   =20
0xe8f4ebc4 .text.lockcall   0xc0107cac __up_wakeup
0xe8f4ebc9 .text.lock+0x5jmp    0xe8f450ae scsi_wait_done+0x22
0xe8f4ebce .text.lock+0xacmpb   $0x0,0xe8f58af4
0xe8f4ebd5 .text.lock+0x11repz nop=20
[0]kdb> id 0xe8f4edbf
0xe8f4edbf .text.lock+0x1fbjmp    0xe8f4a2bf scsi_error_handler+0x107
0xe8f4edc4 .text.lock+0x200call   0xc0107cac __up_wakeup
0xe8f4edc9 .text.lock+0x205jmp    0xe8f4a320 scsi_error_handler+0x168
0xe8f4edce .text.lock+0x20acmpb   $0x0,0xc027d140
0xe8f4edd5 .text.lock+0x211repz nop=20
0xe8f4edd7 .text.lock+0x213jle    0xe8f4edce .text.lock+0x20a
0xe8f4edd9 .text.lock+0x215jmp    0xe8f4a33b scsi_old_times_out+0xb
0xe8f4edde .text.lock+0x21acmpb   $0x0,0xc027d140
0xe8f4ede5 .text.lock+0x221repz nop=20
0xe8f4ede7 .text.lock+0x223jle    0xe8f4edde .text.lock+0x21a
0xe8f4ede9 .text.lock+0x225jmp    0xe8f4a4d1 scsi_old_times_out+0x1a1
0xe8f4edee .text.lock+0x22acmpb   $0x0,0xc027d140
0xe8f4edf5 .text.lock+0x231repz nop=20
0xe8f4edf7 .text.lock+0x233jle    0xe8f4edee .text.lock+0x22a
0xe8f4edf9 .text.lock+0x235jmp    0xe8f4aa71 scsi_old_done+0x501
0xe8f4edfe .text.lock+0x23acmpb   $0x0,0xc027d140


Is this a known problem that's been fixed in the AC or test line?  Is
there any more information I can provide about my system?  Any tips on
better information to grab next time something like this happens? =20

Thanks,
pete

--u3/rZRmxL6MmkK24
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6qs3lsMikd2rK89sRAni1AJ9C/DB6M2sJgCfqERTa//+hI06iPACfSr6g
XDRmXYgnz65lwX7RJDI/kn4=
=Ko4w
-----END PGP SIGNATURE-----

--u3/rZRmxL6MmkK24--

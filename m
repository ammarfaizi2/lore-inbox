Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290155AbSAQTFX>; Thu, 17 Jan 2002 14:05:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290156AbSAQTFE>; Thu, 17 Jan 2002 14:05:04 -0500
Received: from smtpsrv0.isis.unc.edu ([152.2.1.139]:17305 "EHLO
	smtpsrv0.isis.unc.edu") by vger.kernel.org with ESMTP
	id <S290155AbSAQTEw>; Thu, 17 Jan 2002 14:04:52 -0500
Date: Thu, 17 Jan 2002 14:04:49 -0500
To: Lawrence Walton <lawrence@the-penguin.otak.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: DEVFS broken?
Message-ID: <20020117190449.GA2860@opeth.ath.cx>
In-Reply-To: <20020117171229.GA1084@the-penguin.otak.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0F1p//8PRICkK4MW"
Content-Disposition: inline
In-Reply-To: <20020117171229.GA1084@the-penguin.otak.com>
User-Agent: Mutt/1.3.25i
From: Dan Chen <crimsun@email.unc.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Also using Debian sid here (devfsd 1.3.21-1). Over the past two days
I've seen random nasties with devfs-v199.6 and v199.7 (I backed out
v199.7 in my local tree because my machine refuses to finish booting
otherwise). Machine: VIA VT82C693A/694x, PIII/1GHz SMP, 1GB HIGHMEM
enabled.

What follows is a series of crashes culled from /var/log/kern.log
(apologies regarding the format). Before each I'll explain what I did to
possibly invoke it. All are with devfs-v199.6 and devfsd-1.3.21 running
2.4.18-pre4 + ext3-2.4-0.9.17-2418p3 + ide.2.4.16.12102001:

# modprobe aic7xxx   //I tried to start an Eterm in X 4.1.0.1 afterward
-- snip --
Jan 16 22:54:50 opeth kernel: invalid operand: 0000
Jan 16 22:54:50 opeth kernel: CPU:    0
Jan 16 22:54:50 opeth kernel: EIP:    0010:[d_instantiate+17/68]
Tainted: P=20
Jan 16 22:54:50 opeth kernel: EFLAGS: 00010202
Jan 16 22:54:50 opeth kernel: eax: 5a5a5a00   ebx: f6b5f560   ecx:
f7aa1b80   ed
x: f6b5f590
Jan 16 22:54:50 opeth kernel: esi: f7aa1b80   edi: f6b5f560   ebp:
f7a7f840   es
p: f7a41f18
Jan 16 22:54:50 opeth kernel: ds: 0018   es: 0018   ss: 0018
Jan 16 22:54:50 opeth kernel: Process devfsd (pid: 26,
stackpage=3Df7a41000)
Jan 16 22:54:50 opeth kernel: Stack: f77d9460 c0179b13 f6b5f560 f7aa1b80
f6b5f56
0 00000000 f7a41fa4 f7a83620=20
Jan 16 22:54:50 opeth kernel:        c01409be f6b5f560 00000000 f7a41f74
c014118
1 f7a83620 f7a41f74 00000000=20
Jan 16 22:54:50 opeth kernel:        f60d4000 00000000 f7a41fa4 00000009
0000000
9 f60d4005 00000000 f60d4004=20
Jan 16 22:54:50 opeth kernel: Call Trace:
[devfs_d_revalidate_wait+231/276] [cac
hed_lookup+46/84] [link_path_walk+1409/2016] [path_walk+26/28]
[__user_walk+53/8
0]=20
Jan 16 22:54:50 opeth kernel:    [sys_stat64+25/112] [sys_read+188/196]
[system_
call+51/56]=20
Jan 16 22:54:50 opeth kernel:=20
Jan 16 22:54:50 opeth kernel: Code: 0f 0b f0 fe 0d a0 66 2d c0 0f 88 43
09 00 00
 85 c9 74 12 8b=20
 Jan 16 23:09:25 opeth kernel:  <7>VFS: Disk change detected on device
 ide1(22,0)
 Jan 16 23:55:23 opeth kernel: scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI
 HBA DRIV
 ER, Rev 6.2.4
 Jan 16 23:55:23 opeth kernel:         <Adaptec aic7860 Ultra SCSI
 adapter>
 Jan 16 23:55:23 opeth kernel:         aic7860: Ultra Single Channel A,
 SCSI Id=3D7
 , 3/253 SCBs
 Jan 16 23:55:23 opeth kernel:=20
 Jan 16 23:55:39 opeth kernel:   Vendor: PLEXTOR   Model: CD-ROM PX-40TS
 Rev:=20
 1.04
 Jan 16 23:55:39 opeth kernel:   Type:   CD-ROM
 ANSI=20
 SCSI revision: 02
 Jan 16 23:55:39 opeth kernel: Attached scsi CD-ROM sr0 at scsi0,
 channel 0, id 3
 , lun 0
 Jan 16 23:55:39 opeth kernel: (scsi0:A:3): 20.000MB/s transfers
 (20.000MHz, offs
 et 15)
 Jan 16 23:55:39 opeth kernel: sr0: scsi-1 drive
 Jan 16 23:59:45 opeth kernel: invalid operand: 0000
 Jan 16 23:59:45 opeth kernel: CPU:    1
 Jan 16 23:59:45 opeth kernel: EIP:    0010:[d_instantiate+17/68]
 Tainted: P =20
 Jan 16 23:59:45 opeth kernel: EFLAGS: 00010202
 Jan 16 23:59:45 opeth kernel: eax: 5a5a5a00   ebx: e7304660   ecx:
 e8d92e00   ed
 x: e7304690
 Jan 16 23:59:45 opeth kernel: esi: f742f520   edi: f7ea9140   ebp:
 e7304660   es
 p: ea08deb4
 Jan 16 23:59:45 opeth kernel: ds: 0018   es: 0018   ss: 0018
 Jan 16 23:59:45 opeth kernel: Process Eterm (pid: 4924,
 stackpage=3Dea08d000)
 Jan 16 23:59:45 opeth kernel: Stack: e8d92e00 c0179d4e e7304660
 e8d92e00 fffffff
 4 f7a7f840 ea08c000 e7304660=20
 Jan 16 23:59:45 opeth kernel:        f7ea914c c0287c80 f3b1b600
 c0126938 f6fddb6
 0 f3b1b600 4038dc00 00000000=20
 Jan 16 23:59:45 opeth kernel:        00000246 00000000 f7a7f840
 f7a7f8a8 f7a8362
 0 00000246 c0149613 c200f288=20
 Jan 16 23:59:45 opeth kernel: Call Trace: [devfs_lookup+526/600]
 [handle_mm_faul
 t+92/184] [d_alloc+27/376] [real_lookup+122/264]
 [link_path_walk+1431/2016]=20
 Jan 16 23:59:45 opeth kernel:    [path_walk+26/28] [__user_walk+53/80]
 [sys_stat
 64+25/112] [sys_ioctl+490/497] [system_call+51/56]=20
 Jan 16 23:59:45 opeth kernel:=20
 Jan 16 23:59:45 opeth kernel: Code: 0f 0b f0 fe 0d a0 66 2d c0 0f 88 43
 09 00 00
  85 c9 74 12 8b=20
-- snip --

//this one occurred during boot
-- snip --
Jan 17 00:07:47 opeth kernel: invalid operand: 0000
Jan 17 00:07:47 opeth kernel: CPU:    0
Jan 17 00:07:47 opeth kernel: EIP:    0010:[d_instantiate+17/68]
Tainted: P=20
Jan 17 00:07:47 opeth kernel: EFLAGS: 00010287
Jan 17 00:07:47 opeth kernel: eax: 5a5a5a00   ebx: f7228540   ecx:
f7215060   ed
x: f7228570
Jan 17 00:07:47 opeth kernel: esi: f7215060   edi: f7228540   ebp:
f7a810c0   es
p: f7a41f18
Jan 17 00:07:47 opeth kernel: ds: 0018   es: 0018   ss: 0018
Jan 17 00:07:47 opeth kernel: Process devfsd (pid: 26,
stackpage=3Df7a41000)
Jan 17 00:07:47 opeth kernel: Stack: f7252940 c0179b13 f7228540 f7215060
f722854
0 00000000 f7a41fa4 f7a82a20=20
Jan 17 00:07:47 opeth kernel:        c01409be f7228540 00000000 f7a41f74
c014118
1 f7a82a20 f7a41f74 00000000=20
Jan 17 00:07:47 opeth kernel:        f7854000 00000000 f7a41fa4 00000009
0000000
9 f7854005 00000000 f7854004=20
Jan 17 00:07:47 opeth kernel: Call Trace:
[devfs_d_revalidate_wait+231/276] [cac
hed_lookup+46/84] [link_path_walk+1409/2016] [path_walk+26/28]
[__user_walk+53/8
0]=20
Jan 17 00:07:47 opeth kernel:    [sys_stat64+25/112] [sys_read+188/196]
[system_
call+51/56]=20
Jan 17 00:07:47 opeth kernel:=20
Jan 17 00:07:47 opeth kernel: Code: 0f 0b f0 fe 0d a0 66 2d c0 0f 88 43
09 00 00 85 c9 74 12 8b
-- snip --

Interestingly enough, I applied rml's preempt-kernel-rml-2.4.18-pre4-1,
recompiled, rebooted, and have yet to see an oops, though I believe it's
just dumb luck thus far. Any ideas?

On Thu, Jan 17, 2002 at 09:12:29AM -0800, Lawrence Walton wrote:
> I am not sure how to debug this but it apears that=20
> in 2.5.3-pre1 and in 2.5.2-dj1 DEVFS is not working.
> It started by terminals hanging and not being able to
> shutdown.
> I went to /dev/ and did a ls, it compleatly hangs that
> terminal and I cannot kill ls.
> I have the devfsd version from debian 1.3.21 .

--=20
Dan Chen                 crimsun@email.unc.edu
GPG key:   www.unc.edu/~crimsun/pubkey.gpg.asc

--0F1p//8PRICkK4MW
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8RyBRMwVVFhIHlU4RAp+bAJwNAsdBGF5s73RQ0DugOXKVo5huQwCdEi3V
QRLkQ2ehiLLpw9kup7tSIYs=
=frfG
-----END PGP SIGNATURE-----

--0F1p//8PRICkK4MW--

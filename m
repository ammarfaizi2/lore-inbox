Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264795AbSLBErq>; Sun, 1 Dec 2002 23:47:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264797AbSLBErq>; Sun, 1 Dec 2002 23:47:46 -0500
Received: from 182-121-ADSL.red.retevision.es ([80.224.121.182]:41923 "EHLO
	jerry.marcet.dyndns.org") by vger.kernel.org with ESMTP
	id <S264795AbSLBErp>; Sun, 1 Dec 2002 23:47:45 -0500
Date: Mon, 2 Dec 2002 05:55:12 +0100
From: Javier Marcet <jmarcet@pobox.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Nuno Monteiro <nuno@itsari.org>, linux-kernel@vger.kernel.org,
       andrew@sol-1.demon.co.uk, jamagallon@able.es, khromy@lnuxlab.ath.cx,
       conman@kolivas.net
Subject: Re: Exaggerated swap usage
Message-ID: <20021202045512.GA2479@jerry.marcet.dyndns.org>
References: <20021201143713.GA871@hobbes.itsari.int> <20021202002108.GQ28164@dualathlon.random>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ReaqsoxgOBHFXBhH"
Content-Disposition: inline
In-Reply-To: <20021202002108.GQ28164@dualathlon.random>
X-Editor: Vim http://www.vim.org/
X-Operating-System: Gentoo GNU/Linux 1.4 / 2.4.20-jam0-marcet i686 AMD Athlon(TM) XP 1800+ AuthenticAMD
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Andrea Arcangeli <andrea@suse.de> [021202 01:24]:

>> Pid: 2, comm:              keventd
>> EIP: 0010:[<c0142ae3>] CPU: 0 EFLAGS: 00000206    Not tainted
>> EAX: c10ec45c EBX: 00000033 ECX: c11f8838 EDX: 40000000
>> ESI: c2fed680 EDI: c10ec400 EBP: 00000033 DS: 0018 ES: 0018
>[..]
>> >>EIP; c0142ae3 <try_to_sync_unused_inodes+1f/1f8>   <=3D=3D=3D=3D=3D
=20
>> >>EAX; c10ec45c <_end+e521e4/13c9de8>
>> >>ECX; c11f8838 <_end+f5e5c0/13c9de8>
>> >>ESI; c2fed680 <[sb].data.end+a7ffd/25a9dd>
>> >>EDI; c10ec400 <_end+e52188/13c9de8>
=20
>> Trace; c0117114 <__run_task_queue+4c/60>
>> Trace; c011e0e9 <context_thread+11d/19c>
>> Trace; c010588c <kernel_thread+28/38>

>ok, now it's clear what the problem is. there are inuse-dirty inodes
>that triggers a deadlock in the schedule-capable

>Can you give a spin to this untested incremental fix?

This appears to do the trick. I've tried some tests which always locked
it up before and now it's still rock stable.
It's also the 2.4 kernel which works more smoothly here, under heavy io
et all. Not yet 100% as well as 2.5 but quite near.
Very good work :)

Thanks for fixing the damn bug.


--=20
Javier Marcet <jmarcet@pobox.com>

--ReaqsoxgOBHFXBhH
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iEYEARECAAYFAj3q57AACgkQx/ptJkB7frzDmwCcCtqNW6qVuxAAsiKvh7yES2aG
qscAn0XuXdZ7YMb2GWG8IzZHBrNi7vOa
=gOJr
-----END PGP SIGNATURE-----

--ReaqsoxgOBHFXBhH--

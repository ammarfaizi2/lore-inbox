Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267098AbTAPSHK>; Thu, 16 Jan 2003 13:07:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267131AbTAPSHK>; Thu, 16 Jan 2003 13:07:10 -0500
Received: from wsip-68-96-149-130.no.no.cox.net ([68.96.149.130]:60877 "EHLO
	resonant.org") by vger.kernel.org with ESMTP id <S267098AbTAPSHG>;
	Thu, 16 Jan 2003 13:07:06 -0500
Date: Thu, 16 Jan 2003 12:16:02 -0600
From: Zed Pobre <zed@resonant.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Nervous with 2.4.21-pre3 and -pre3-ac*
Message-ID: <20030116181602.GA3776@resonant.org>
Mail-Followup-To: Zed Pobre <zed@resonant.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030112185500.6157F475C9@bellini.mit.edu> <1042402716.16288.4.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="UlVJffcvxoiEqYs2"
Content-Disposition: inline
In-Reply-To: <1042402716.16288.4.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
X-No-Archive: Yes
X-GPG-Fingerprint: FF 75 8D 70 57 8D A4 7D  3A DE 6D 2F 25 C3 E6 E7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 12, 2003 at 08:18:38PM +0000, Alan Cox wrote:
> On Sun, 2003-01-12 at 18:55, ghugh Song wrote:
> > Many people including me are getting unusual Kernel=20
> > trouble recently with 2.4.21-pre3-ac*. In my case, with=20
> > 2.4.21-pre3-ac2 I got segmentation fault from=20
> > a command (tar) where I never suspected.   Yet no one seems to know=20
> > what part of the the kernel update caused all this=20
> > trouble.
> >=20
> > Does anyone have any guess?
>=20
> At the moment I am not sure. Its stable on my boxes using gcc 3.1 and
> built from make distclean. At least one reporter found a patch and
> build over an old built tree failed but a clean tree did not.
>=20
> The obvious candidates assuming 2.4.21-pre3 is stable are the mm/shmem.c=
=20
> changes (you can back out just the diff to that file and retest which
> would be interesting), or the buffer cache changes which I plan to drop
> out to test soon.

    I am not the original reporter, but I have a similar situation (I
can consistently cause an oops in 2.4.21-pre3-ac2 by attempting to
rsync a few gigabytes of data to that machine, or copy that data from
one partition to another.  It only happens if highmem support is
enabled (the machine in question has 4GB), does not happen in
2.4.21-pre3, and I just tried removing the changes to mm/shmem.c in
the pre3-ac2 diff, recompiled the kernel, and still got the oops.

ksymoops output follows:

ksymoops 2.4.5 on i686 2.4.21-pre3-ac2.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.21-pre3-ac2/ (default)
     -m /boot/System.map-2.4.21-pre3-ac2 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Unable to handle kernel NULL pointer dereference at virtual address 00000004
c01342bd
*pde =3D 00104001
oops: 0002
CPU:    4
EIP:    0010:[<c01342bd>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000000   ebx: c10bc960   ecx: c3a96000   edx: 00000200
esi: 00000002   edi: f704ca00   ebp: 00000000   esp: c3a97d6c
ds: 0018   es: 0018   ss: 0018
Process kupdated (pid: 21, stackpage=3Dc3a97000)
Stack: c3edc000 c3a2e268 f704ca00 00000000 f700a280 00000001 00000000 00000=
001
       00000000 00000004 f700a280 c3f2b020 c03f5080 c01348c8 c01348e9 c0131=
5bf
       c3a2e278 c3a2e174 00000001 c013291f c3a2e268 f704ca00 00000020 00000=
070
Call Trace:    [<c01348c8>] [<c01348e9>] [<c01315bf>] [<c013291f>] [<c0133a=
44>]
  [<c0133aec>] [<c013459e>] [<c0134822>] [<c013453e>] [<c0139b82>] [<c0139c=
ce>]
  [<c01f4a07>] [<c01f506c>] [<c01f50cc>] [<c013cb74>] [<c013cc08>] [<c013fd=
9c>]
  [<c014006a>] [<c01070c4>]
Code: 89 58 04 89 03 8d 51 5c 89 53 04 89 59 5c 89 73 0c ff 41 68


>>EIP; c01342bd <__free_pages_ok+28d/2ac>   <=3D=3D=3D=3D=3D

>>ebx; c10bc960 <_end+c3cadc/38a6c1dc>
>>ecx; c3a96000 <_end+361617c/38a6c1dc>
>>edi; f704ca00 <_end+36bccb7c/38a6c1dc>
>>esp; c3a97d6c <_end+3617ee8/38a6c1dc>

Trace; c01348c8 <__free_pages+1c/20>
Trace; c01348e9 <free_pages+1d/20>
Trace; c01315bf <kmem_slab_destroy+7f/98>
Trace; c013291f <kmem_cache_reap+2c7/338>
Trace; c0133a44 <shrink_caches+1c/88>
Trace; c0133aec <try_to_free_pages_zone+3c/5c>
Trace; c013459e <balance_classzone+5e/1d0>
Trace; c0134822 <__alloc_pages+112/160>
Trace; c013453e <_alloc_pages+16/18>
Trace; c0139b82 <alloc_bounce_page+e/94>
Trace; c0139cce <create_bounce+26/166>
Trace; c01f4a07 <__make_request+af/5f8>
Trace; c01f506c <generic_make_request+11c/12c>
Trace; c01f50cc <submit_bh+50/70>
Trace; c013cb74 <write_locked_buffers+20/2c>
Trace; c013cc08 <write_some_buffers+88/d0>
Trace; c013fd9c <sync_old_buffers+68/a0>
Trace; c014006a <kupdate+102/124>
Trace; c01070c4 <kernel_thread+28/38>

Code;  c01342bd <__free_pages_ok+28d/2ac>
00000000 <_EIP>:
Code;  c01342bd <__free_pages_ok+28d/2ac>   <=3D=3D=3D=3D=3D
   0:   89 58 04                  mov    %ebx,0x4(%eax)   <=3D=3D=3D=3D=3D
Code;  c01342c0 <__free_pages_ok+290/2ac>
   3:   89 03                     mov    %eax,(%ebx)
Code;  c01342c2 <__free_pages_ok+292/2ac>
   5:   8d 51 5c                  lea    0x5c(%ecx),%edx
Code;  c01342c5 <__free_pages_ok+295/2ac>
   8:   89 53 04                  mov    %edx,0x4(%ebx)
Code;  c01342c8 <__free_pages_ok+298/2ac>
   b:   89 59 5c                  mov    %ebx,0x5c(%ecx)
Code;  c01342cb <__free_pages_ok+29b/2ac>
   e:   89 73 0c                  mov    %esi,0xc(%ebx)
Code;  c01342ce <__free_pages_ok+29e/2ac>
  11:   ff 41 68                  incl   0x68(%ecx)


1 warning issued.  Results may not be reliable.


--=20
Zed Pobre <zed@debian.org> a.k.a. Zed Pobre <zed@resonant.org>
PGP key and fingerprint available on finger; encrypted mail welcomed.

--UlVJffcvxoiEqYs2
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iQEVAwUBPib24h0207zoJUw5AQHJvAf+Il7KXUMAHDlIu00IQ34yGMjj4HoQtBC5
eCDJg46vRY6q4JEUHdJNxvxdbtipDDEzvZn5qjqAp3Xgmk8qNGF33GjQvnVOHq6m
MOxpAillfJfiei8rKP2WbDttkpBuepXgYKZEgLhFgKqo7Lt6qf7pf2Wxp1CmHe8q
W6+KGHo3lh8obsq956NwhPp7c7BI6LTwzxPyIwfJGmSKQ44TyEUBuQz83U0cnahA
dR3tWE1kt7n81hSQ8cuN36vjjNnemWfaRfgrgOUwnVdM6GHZ8fu1mrWgJScqBRc6
eAIPcYeFd127aVau9a1xUWpBwQPkSLVliGrBI+aJJM3M+Lt8Xwatlw==
=X12b
-----END PGP SIGNATURE-----

--UlVJffcvxoiEqYs2--

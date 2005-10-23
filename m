Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750833AbVJWXyk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750833AbVJWXyk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Oct 2005 19:54:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750834AbVJWXyk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Oct 2005 19:54:40 -0400
Received: from smtp06.auna.com ([62.81.186.16]:17854 "EHLO smtp06.retemail.es")
	by vger.kernel.org with ESMTP id S1750833AbVJWXyk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Oct 2005 19:54:40 -0400
Date: Mon, 24 Oct 2005 01:57:10 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: jonathan@jonmasters.org
Cc: jonmasters@gmail.com, "Linux-Kernel," <linux-kernel@vger.kernel.org>
Subject: Re: /proc/kcore size incorrect ?
Message-ID: <20051024015710.29a02e63@werewolf.able.es>
In-Reply-To: <35fb2e590510231613u492d24c6k4d65ff3ac5ffcee6@mail.gmail.com>
References: <20051023235806.1a4df9ab@werewolf.able.es>
	<35fb2e590510231613u492d24c6k4d65ff3ac5ffcee6@mail.gmail.com>
X-Mailer: Sylpheed-Claws 1.9.15cvs93 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; boundary=Sig_bcA8r3NW77MfWYizqjq4Ypn;
 protocol="application/pgp-signature"; micalg=PGP-SHA1
X-Auth-Info: Auth:LOGIN IP:[83.138.216.103] Login:jamagallon@able.es Fecha:Mon, 24 Oct 2005 01:54:38 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_bcA8r3NW77MfWYizqjq4Ypn
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 24 Oct 2005 00:13:44 +0100, Jon Masters <jonmasters@gmail.com> wrot=
e:

> On 10/23/05, J.A. Magallon <jamagallon@able.es> wrote:
>=20
> > BTW, any simple method to get the real mem of the box ?
>=20
> This is a typical example of using a hammer to crack a nut aka
> modifying the kernel before giving up on userspace.
>=20

Ejem.

Who talks about modifying anything ?

> Several ways of looking up a solution:
>=20
>     * google

Well, perhaps I buy this, but as this looks like a strange/buggy thing, as
I will explain later...

>     * man -k memory
>=20
> Leading to:
>=20
> * free(1):
>     ``free  displays the total amount of free and used physical and swap''
>=20
> * Or /proc/meminfo (both the same thing) - which you can trivially
> parse using sed:
>=20
> cat /proc/meminfo | sed -n -e "s/^MemTotal:[ ]*\([0-9]*\) kB\$/\1/p"
>=20

Do your homework.

free gives the free amount of memory _available for the user_, ie, the
full memory of the box minus the kernel reserved part.

=46rom dmesg:

BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fee0000 (usable)
 BIOS-e820: 000000003fee0000 - 000000003fee3000 (ACPI NVS)
 BIOS-e820: 000000003fee3000 - 000000003fef0000 (ACPI data)
 BIOS-e820: 000000003fef0000 - 000000003ff00000 (reserved)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
1022MB LOWMEM available.
...
Memory: 1034744k/1047424k available (1858k kernel code, 12208k reserved, 63=
4k da
ta, 184k init, 0k highmem)
werewolf:~> echo $((1047424 / 1024))
1022

werewolf:~> free
             total       used       free     shared    buffers     cached
Mem:       1035012    1000660      34352          0      98348     649284
werewolf:~> cat /proc/meminfo | grep MemTotal
MemTotal:      1035012 kB
werewolf:~> echo $((1035012 / 1024))
1010

So free/proc give the available memory, not the total:
- free: 1010 Mb
- kcore: 1022 Mb

I expected /proc/kcore to give the size of your installed memory, with
the reserved BIOS areas just not accesible, but it looks like it already
has them discounted, so gives 1022 Mb.

It looks really silly to have a motd say "wellcome to this box, it has
2 xeons and 1022 Mb of RAM".



--
J.A. Magallon <jamagallon()able!es>     \               Software is like se=
x:
werewolf!able!es                         \         It's better when it's fr=
ee
Mandriva Linux release 2006.1 (Cooker) for i586
Linux 2.6.13-jam9 (gcc 4.0.1 (4.0.1-5mdk for Mandriva Linux release 2006.0))

--Sig_bcA8r3NW77MfWYizqjq4Ypn
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDXCNWRlIHNEGnKMMRAlvmAJ9/24p1HmAqmURrMZwUiu+m2Z97HgCfd5Ku
2ODHgmaHk9PPT/IKuy73msw=
=tH2Q
-----END PGP SIGNATURE-----

--Sig_bcA8r3NW77MfWYizqjq4Ypn--

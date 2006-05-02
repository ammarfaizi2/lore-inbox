Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932359AbWEBEJX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932359AbWEBEJX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 00:09:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932361AbWEBEJX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 00:09:23 -0400
Received: from h80ad2444.async.vt.edu ([128.173.36.68]:35980 "EHLO
	h80ad2444.async.vt.edu") by vger.kernel.org with ESMTP
	id S932359AbWEBEJW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 00:09:22 -0400
Message-Id: <200605020409.k4249EiJ007414@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Irfan Habib <irfan.habib@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux Kernel and Webservices 
In-Reply-To: Your message of "Tue, 02 May 2006 07:51:18 +0500."
             <3420082f0605011951m43479a98ie56a0a5f62409dd2@mail.gmail.com> 
From: Valdis.Kletnieks@vt.edu
References: <3420082f0605011951m43479a98ie56a0a5f62409dd2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1146542953_2571P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 02 May 2006 00:09:14 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1146542953_2571P
Content-Type: text/plain; charset=us-ascii

On Tue, 02 May 2006 07:51:18 +0500, Irfan Habib said:
> I wanted to know if modulescan be developed in the linux kernel, which
> can create TCP/UDP sockets and communicate with perhaps webservices,
> residing in the user level in the same computer or in some other
> computer.

> Is a networking API available in the linux kernel which can be used by
> linux kernel modules, if so is there any documentation for it?

It's generally considered a Bad Idea, as it's almost certainly easier to
do in userspace.  If you're trying to to instrument a network-based monitoring
system and need access to kernel data, you're *much* better off having the
kernel export the data via netlink or even abuse of /proc or /sys, and then
a small userspace program read the data and ship it over the net.  There's
a *lot* of things that you just won't have access to in kernel space (for
starters, you don't have a DNS resolver, so you can't use hostnames for
configuration).

If you're determined to do this in kernelspace anyhow, see the
linux-2.6-tux.patch in recent RedHat/Fedora kernels, and ask yourself why
that patch has no hope of being accepted upstream (although I have a great
amount of respect for a lot of things that come out of RedHat, *that* patch
is best described  "a fully RFC1925-compliant networking pig, with afterburners")


--==_Exmh_1146542953_2571P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEVttpcC3lWbTT17ARAlwBAJ44B5hFF0kfD3W8mEhvUR405agubACgghCu
cfv5cZjnvwq2i4ilhY1FKgU=
=n2ke
-----END PGP SIGNATURE-----

--==_Exmh_1146542953_2571P--

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263624AbUDUS5S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263624AbUDUS5S (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 14:57:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263621AbUDUS5S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 14:57:18 -0400
Received: from facmail.cc.gettysburg.edu ([138.234.4.150]:6641 "EHLO
	facmail.cc.gettysburg.edu") by vger.kernel.org with ESMTP
	id S263625AbUDUSz1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 14:55:27 -0400
Date: Wed, 21 Apr 2004 14:24:28 -0400
To: linux-kernel@vger.kernel.org
Subject: 2.6.5, 2.6.6-rc2 sluggish interrupts
Message-ID: <20040421182428.GA12822@andromeda>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Justin Pryzby <justinpryzby@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I noticed this first with Linux 2.6.5 (but not with 2.6.2) and also now
with 2.6.6-rc2.  The machine responds very slugishly while excercizing
one interrupt when another interrupt happens.  Ex.  I'm circling the
mouse pointer around the screen, and suddenly the hard drive decides to
`sync`, or some such.  The pointer then freezes for at least a
half-second.  It affects the keyboard too.  (Though, presumably, it
could also be a display issue).  I notice myself losing alot of
keystrokes as a result of this (I don't know what that means about the
problem..)  I don't know enough to say that this is about interrupts,
but take a look:=20

	pryzbyj@andromeda:~$ cat /proc/interrupts=20
		   CPU0      =20
	  0:    3835408          XT-PIC  timer
	  1:       9797          XT-PIC  i8042
	  2:          0          XT-PIC  cascade
	  5:          0          XT-PIC  Maestro3
	  7:          1          XT-PIC  parport0
	  8:          4          XT-PIC  rtc
	  9:          1          XT-PIC  acpi
	 11:     310777          XT-PIC  yenta, yenta, uhci_hcd, eth0, r128@PCI:1:=
0:0
	 12:      10454          XT-PIC  i8042
	 14:      11802          XT-PIC  ide0
	 15:         17          XT-PIC  ide1
	NMI:          0=20
	LOC:          0=20
	ERR:          0
	MIS:          0

I don't recall seeing that r128@PCI:1:0:0 entry there before (I haven't
changed hardware, I've been using the console framebuffer for a while,
AGP, DRM have always been on).  And it seems to be making lots of noise
(though I don't know that that's wrong).  I do know there's a general
problem though - sometimes it feels like I'm using a remote machine when
I'm not.

It feels to me like it always happens when the disk is accessed
(possibly just because I can _hear_ that), and it seems like it happens
when the disk hasn't been used in a while.

Please Cc: me.

Justin

--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAhrxbh7yD3l4ITTYRApVZAJ43ig3LSleEiaKGxB+w0Z9Yy0TkdACfQpso
gX6lsvOE52OAgFRyl96Iq7k=
=21vT
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--

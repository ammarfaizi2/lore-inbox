Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266998AbUAXSZZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 13:25:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266999AbUAXSZZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 13:25:25 -0500
Received: from h80ad2738.async.vt.edu ([128.173.39.56]:47491 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S266998AbUAXSZX (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 13:25:23 -0500
Message-Id: <200401241823.i0OINqme029964@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Felix von Leitner <felix-kernel@fefe.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Request: I/O request recording 
In-Reply-To: Your message of "Sat, 24 Jan 2004 19:10:27 +0100."
             <20040124181026.GA22100@codeblau.de> 
From: Valdis.Kletnieks@vt.edu
References: <20040124181026.GA22100@codeblau.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1898770363P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sat, 24 Jan 2004 13:23:52 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1898770363P
Content-Type: text/plain; charset=us-ascii

On Sat, 24 Jan 2004 19:10:27 +0100, Felix von Leitner <felix-kernel@fefe.de>  said:
> I would like to have a user space program that I could run while I cold
> start KDE.  The program would then record which I/O pages were read in
> which order.  The output of that program could then be used to pre-cache
> all those pages, but in an order that reduces disk head movement.
> Demand Loading unfortunately produces lots of random page I/O scattered
> all over the disk.

The Fedora version of the kernel-utils RPM includes /usr/sbin/readahead, which
gets launched like this:

start() {
    echo -n $"Starting background readahead: "
    /usr/sbin/readahead /usr/share/icons/Bluecurve/48x48/mimetypes/* &
    /usr/sbin/readahead /usr/share/icons/Bluecurve/24x24/stock/* &
    /usr/sbin/readahead /usr/share/applications/* &
    /usr/sbin/readahead `cat /etc/readahead.files` &
}

So given that program, you could simpy strace your KDE stuff, grep out all the
open calls and the filenames, stick them in /etc/readahead.files, and be done.

--==_Exmh_-1898770363P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAErg3cC3lWbTT17ARApesAKDAPeeTecg/9/lH/VzcZITTMjYPxwCeKcYI
bsAXsDRawpICSbfQF1Kf6nc=
=eYi6
-----END PGP SIGNATURE-----

--==_Exmh_-1898770363P--

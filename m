Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264438AbTEJQis (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 12:38:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264442AbTEJQis
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 12:38:48 -0400
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:29167 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S264438AbTEJQiq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 12:38:46 -0400
Subject: Re: The disappearing sys_call_table export.
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Ahmed Masud <masud@googgun.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jesse Pollard <jesse@cats-chateau.net>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       "viro@parcelfarce.linux.theplanet.co.uk" 
	<viro@parcelfarce.linux.theplanet.co.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Terje Eggestad <terje.eggestad@scali.com>
In-Reply-To: <Pine.LNX.4.33.0305100957100.23680-100000@marauder.googgun.com>
References: <Pine.LNX.4.33.0305100957100.23680-100000@marauder.googgun.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-gi6MXystPIu2yI4+K/5M"
Organization: Red Hat, Inc.
Message-Id: <1052585430.1367.6.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 (1.2.4-2) 
Date: 10 May 2003 18:50:31 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-gi6MXystPIu2yI4+K/5M
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2003-05-10 at 16:38, Ahmed Masud wrote:

> Case in point, I wrote a security module for Linux that overrides _all_
> 237 systemcalls to audit and control the use of the system calls on a per
> uid basis.  (i.e. if the user was actually allowed to make the system cal=
l
> or not) and return -EPERM or jump to system call proper.

I'm pretty sure that auditing by your module can easily be avoided.

examle: pseudocode for the unlink syscall

long your_wrapped_syscall(char *userfilename)
{
    char kernelpointer[something];
    copy_from_user(kernelpointer, usefilename, ...);
    audit_log(kernelpointer);
    return original_syscall(userfilename);
}

now.... the original syscall does ANOTHER copy_from_user().
Eg I can easily fool your logging by having a second thread change the
filename between the time your code copies it and the time the original
syscall copies it again. The chances of getting the timing right are 50%
at least (been there done that ;)

The only solution for this is to check/audit/log things after the ONE
copy. Eg not by overriding the syscall but inside the syscall.

--=-gi6MXystPIu2yI4+K/5M
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+vS3WxULwo51rQBIRAnDuAKCAxz6+9DXu56TUXU+Z7Awv17joHwCfVY3I
tKJdOaaAma7KsFk/uia/p/0=
=u0CR
-----END PGP SIGNATURE-----

--=-gi6MXystPIu2yI4+K/5M--

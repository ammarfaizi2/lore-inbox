Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263088AbTJJWFz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 18:05:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263126AbTJJWFy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 18:05:54 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:12673 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S263088AbTJJWFw (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 18:05:52 -0400
Message-Id: <200310102205.h9AM5lRX007520@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Uncle Jens <kernel@millcreeksys.com>
Cc: "Frederick, Fabian" <Fabian.Frederick@prov-liege.be>,
       "Linux-Kernel (E-mail)" <linux-kernel@vger.kernel.org>
Subject: Re: [2.7 "thoughts"] V0.3 
In-Reply-To: Your message of "Fri, 10 Oct 2003 15:17:30 MDT."
             <1065820650.3f8721ea4162b@secure.millcreeksys.com> 
From: Valdis.Kletnieks@vt.edu
References: <D9B4591FDBACD411B01E00508BB33C1B01F24E98@mesadm.epl.prov-liege.be>
            <1065820650.3f8721ea4162b@secure.millcreeksys.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-575398658P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 10 Oct 2003 18:05:47 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-575398658P
Content-Type: text/plain; charset=us-ascii

On Fri, 10 Oct 2003 15:17:30 MDT, Uncle Jens said:
> What about some type of kernel-based-DRM, where only properly(trusted) signed
> binaries can be executed?  For example, I could compile my public key in with
> the kernel and it would only run binaries that had been signed by my private
> key.  I feel that this would be a great security enhancement and would like t
o
> hear about any issues this may present.
> I've searched all over for a project that does something like this and have b
een
> unable to find one.  I'd like to start one up on my own, but lack the kernel
> development expertise.
> 
> I'm open for any input/flames/etc....

There are two basic problems with the idea:

1) It does nothing to prevent any of the usual abuses of a system - buffer
overflows, shellcode, and the like.  You get fed a bad packet, the signed
Apache binary overflows, and executes the signed /bin/sh that then calls
the signed /bin/echo to append stuff to the appropriate files to create
a back door.....

2) Unless you're working with a kiosk/embedded system where the number of
binaries is quite small, you're looking at a maintenance headache (remember,
if you blindly sign binaries without auditing every single one, you're really not
doing anything useful...)

A *much* better approach would be to do the following:

1) Mount everything either 'read only' or 'noexec', and use something like LSM
to make sure it doesn't get remounted.  So binaries off /home won't run, and
binaries on /usr can't be trojaned (barring OTHER breaches such as remounting,
or scribbling on the raw disk, etc...)

2) Fix the bypasses of noexec (like '/lib/ld-linux.so.2 /your/binary/here').

That's probably a much better way of addressing the "running unauthorized
binaries" threat, without taking a crypto signature hit on every exec().....

--==_Exmh_-575398658P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/hy06cC3lWbTT17ARAlC2AKDLGXlfvAwUFQNV3byFOICzQFQaVACfTRIU
wxVjQ2ScT5ekyJ0vAPar95k=
=m650
-----END PGP SIGNATURE-----

--==_Exmh_-575398658P--

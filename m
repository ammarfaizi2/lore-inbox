Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261950AbTKNUmc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 15:42:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262410AbTKNUmb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 15:42:31 -0500
Received: from coruscant.franken.de ([193.174.159.226]:58554 "EHLO
	dagobah.gnumonks.org") by vger.kernel.org with ESMTP
	id S261950AbTKNUm0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 15:42:26 -0500
Date: Fri, 14 Nov 2003 21:42:12 +0100
From: Harald Welte <laforge@netfilter.org>
To: linux-kernel@vger.kernel.org
Subject: seq_file and exporting dynamically allocated data
Message-ID: <20031114204212.GK6937@obroa-skai.de.gnumonks.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bX/mw5riLlTkt+Gv"
Content-Disposition: inline
X-Operating-System: Linux obroa-skai.de.gnumonks.org 2.4.23-pre7-ben0
X-Date: Today is Pungenday, the 26th day of The Aftermath in the YOLD 3169
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--bX/mw5riLlTkt+Gv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

After having hacked up a patch to convert /proc/net/ip_conntrack
to seq_file (which was quite ah experience, I will comment on that in a
different mail), I am facing a different issue.

I haven't found a way to use seq_file for information that is not
exported as a global variable.=20

Let's say I have some hash tables that are allocated during runtime of
the system, on users demand.  I have no way of knowing how many there
will be and how the user will want to call them.

For every of those hashtables I want to create a file in /proc and
export the data using seq_file().  Since the data objects are all the
same, I'd like to use the same seq_operations.{start,next,show,stop}
functions.  The whole struct seq_operations would be part of a larger
structure that already exists for every hash table.

However, how do I know which hashtable is to be read, when the
seq_operations.start() function is called?  I would somehow need a
pointer back to the hashtable from the file itself.  And please don't
tell me to call d_path() and find the correct hash table by the
filename.

The problem is, that seq_file is already using the file.private_data
member...

Any ideas?

Thanks for enlightening a networking hacker about the magic of the
virtual filesystem ;)

Please Cc' me in replies, that makes the job easier for my mail filters.

--=20
- Harald Welte <laforge@netfilter.org>             http://www.netfilter.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
  "Fragmentation is like classful addressing -- an interesting early
   architectural error that shows how much experimentation was going
   on while IP was being designed."                    -- Paul Vixie

--bX/mw5riLlTkt+Gv
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/tT4kXaXGVTD0i/8RAmdvAKCRc3byY+vg0A0HZRXhV6iNzoFQpQCdEF7t
0B7Ws32oJmOMQZFGitgB5ew=
=m4I+
-----END PGP SIGNATURE-----

--bX/mw5riLlTkt+Gv--

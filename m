Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261328AbTCJPJV>; Mon, 10 Mar 2003 10:09:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261329AbTCJPJV>; Mon, 10 Mar 2003 10:09:21 -0500
Received: from smtp.comcast.net ([24.153.64.2]:22153 "EHLO smtp.comcast.net")
	by vger.kernel.org with ESMTP id <S261328AbTCJPJU>;
	Mon, 10 Mar 2003 10:09:20 -0500
Date: Mon, 10 Mar 2003 10:03:06 -0500
From: John M Flinchbaugh <glynis@butterfly.hjsoft.com>
Subject: Re: still having smp/snat problems (Re: Linux 2.4.19-rc3)
In-reply-to: <002201c2e6e8$ee071d40$0201a8c0@intranet>
To: Dan Broscoi <brosky@bronet.ro>
Cc: linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
Message-id: <20030310150306.GA8145@butterfly.hjsoft.com>
MIME-version: 1.0
Content-type: multipart/signed; boundary=KsGdsel6WgEHnImy;
 protocol="application/pgp-signature"; micalg=pgp-sha1
Content-disposition: inline
User-Agent: Mutt/1.5.3i
References: <002201c2e6e8$ee071d40$0201a8c0@intranet>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2003 at 11:39:21AM +0200, Dan Broscoi wrote:
> i'm writing you after reading your post on=20
http://hypermail.idiosynkrasia.net/linux-kernel/archived/2002/week28/142
9.html
> I have the same problem, compiling a 2.4.20 kernel on Debian 3.0
> Do you know the fix for this ?

no one could really offer any help in the end.  i think having the
multiple snat rules matching on all interfaces may have been
triggering a race in the conntrack code.  i should probably resubmit
my findings.

anyway, limitting the rules by matching them only to their appropriate
interfaces seemed to alleviate the problem.

so now i use something similar to this:
iptables -t nat -A POSTROUTING -o eth0 -s 192.168.1.0/24 \
-j SNAT --to 10.1.1.15
iptables -t nat -A POSTROUTING -o eth1 -s 192.168.1.0/24 \
-j SNAT --to 192.168.1.1
iptables -t nat -A POSTROUTING -o eth2 -s 192.168.2.0/24 \
-j SNAT --to 192.168.2.1
---

note the -o interface rules.  this keeps it from applying more than
one snat rule to a packet.  it only applies them to the packet going
out the proper interface.

ps. i'm actually going to bounce this to the kernel list again to see
if i can stir up any more noise on this one.
--=20
____________________}John Flinchbaugh{______________________
| glynis@hjsoft.com         http://www.hjsoft.com/~glynis/ |
~~Powered by Linux: Reboots are for hardware upgrades only~~

--KsGdsel6WgEHnImy
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+bKkqCGPRljI8080RAgC9AJoCvL26DiDMP/GuSYKV5HFDFskZHQCggXNW
K0mMddPoWAcGFsXr+X0Hyzw=
=zdV6
-----END PGP SIGNATURE-----

--KsGdsel6WgEHnImy--

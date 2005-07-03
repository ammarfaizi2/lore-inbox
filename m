Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261456AbVGCPna@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261456AbVGCPna (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Jul 2005 11:43:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261457AbVGCPna
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Jul 2005 11:43:30 -0400
Received: from mail.suse.de ([195.135.220.2]:24978 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261456AbVGCPnW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Jul 2005 11:43:22 -0400
Date: Sun, 3 Jul 2005 17:43:11 +0200
From: Kurt Garloff <garloff@suse.de>
To: Linux kernel list <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@osdl.org>
Cc: Stephen Smalley <sds@epoch.ncsc.mil>, James Morris <jmorris@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>, Steve Beattie <smb@wirex.com>
Subject: [PATCH 0/3] LSM hooks consolidation
Message-ID: <20050703154311.GA11093@tpkurt.garloff.de>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Linux kernel list <linux-kernel@vger.kernel.org>,
	Chris Wright <chrisw@osdl.org>, Stephen Smalley <sds@epoch.ncsc.mil>,
	James Morris <jmorris@redhat.com>,
	Greg Kroah-Hartman <gregkh@suse.de>, Steve Beattie <smb@wirex.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
Content-Disposition: inline
X-Operating-System: Linux 2.6.11.4-21.7-default i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E
Organization: SUSE/Novell
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

here is the version of my patches that rework the security=20
stubs in security.h a bit to allow for better maintainability
and allow the possibility of using conditionals over indirect
calls. The latter has been found beneficial with tcp_rr benchmarks
on ia64.

To stress the maintainability point: One of the void stubs had a
return statement in there, which was inconsistent between the
cap_ and security_ops-> versions.

The first patch, as a prerequisiste, makes capabilities the default
for CONFIG_SECURITY=3Dy rather than the dumb dummy, which results in
a broken system -- which makes everybody wanting to load capability.
Not the idea, as this makes loading other LSMs problematic ...

Note that I did not drop dummy completely. I think it should ... but
currently LSMs that don't have all functions implement fall back to
the implementations in dummy. I did not want to change behaviour and
fall back to the ones in capability. Most are identical between cap
and dummy, but I did not review all existing LSMs. It could be done
at a second step if deemed viable.

Note that the patches have been discussed before:
http://www.ussg.iu.edu/hypermail/linux/kernel/0502.1/1040.html
http://www.ussg.iu.edu/hypermail/linux/kernel/0408.1/0623.html

In comparison to the last submission, I have dropped the unlikely()=20
stuff that seemed too controversial.=20
The patch 2 which does the main cleanup has been split in two.
The first is produced by a little python script that parses the
function implementations and the ifdefs and reorders them, so
they end up next to each other. This greatly simplifies the creation
of the next patch and minimizes the chances to screw up.
I marked these patches 2a and 2b.

Please apply!
--=20
Kurt Garloff, Director SUSE Labs, Novell Inc.

--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCyAePxmLh6hyYd04RArQ5AJ9BBLwdJvM2wMQCzQwm3AKH40MTsQCfbaSp
hX38ob1UeY7EgdsSXhytkd8=
=sn7f
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262463AbUB0M1s (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 07:27:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261813AbUB0MZx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 07:25:53 -0500
Received: from darwin.snarc.org ([81.56.210.228]:10889 "EHLO darwin.snarc.org")
	by vger.kernel.org with ESMTP id S262463AbUB0MXO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 07:23:14 -0500
Date: Fri, 27 Feb 2004 13:23:11 +0100
To: lkml <linux-kernel@vger.kernel.org>
Subject: about runqueues locking
Message-ID: <20040227122311.GA28181@snarc.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
Content-Disposition: inline
X-Warning: Email may contain unsmilyfied humor and/or satire.
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Vincent Hanquez <tab@snarc.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

	Hi LKML,

I've got a code for 2.4 which do:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
spin_lock_irqsave(&runqueue_lock, flags)
for_each_process(p)
{
	// modify p attributes
}
spin_unlock_irqrestore(&runqueue_lock, flags)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

and I need to translate it to 2.6.
What is exactly the best solution since runqueues are per cpu now ?

Is there a way to lock and browse each runqueues ?
or if not, is tasklist_lock can be use to lock all runqueues at once ?

and one another question, what is the difference between
local_irq_disable() and local_irq_save() ?
irq_save push eflags register on the stack, but why for ?

Thanks for any comments.
--=20
Tab

--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAPzavzKe/MInoaQARAtdeAJ4iuXY9ERtKJzoe2WwZye5X7V8i3QCdG4og
P+GB4so+RbnGdbyYHzwl2oE=
=QmaX
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--

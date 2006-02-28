Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932067AbWB1ORZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932067AbWB1ORZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 09:17:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932088AbWB1ORZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 09:17:25 -0500
Received: from cantor2.suse.de ([195.135.220.15]:33758 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932076AbWB1ORY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 09:17:24 -0500
Date: Tue, 28 Feb 2006 13:13:03 +0100
From: Kurt Garloff <garloff@suse.de>
To: Carlos Martin <carlos@cmartin.tk>
Cc: Linux kernel list <linux-kernel@vger.kernel.org>,
       Rik van Riel <riel@redhat.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] OOM: initialise points variable in out_of_memory()
Message-ID: <20060228121303.GE6641@tpkurt.garloff.de>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Carlos Martin <carlos@cmartin.tk>,
	Linux kernel list <linux-kernel@vger.kernel.org>,
	Rik van Riel <riel@redhat.com>, Andrew Morton <akpm@osdl.org>
References: <11410761851547-git-send-email-carlos@cmartin.tk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="i3lJ51RuaGWuFYNw"
Content-Disposition: inline
In-Reply-To: <11410761851547-git-send-email-carlos@cmartin.tk>
X-Operating-System: Linux 2.6.16-rc3-git3-2-xen i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E
Organization: SUSE/Novell
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--i3lJ51RuaGWuFYNw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Carlos,

On Mon, Feb 27, 2006 at 10:36:25PM +0100, Carlos Martin wrote:
> We didn't initialise points, so the value reported was completely
> random. This doesn't affect the behaviour of the funcion.

Did you observe it?

In the original patch, there is=20
+static struct task_struct * select_bad_process(unsigned long *ppoints)
 {
-       unsigned long maxpoints =3D 0;
        struct task_struct *g, *p;
        struct task_struct *chosen =3D NULL;
        struct timespec uptime;
+       *ppoints =3D 0;

And this is called from out_of_memory().

But the constrained_alloc stuff seems to use points before=20
select_bad_process() is called, so initializing to 0 is a
good idea. I don't remember having see the constrained_alloc
stuff, though, so I either did not look carefully enough or a=20
merge error happened afterwards.=20

Thanks for noticing and thanks for sending the fix!

Best,
--=20
Kurt Garloff, Head Architect Linux, Novell Inc.

--i3lJ51RuaGWuFYNw
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFEBD5PxmLh6hyYd04RAkPmAJ0fwx0e5Ah05HGRhTfDvW3NWxvD4QCgufVh
WNFHdExpX1+WynpEUo0+LPs=
=zP71
-----END PGP SIGNATURE-----

--i3lJ51RuaGWuFYNw--

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262896AbUJ1Sic@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262896AbUJ1Sic (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 14:38:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262918AbUJ1SiX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 14:38:23 -0400
Received: from mail.murom.net ([213.177.124.17]:28849 "EHLO mail.murom.net")
	by vger.kernel.org with ESMTP id S262920AbUJ1SgE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 14:36:04 -0400
Date: Thu, 28 Oct 2004 22:35:51 +0400
From: Sergey Vlasov <vsu@altlinux.ru>
To: Jason Baron <jbaron@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Patch] 2.4.28-pre3 tty/ldisc fixes
Message-ID: <20041028183551.GC3253@sirius.home>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ctP54qlpMx3WjD+/"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0409241340090.24358-100000@dhcp83-105.boston.redhat.com>
X-yoursite-MailScanner-Information: Please contact the ISP for more information
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-SpamCheck: not spam, SpamAssassin (score=-0.048,
	required 6, autolearn=not spam, AWL -0.05, BAYES_44 -0.00)
X-MailScanner-From: vsu@altlinux.ru
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ctP54qlpMx3WjD+/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 24 Sep 2004 13:49:33 -0400, Jason Baron wrote:

> Here is a first attempt at bringing Alan's 2.6 tty/ldisc fixes to 2.4. =
=20
> I've done some testing with it, but was hoping for broader
> testing/feedback while all the issues get ironed out. The most notable
> change is the addition of a wakeup at the end of tty_set_ldisc, for
> threads waiting for the TTY_LDISC bit to be set.

> +
> +	/* Defer ldisc switch */
> +	/* tty_deferred_ldisc_switch(N_TTY);
> +
>  	read_lock(&tasklist_lock);
>   	for_each_task(p) {
>  		if ((tty->session > 0) && (p->session =3D=3D tty->session) &&

Here the comment is unclosed; is this intentional?  Simply closing it
at the same line gives a kernel which cannot complete the system boot
process: it prints "init_dev but no ldisc", and then init hangs in
uninterruptible sleep with this backtrace:

Adhoc c0188ab7 <tty_ldisc_ref_wait+47/80>
Adhoc c0199c30 <con_write+0/30>
Adhoc c0189648 <tty_write+118/270>
Adhoc c0139728 <chrdev_open+38/50>
Adhoc c01386e3 <dentry_open+e3/190>
Adhoc c0138f16 <sys_write+96/f0>
Adhoc c01385eb <filp_open+4b/60>
Adhoc c014246f <getname+5f/a0>
Adhoc c0138937 <sys_open+57/80>

--ctP54qlpMx3WjD+/
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBgTwHW82GfkQfsqIRAtYJAJ9Rt09+vuxwJ58NxyYmoIcB7SZn/gCdFU0B
4ezpj7oyEB3h/hmFDHDLoWc=
=d1fJ
-----END PGP SIGNATURE-----

--ctP54qlpMx3WjD+/--

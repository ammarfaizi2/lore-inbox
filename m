Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275218AbTHRWPp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 18:15:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275211AbTHRWPp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 18:15:45 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:28802 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S275126AbTHRWPm (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 18:15:42 -0400
Message-Id: <200308182215.h7IMFecc013449@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Phil Oester <kernel@theoesters.com>
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: [PATCH] Ratelimit SO_BSDCOMPAT warnings 
In-Reply-To: Your message of "Mon, 18 Aug 2003 15:06:05 PDT."
             <20030818150605.A23957@ns1.theoesters.com> 
From: Valdis.Kletnieks@vt.edu
References: <20030818150605.A23957@ns1.theoesters.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-940381732P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 18 Aug 2003 18:15:40 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-940381732P
Content-Type: text/plain; charset=us-ascii

On Mon, 18 Aug 2003 15:06:05 PDT, Phil Oester said:
> Back in March, there was some discussion about ratelimiting the
> BSDCOMPAT errors, and James Morris provided a patch to achieve
> this.

> Unfortunately, it seems to have fallen through the cracks.  Below
> is the patch again, updated for 2.6.0-test3 - please apply.

>  static void sock_warn_obsolete_bsdism(const char *name)
>  {
> -       printk(KERN_WARNING "process `%s' is using obsolete "
> -              "%s SO_BSDCOMPAT\n", current->comm, name);
> +       static int warned;
> +
> +       if (!warned) {
> +               warned = 1;


Umm.. am I dense, or does this only warn once for *the first program*
to do it after the system boots?  And you don't get another warning about
any OTHER programs until you reboot in a few weeks (possibly)?

If so, why are we bothering at all?  Once *per process* I could see, but
once per boot?

--==_Exmh_-940381732P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/QVAMcC3lWbTT17ARAmo2AJ9guU/ZsW+cgp37wWergCPMyfDFVACgn0kh
U5By6PDQ5AU/vaDrN0Ni3wc=
=I6Y7
-----END PGP SIGNATURE-----

--==_Exmh_-940381732P--

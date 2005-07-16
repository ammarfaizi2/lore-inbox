Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261476AbVGPL4l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261476AbVGPL4l (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Jul 2005 07:56:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261531AbVGPL4l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Jul 2005 07:56:41 -0400
Received: from smtprelay03.ispgateway.de ([80.67.18.15]:34966 "EHLO
	smtprelay03.ispgateway.de") by vger.kernel.org with ESMTP
	id S261476AbVGPL4k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Jul 2005 07:56:40 -0400
From: Ingo Oeser <ioe-lkml@rameria.de>
To: domen@coderock.org
Subject: Re: [patch 1/1] Audit return code of create_proc_*
Date: Sat, 16 Jul 2005 13:56:29 +0200
User-Agent: KMail/1.7.2
References: <20050714221923.543951000@homer>
In-Reply-To: <20050714221923.543951000@homer>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1731540.atL9McG8jg";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200507161356.36058.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1731540.atL9McG8jg
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Domen,

On Friday 15 July 2005 00:19, you wrote:
> Audit return of create_proc_* functions.

This (and related changes) spam the log, if
kernel is compiled without /proc-support.

Kernels without /proc-support are quite common in the embedded world.

Just provide a function in a suitable header=20
(include/linux/proc_fs.h looks promising)
file, which contains the following:

#ifdef CONFIG_PROC_FS
#define procfs_failure(msg) do { printk(msg); } while(0)
#else
#define procfs_failure(msg) do {} while(0)
#endif

and use it instead of the direct printk call.

That way you get both: Your GCC or checking tool warning is silenced
and the log is not spammed for the embedded people.

=46or code, which is broken without procfs, the code
should be fixed or it should select PROC_FS in its Kconfig file.


Regards

Ingo Oeser



--nextPart1731540.atL9McG8jg
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBC2PX0U56oYWuOrkARAkx7AKCkkwMsZehON9+1eQSuop+PnGxSjACfUw4b
WPG51s1/lgQnmBEyYWMoY/g=
=8F5E
-----END PGP SIGNATURE-----

--nextPart1731540.atL9McG8jg--

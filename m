Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964920AbVKGSc2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964920AbVKGSc2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 13:32:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964991AbVKGSc2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 13:32:28 -0500
Received: from mail.sf-mail.de ([62.27.20.61]:22921 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S964987AbVKGSc0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 13:32:26 -0500
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: Panagiotis Issaris <panagiotis.issaris@gmail.com>
Subject: Re: [PATCH] ipw2200: Missing kmalloc check
Date: Mon, 7 Nov 2005 19:32:15 +0100
User-Agent: KMail/1.8.3
Cc: ipw2100-admin@linux.intel.com, linux-kernel@vger.kernel.org
References: <1125886450.4017.14.camel@nyx>
In-Reply-To: <1125886450.4017.14.camel@nyx>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1612688.UlMJJWICWi";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200511071932.22060@bilbo.math.uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1612688.UlMJJWICWi
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Panagiotis Issaris wrote:
>The ipw2200 driver code in current GIT contains a kmalloc() followed by
>a memset() without handling a possible memory allocation failure.
>
>Signed-off-by: Panagiotis Issaris <panagiotis.issaris@gmail.com>
>---
>
> drivers/net/wireless/ipw2200.c |    4 ++++
> 1 files changed, 4 insertions(+), 0 deletions(-)
>
>8e288419b49346fee512739acac446c951727d04
>diff --git a/drivers/net/wireless/ipw2200.c
>b/drivers/net/wireless/ipw2200.c
>--- a/drivers/net/wireless/ipw2200.c
>+++ b/drivers/net/wireless/ipw2200.c
>@@ -3976,6 +3976,10 @@ static struct ipw_rx_queue *ipw_rx_queue
> 	int i;
>
> 	rxq =3D (struct ipw_rx_queue *)kmalloc(sizeof(*rxq), GFP_KERNEL);
>+	if (unlikely(!rxq)) {
>+		IPW_ERROR("memory allocation failed\n");
>+		return NULL;
>+	}
> 	memset(rxq, 0, sizeof(*rxq));

Please remove the cast and use kzalloc() instead of kmalloc() and=20
memset(,0,).

Eike

--nextPart1612688.UlMJJWICWi
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBDb522XKSJPmm5/E4RAgDyAJ4k+BZrlPDqZ6z1wDEpqWhuJZbC3QCeMoVX
A77ztYpkTKe6FBd4g7hsHEg=
=Tu48
-----END PGP SIGNATURE-----

--nextPart1612688.UlMJJWICWi--

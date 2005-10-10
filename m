Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750780AbVJJNUl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750780AbVJJNUl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 09:20:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750787AbVJJNUl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 09:20:41 -0400
Received: from mail.sf-mail.de ([62.27.20.61]:61631 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S1750780AbVJJNUk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 09:20:40 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: Manu Abraham <manu@linuxtv.org>
Subject: Re: PCI driver
Date: Mon, 10 Oct 2005 15:25:22 +0200
User-Agent: KMail/1.8.2
References: <4327EE94.2040405@kromtek.com> <200510101403.02578@bilbo.math.uni-mannheim.de> <434A6334.4090407@linuxtv.org>
In-Reply-To: <434A6334.4090407@linuxtv.org>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1210682.eFK5z5qh4X";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200510101525.27913@bilbo.math.uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1210682.eFK5z5qh4X
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Montag, 10. Oktober 2005 14:48 schrieben Sie:
>Rolf Eike Beer wrote:
>>IIRC the call to pci_enable_device() must be the first thing you do. This
>> will do the things like assigning memory regions to the device and so on.
>
>I fixed this one
>
>>Returning 0 in error cases is just wrong. And you free the assignments ev=
en
>> in case of success AFAICS. Try the return I introduced above and see what
>> happens.
>
>I fixed this one too ..
>
>
>I have fixed most of the stuff, it is partly working, not ready yet as
>there are some more things to be added to  ..
>I have attached what i was working on.

If the kmalloc() fails in mantis_pci_probe() you don't call=20
pci_disable_device(). And you should kzalloc() instead of kmalloc() and=20
memset().

It looks like you never use "__u16 vendor_id;" and "__u16 device_id;" in=20
struct mantis_pci.

Eike

--nextPart1210682.eFK5z5qh4X
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBDSmvHXKSJPmm5/E4RAirlAJ0UfDLEvYMBPpZ+PHR2gh14S9HyNQCfeIeD
YcA08zPH8LuiEJiOAQYuNCc=
=H4QS
-----END PGP SIGNATURE-----

--nextPart1210682.eFK5z5qh4X--

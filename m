Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265029AbSJRHzE>; Fri, 18 Oct 2002 03:55:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265035AbSJRHzE>; Fri, 18 Oct 2002 03:55:04 -0400
Received: from mithra.wirex.com ([65.102.14.2]:40708 "EHLO mail.wirex.com")
	by vger.kernel.org with ESMTP id <S265029AbSJRHzD>;
	Fri, 18 Oct 2002 03:55:03 -0400
Message-ID: <3DAFBFA2.4040207@wirex.com>
Date: Fri, 18 Oct 2002 01:00:34 -0700
From: Crispin Cowan <crispin@wirex.com>
Organization: WireX Communications, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
Cc: greg@kroah.com, hch@infradead.org, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org, linux-security-module@wirex.com
Subject: Re: [PATCH] remove sys_security
References: <20021017203652.GB592@kroah.com>	<20021017.133816.82029797.davem@redhat.com>	<20021017205830.GD592@kroah.com> <20021017.135832.54206778.davem@redhat.com>
X-Enigmail-Version: 0.65.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-md5;
 protocol="application/pgp-signature";
 boundary="------------enig1BCE82564508C8FF24443A47"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1BCE82564508C8FF24443A47
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

David S. Miller wrote:

>There is a very important fundamental difference to the USB case.
>It eats zero space in my kernel when I have no USB devices.
>CONFIG_USB=m works as designed!
>
>CONFIG_SECURITY=m still does not exist, so distribution makers have to
>make a y vs. n choice.
>
This was our design goal for LSM: to be as minimally intrusive to the 
kernel as possible. We would LOVE to have a zero-footprint solution that 
allowed users to enable LSM when they need it. More precisely, LSM is 
that mechanism intended to impose as little overhead as possible with no 
modules loaded, and provide adequate access to the modules when they are 
loaded.

LSM is not zero-footprint, but it is as low as we could make it. We are 
interested in ways to reduce the footprint, but that reduction needs to 
be looked at in cost/benefit terms: changes that have very little impact 
on footprint, but high impact on the functionality of the LSM interface. 
If you remove this system call, you will save almost nothing in kernel 
resources, but do a lot of damage to functionality.

On the other hand, the complaints about the typing of the arguments are 
well taken, in the context of 32/64-bit porting issues. So what types 
should the arguments be? Abstractly, they are integers, in the 
mathematical sense. What is the preferred word-size-portalbe way to 
express that?

Crispin

-- 
Crispin Cowan, Ph.D.
Chief Scientist, WireX                      http://wirex.com/~crispin/
Security Hardened Linux Distribution:       http://immunix.org
Available for purchase: http://wirex.com/Products/Immunix/purchase.html


--------------enig1BCE82564508C8FF24443A47
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE9r7+q5ZkfjX2CNDARActtAJ98Cwx/Dkfl1TCbARxgM2HITBhSxgCfVlsw
9a6c6xaVuyNn+BQpDf7liy4=
=1R7l
-----END PGP SIGNATURE-----

--------------enig1BCE82564508C8FF24443A47--


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262646AbULPJDZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262646AbULPJDZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 04:03:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262647AbULPJDZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 04:03:25 -0500
Received: from mail22.syd.optusnet.com.au ([211.29.133.160]:4789 "EHLO
	mail22.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262646AbULPJCt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 04:02:49 -0500
Message-ID: <41C14F1B.8000401@kolivas.org>
Date: Thu, 16 Dec 2004 20:02:19 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Werner Almesberger <werner@almesberger.net>
Cc: Rajesh Venkatasubramanian <vrajesh@umich.edu>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] Generalized prio_tree, revisited
References: <20041216053118.M1229@almesberger.net>
In-Reply-To: <20041216053118.M1229@almesberger.net>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigDE77F5D4AE924DF9259A5C02"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigDE77F5D4AE924DF9259A5C02
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Werner Almesberger wrote:
> did you have a chance to look at the prio_tree generalization ?
> 
> I've attached the patch I posted a month ago (plus the trivial
> "const" change). It's for 2.6.9, but also applies to 2.6.10-rc2,
> which I've been using for a good while now.
> 
> The patch splits the radix priority search trees into two types:
> the "raw" one with implicit keys, as it's currently used, and a
> new, generalized one with explicit keys, which should be used by
> new code.

>  struct prio_tree_root {
>  	struct prio_tree_node	*prio_tree_node;
> -	unsigned int 		index_bits;
> +	unsigned short 		index_bits;
> +	unsigned short		raw;
> +		/*
> +		 * 0: nodes are of type struct prio_tree_node
> +		 * 1: nodes are of type raw_prio_tree_node
> +		 */
>  };

> -	INIT_PRIO_TREE_ROOT(&inode->i_data.i_mmap);
> +	INIT_PRIO_TREE_ROOT(&inode->i_data.i_mmap, 1);

While not being able to comment on the actual patch I think having a 1 
or 0 for different types is not clear. Naming them different struct 
names would seem to me much more readable.

Cheers,
Con

--------------enigDE77F5D4AE924DF9259A5C02
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBwU8dZUg7+tp6mRURAnILAJ4yed4lIVPSqJzRYw15T5jLIeNd6gCfZUmn
lFZlrL7trowlzwQ/J5MJd8g=
=6PUe
-----END PGP SIGNATURE-----

--------------enigDE77F5D4AE924DF9259A5C02--

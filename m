Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261225AbVBFMyS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261225AbVBFMyS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 07:54:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261218AbVBFMyR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 07:54:17 -0500
Received: from postfix4-1.free.fr ([213.228.0.62]:59296 "EHLO
	postfix4-1.free.fr") by vger.kernel.org with ESMTP id S261283AbVBFMxk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 07:53:40 -0500
Message-ID: <42061347.4090301@free.fr>
Date: Sun, 06 Feb 2005 13:53:27 +0100
From: Laurent Riffard <laurent.riffard@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.5) Gecko/20041217
X-Accept-Language: fr-fr, fr, en
MIME-Version: 1.0
To: Peter Osterlund <petero2@telia.com>
Cc: Andrew Morton <akpm@osdl.org>, Jens Axboe <axboe@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc3-mm1 : mount UDF CDRW stuck in D state
References: <4204F91B.5040302@free.fr> <m3vf96r017.fsf@telia.com>	<m3sm4apig8.fsf@telia.com> <20050205222301.337de629.akpm@osdl.org> <m37jlmp0dv.fsf@telia.com>
In-Reply-To: <m37jlmp0dv.fsf@telia.com>
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig35314DA0DAA97DC237417883"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig35314DA0DAA97DC237417883
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit


Le 06.02.2005 09:18, Peter Osterlund a écrit :
[snip]
>
> Anyway, the problem is that the add-struct-request-end_io-callback
> patch forgot to update pktcdvd.c. This patch fixes it. It should
> probably be merged into the add-struct-request-end_io-callback patch,
> because that patch already fixes up other struct request users.
>
> Signed-off-by: Peter Osterlund <petero2@telia.com>
> ---
>
>  linux-petero/drivers/block/pktcdvd.c |    1 +
>  1 files changed, 1 insertion(+)
>
> diff -puN drivers/block/pktcdvd.c~pktcdvd-endio-fix drivers/block/pktcdvd.c
> --- linux/drivers/block/pktcdvd.c~pktcdvd-endio-fix	2005-02-06 08:59:16.000000000 +0100
> +++ linux-petero/drivers/block/pktcdvd.c	2005-02-06 09:01:22.000000000 +0100
> @@ -375,6 +375,7 @@ static int pkt_generic_packet(struct pkt
>  	rq->ref_count++;
>  	rq->flags |= REQ_NOMERGE;
>  	rq->waiting = &wait;
> +	rq->end_io = blk_end_sync_rq;
>  	elv_add_request(q, rq, ELEVATOR_INSERT_BACK, 1);
>  	generic_unplug_device(q);
>  	wait_for_completion(&wait);
> _
>

Ok, this patch fixed the problem. I'm able to mount the CDRW and write some data.

Thank you.
--
laurent

--------------enig35314DA0DAA97DC237417883
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFCBhNSUqUFrirTu6IRAh5YAKCeUwvb7wkzgUXy3DfWCGfZZuetZwCgxp3g
C+z7XcU6hUshCsuoCcdkiyk=
=RphP
-----END PGP SIGNATURE-----

--------------enig35314DA0DAA97DC237417883--

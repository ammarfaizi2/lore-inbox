Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261501AbUB0Aon (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 19:44:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261548AbUB0Aon
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 19:44:43 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:984 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id S261501AbUB0Aod (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 19:44:33 -0500
Date: Fri, 27 Feb 2004 11:44:09 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Jens Axboe <axboe@suse.de>
Cc: jgarzik@pobox.com, akpm@osdl.org, linus@osdl.org, anton@samba.org,
       paulus@samba.org, piggin@cyberone.com.au,
       viro@parcelfarce.linux.theplanet.co.uk, hch@lst.de,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iSeries virtual disk
Message-Id: <20040227114409.393e926b.sfr@canb.auug.org.au>
In-Reply-To: <20040226074043.GF32080@suse.de>
References: <20040123163504.36582570.sfr@canb.auug.org.au>
	<20040122221136.174550c3.akpm@osdl.org>
	<20040226172325.3a139f73.sfr@canb.auug.org.au>
	<403DA056.8030007@pobox.com>
	<20040226074043.GF32080@suse.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Fri__27_Feb_2004_11_44_09_+1100_P=kuJ52PVk+TrM12"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Fri__27_Feb_2004_11_44_09_+1100_P=kuJ52PVk+TrM12
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Hi Jens,

On Thu, 26 Feb 2004 08:40:43 +0100 Jens Axboe <axboe@suse.de> wrote:
>
> On Thu, Feb 26 2004, Jeff Garzik wrote:
> > 4) why do you call blkdev_dequeue_request() in do_viodasd_request() 
> > rather than viodasd_end_request() ?  Or just use end_request() ?
> 
> It makes the queueing simpler (you could potentially leave the _last_
> request on the queue, but it's probably not worth the hassle).

Thanks.

> They should not call elv_next_request() only to bail if
> num_req_outstanding is too big, since it has side effects (moving
> request from io scheduler core to dispatch, which makes it ineligible
> for merging, sorting, etc).
> 
> 	do {
> 		if (too_many_queued)
> 			break;
> 
> 		rq = elv_next_request(q);
> 		if (!rq)
> 			break;
> 
> 		...
> 	}

OK, fixed.

> > 12) don't you need to set blk_queue_max_phys_segments() too?
> 
> Yep

Done.

New patch following soon ...
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__27_Feb_2004_11_44_09_+1100_P=kuJ52PVk+TrM12
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAPpLZFG47PeJeR58RApCbAJ98cuQHRRd5717lINwTts/QZ9NUTQCcCTMJ
VKMaIaGxRX7jQYz2XUyorsU=
=xso5
-----END PGP SIGNATURE-----

--Signature=_Fri__27_Feb_2004_11_44_09_+1100_P=kuJ52PVk+TrM12--

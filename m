Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261393AbUB0Cqc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 21:46:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261631AbUB0Cqc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 21:46:32 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:57054 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id S261393AbUB0Cq3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 21:46:29 -0500
Date: Fri, 27 Feb 2004 13:45:10 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: akpm@osdl.org, linus@osdl.org, anton@samba.org, paulus@samba.org,
       axboe@suse.de, piggin@cyberone.com.au,
       viro@parcelfarce.linux.theplanet.co.uk, hch@lst.de,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iSeries virtual disk
Message-Id: <20040227134510.520ec3d1.sfr@canb.auug.org.au>
In-Reply-To: <403EA259.5050105@pobox.com>
References: <20040123163504.36582570.sfr@canb.auug.org.au>
	<20040122221136.174550c3.akpm@osdl.org>
	<20040226172325.3a139f73.sfr@canb.auug.org.au>
	<403DA056.8030007@pobox.com>
	<20040227114240.6e26d870.sfr@canb.auug.org.au>
	<403EA259.5050105@pobox.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Fri__27_Feb_2004_13_45_10_+1100_NWyU6I0VKsYSjTJc"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Fri__27_Feb_2004_13_45_10_+1100_NWyU6I0VKsYSjTJc
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Hi Jeff,

Thanks for the feedback, comments follow:

On Thu, 26 Feb 2004 20:50:17 -0500 Jeff Garzik <jgarzik@pobox.com> wrote:
>
> Stephen Rothwell wrote:
> > On Thu, 26 Feb 2004 02:29:26 -0500 Jeff Garzik <jgarzik@pobox.com> wrote:
> >>2) num_req_outstanding accessed without lock in do_viodasd_request 
> >>(driver's request_fn).  all other accesses are inside spinlock.
> > 
> > 
> > This is actually OK because:
> > 	1) if we see a value too large, when it get decremented by
> > 	handle_read_write, all the queue requst functions will get rerun.
> > 	2) in send_request, if we get an error and decrement the count
> > 	to zero, then the count could have been at most 1 (sonce sends
> > 	are serialised) so in the request funtion, we would not have
> > 	stopped processing requests.
> 
> That doesn't solve the race though...  IMO protect it with the spinlock 
> and be done with it...

As you said elsewhere, we can quibble after it is merged.

> >>5) is it really OK to call viodasd_open() and viodasd_release() multiple 
> >>times?  These functions do not look guarded against multiple openers.
> > 
> > It is OK.
> 
> I need more explanation than that.
> 
> Multiple openers _are_ supported at the block layer, and this driver 
> does not guard against multiple openers.

Sorry - the underlying Hypervisor calls supprto multiple open.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__27_Feb_2004_13_45_10_+1100_NWyU6I0VKsYSjTJc
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAPq82FG47PeJeR58RAiGMAJ99U0BYO65UGtmnYGfZRUh7UbykcgCgiQ9t
qYbaMgUBLzd2wjB8CA41Law=
=maSi
-----END PGP SIGNATURE-----

--Signature=_Fri__27_Feb_2004_13_45_10_+1100_NWyU6I0VKsYSjTJc--

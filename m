Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751498AbWEOUlp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751498AbWEOUlp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 16:41:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751501AbWEOUlp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 16:41:45 -0400
Received: from kenobi.snowman.net ([70.84.9.186]:56533 "EHLO
	kenobi.snowman.net") by vger.kernel.org with ESMTP id S1751498AbWEOUlo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 16:41:44 -0400
Date: Mon, 15 May 2006 16:41:43 -0400
From: Stephen Frost <sfrost@snowman.net>
To: Patrick McHardy <kaber@trash.net>
Cc: Amin Azez <azez@ufomechanic.net>, "David S. Miller" <davem@davemloft.net>,
       willy@w.ods.org, gcoady.lk@gmail.com, laforge@netfilter.org,
       netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org,
       marcelo@kvack.org
Subject: Re: [PATCH] fix mem-leak in netfilter
Message-ID: <20060515204142.GO7774@kenobi.snowman.net>
Mail-Followup-To: Patrick McHardy <kaber@trash.net>,
	Amin Azez <azez@ufomechanic.net>,
	"David S. Miller" <davem@davemloft.net>, willy@w.ods.org,
	gcoady.lk@gmail.com, laforge@netfilter.org,
	netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org,
	marcelo@kvack.org
References: <20060507.224339.48487003.davem@davemloft.net> <44643BFD.3040708@trash.net> <9a8748490605120409x3851ca4fn14fc9c52500701e4@mail.gmail.com> <44647280.1030602@trash.net> <446490BB.10801@ufomechanic.net> <44683AFF.4070200@trash.net> <20060515142834.GL7774@kenobi.snowman.net> <4468CD3C.3000908@trash.net> <20060515192738.GN7774@kenobi.snowman.net> <4468DFF6.5020304@trash.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rZHzn+A9B7nBTGyj"
Content-Disposition: inline
In-Reply-To: <4468DFF6.5020304@trash.net>
X-Editor: Vim http://www.vim.org/
X-Info: http://www.snowman.net
X-Operating-System: Linux/2.6.16-1-vserver-686 (i686)
X-Uptime: 16:32:26 up 7 days, 14:27, 22 users,  load average: 2.39, 1.77, 1.84
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--rZHzn+A9B7nBTGyj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Patrick McHardy (kaber@trash.net) wrote:
> This is the updated patch, it changes the eviction strategy
> to LRU and fixes a bug related to TTL handling, the TTL stored
> in the entry should only be overwritten if the IPT_RECENT_TTL
> flag is set.

This looks like least-recently-added as opposed to least-recently-used
(or, really, least-recently-updated).  Not sure how you move an entry in
the lru list (perhaps just delete/add?) but I'm pretty sure
recent_entry_update() needs to be modified to move the updated entry to
the end of the list for correct operation.

You also don't appear to check if 't' (the table following the
recent_table_lookup() call) is valid in the 'match' (around
line 191).  recent_entry_lookup() doesn't check that either.  It seems
like you should be guarenteed to always get a table back but it might be
prudent to check anyway.

I thought that I had convinced myself that the TTL handling was okay and
that where it was overwritten wasn't harmful.  Oh well.

	Thanks,

		Stephen

--rZHzn+A9B7nBTGyj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQFEaOeGrzgMPqB3kigRAhCgAJ4vQmH4EAxUjmwQGpMqcWpB2bbZ8ACeJq+3
9+1+gF86/BKd/lFH3a+EwCA=
=oyAT
-----END PGP SIGNATURE-----

--rZHzn+A9B7nBTGyj--

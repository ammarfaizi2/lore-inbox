Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261898AbVFQCcc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261898AbVFQCcc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 22:32:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261899AbVFQCcc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 22:32:32 -0400
Received: from relay.snowman.net ([66.92.160.56]:8714 "EHLO relay.snowman.net")
	by vger.kernel.org with ESMTP id S261898AbVFQCc1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 22:32:27 -0400
Date: Thu, 16 Jun 2005 22:31:50 -0400
From: Stephen Frost <sfrost@snowman.net>
To: "David S. Miller" <davem@davemloft.net>
Cc: jesper.juhl@gmail.com, juhl-lkml@dif.dk, linux-kernel@vger.kernel.org,
       laforge@netfilter.org
Subject: Re: Shouldn't we be using alloc_skb/kfree_skb in net/ipv4/netfilter/ipt_recent.c::ip_recent_ctrl ?
Message-ID: <20050617023150.GS30011@ns.snowman.net>
Mail-Followup-To: "David S. Miller" <davem@davemloft.net>,
	jesper.juhl@gmail.com, juhl-lkml@dif.dk,
	linux-kernel@vger.kernel.org, laforge@netfilter.org
References: <Pine.LNX.4.62.0506170025140.2477@dragon.hyggekrogen.localhost> <20050616.154838.41634341.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jbeY2n/zRUOD7gar"
Content-Disposition: inline
In-Reply-To: <20050616.154838.41634341.davem@davemloft.net>
X-Editor: Vim http://www.vim.org/
X-Info: http://www.snowman.net
X-Operating-System: Linux/2.4.24ns.3.0 (i686)
X-Uptime: 22:23:07 up 5 days, 18:43,  5 users,  load average: 0.07, 0.10, 0.04
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--jbeY2n/zRUOD7gar
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* David S. Miller (davem@davemloft.net) wrote:
> It's using it to send a dummy packet to the patch function.
> It is gross, but it does work because it allocated it's own
> private data area to skb->nh.iph.

Seriously doubt ipt_recent is alone in that given I based the module off
an existing netfilter module and I'm pretty confident I didn't change
anything with regard to that aspect.

> Just leave it alone for now, ipt_recent is gross and full of many
> errors and bug, and thus stands to have a rewrite. Patrick McHardy
> said he will try to do that.

Ideally it should probably be rolled into the new ippool/ipset
framework, if it's capable of supporting what ipt_recent currently does.
I had heard vaugue claims that the new framework was supposted to be
able to support something like ipt_recent but I havn't looked into it
personally.

I'm mildly curious what the issues you have with it are but I've got
nothing against someone rewriting it as long as the functionality
remains the same.  It'd be nice to have a simpler module (perhaps the
new ippool stuff does this already, not sure) which just has a
hash-based table of IPs to match against since I know alot of people use
ipt_recent for that.  It'd also be nice to be able to do ranges and jump
to specific chains based on a hash-lookup to an IP/range.

	Stephen

--jbeY2n/zRUOD7gar
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFCsjYUrzgMPqB3kigRAtRiAJ9YsmymvFVCTVTMKqev+A2eAz1H3wCeIYqi
l+IwUeIIq1qL3RX/xoLYyUs=
=aX8c
-----END PGP SIGNATURE-----

--jbeY2n/zRUOD7gar--

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753933AbWKHCru@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753933AbWKHCru (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 21:47:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753940AbWKHCru
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 21:47:50 -0500
Received: from chilli.pcug.org.au ([203.10.76.44]:30179 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S1753933AbWKHCrt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 21:47:49 -0500
Date: Wed, 8 Nov 2006 13:47:44 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: Christoph Lameter <clameter@sgi.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, stable@kernel.org, akpm@osdl.org
Subject: Re: [PATCH] Fix sys_move_pages when a NULL node list is passed.
Message-Id: <20061108134744.ffc504ea.sfr@canb.auug.org.au>
In-Reply-To: <20061108111341.748d034a.kamezawa.hiroyu@jp.fujitsu.com>
References: <20061103144243.4601ba76.sfr@canb.auug.org.au>
	<20061108105648.4a149cca.kamezawa.hiroyu@jp.fujitsu.com>
	<Pine.LNX.4.64.0611071800250.7749@schroedinger.engr.sgi.com>
	<20061108111341.748d034a.kamezawa.hiroyu@jp.fujitsu.com>
X-Mailer: Sylpheed version 2.3.0beta4 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Wed__8_Nov_2006_13_47_44_+1100_QfM8F8A/ohkeMlV+"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Wed__8_Nov_2006_13_47_44_+1100_QfM8F8A/ohkeMlV+
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Wed, 8 Nov 2006 11:13:41 +0900 KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com> wrote:
>
> Ah.. I'm mentioning to this.
> ==
> +			pm[i].node = 0;	/* anything to not match MAX_NUMNODES */
> ==
> Sorry for my bad cut & paste.
>
> It seems that this 0 will be passed to alloc_pages_node().
> alloc_pages_node() doesn't check whether a node is online or not before using
> NODE_DATA().

Actually, it won't.  If you do that assignment, then the nodes parameter
was NULL and you will only call do_pages_stat() and so never call
alloc_pages_node().

--
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__8_Nov_2006_13_47_44_+1100_QfM8F8A/ohkeMlV+
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFUUVQFdBgD/zoJvwRAlkAAJ9xVpVPGVxzgTBXK43YZT06LIAuRACgg9U8
aG8yonkAKDqcPmYKXVM5m2I=
=FE0y
-----END PGP SIGNATURE-----

--Signature=_Wed__8_Nov_2006_13_47_44_+1100_QfM8F8A/ohkeMlV+--

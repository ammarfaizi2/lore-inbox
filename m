Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266781AbUGLK3M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266781AbUGLK3M (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 06:29:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266782AbUGLK3M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 06:29:12 -0400
Received: from mx1.redhat.com ([66.187.233.31]:63143 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266781AbUGLK3F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 06:29:05 -0400
Date: Mon, 12 Jul 2004 12:28:19 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: Lars Marowsky-Bree <lmb@suse.de>
Cc: Daniel Phillips <phillips@istop.com>, sdake@mvista.com,
       David Teigland <teigland@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Minneapolis Cluster Summit, July 29-30
Message-ID: <20040712102818.GB31013@devserv.devel.redhat.com>
References: <200407050209.29268.phillips@redhat.com> <200407101657.06314.phillips@redhat.com> <1089501890.19787.33.camel@persist.az.mvista.com> <200407111544.25590.phillips@istop.com> <20040711210624.GC3933@marowsky-bree.de> <1089615523.2806.5.camel@laptop.fenrus.com> <20040712100547.GF3933@marowsky-bree.de> <20040712101107.GA31013@devserv.devel.redhat.com> <20040712102124.GH3933@marowsky-bree.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="neYutvxvOLaeuPCA"
Content-Disposition: inline
In-Reply-To: <20040712102124.GH3933@marowsky-bree.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--neYutvxvOLaeuPCA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 12, 2004 at 12:21:24PM +0200, Lars Marowsky-Bree wrote:
> On 2004-07-12T12:11:07,
>    Arjan van de Ven <arjanv@redhat.com> said:
> 
> > well the problem is that you cannot prevent a syscall from blocking really.
> > O_NONBLOCK only impacts the waiting for IO/socket buffer space to not do so
> > (in general), it doesn't impact the memory allocation strategies by
> > syscalls. And there's a whopping lot of that in the non-boring syscalls...
> > So while your heartbeat process won't block during getpid, it'll eventually
> > need to do real work too .... and I'm quite certain that will lead down to
> > GFP_KERNEL memory allocations.
> 
> Sure, but the network IO is isolated from the main process via a _very
> careful_ non-blocking IO using sockets library, so that works out well.

... which of course never allocates skb's ? ;)

> However, of course this is more difficult for the case where you are in
> the write path needed to free some memory; alas, swapping to a GFS mount
> is probably a realllllly silly idea, too.

there is more than swap, there's dirty pagecache/mmaps as well

> But again, I'd rather like to see this solved (memory pools for
> userland, PF_ etc), because it's relevant for many scenarios requiring

PF_ is not enough really ;) 
You need to force GFP_NOFS etc for several critical parts, and well, by
being in kernel you can avoid a bunch of these allocations for real, and/or
influence their GFP flags

--neYutvxvOLaeuPCA
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFA8mfBxULwo51rQBIRAmjFAJ9g3zgawrsBJy27dPq1m6/oMLZfBgCbBJ8I
p4LXnv8PZfzCgNpEFC8Eo8U=
=l+QV
-----END PGP SIGNATURE-----

--neYutvxvOLaeuPCA--

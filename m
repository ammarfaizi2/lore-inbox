Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266115AbUIESmH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266115AbUIESmH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 14:42:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266901AbUIESmH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 14:42:07 -0400
Received: from mx1.redhat.com ([66.187.233.31]:41164 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266115AbUIESmC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 14:42:02 -0400
Date: Sun, 5 Sep 2004 20:41:46 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       "David S. Miller" <davem@davemloft.net>, akpm@osdl.org,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 0/3] beat kswapd with the proverbial clue-bat
Message-ID: <20040905184146.GA6849@devserv.devel.redhat.com>
References: <413AA7B2.4000907@yahoo.com.au> <20040904230210.03fe3c11.davem@davemloft.net> <413AAF49.5070600@yahoo.com.au> <413AE6E7.5070103@yahoo.com.au> <Pine.LNX.4.58.0409051021290.2331@ppc970.osdl.org> <1094405830.2809.8.camel@laptop.fenrus.com> <Pine.LNX.4.58.0409051051120.2331@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UlVJffcvxoiEqYs2"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0409051051120.2331@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Sep 05, 2004 at 10:58:07AM -0700, Linus Torvalds wrote:
> 
> 
> On Sun, 5 Sep 2004, Arjan van de Ven wrote:
> > 
> > well... we have a reverse mapping now. What is stopping us from doing
> > physical defragmentation ?
> 
> Nothing but replacement policy, really, and the fact that not everything
> is rmappable.
> 
> I think we should _normally_ honor replacement policy, the way we do now.  

yes it absolutely is quite a heavy hammer. 
However right now the alternative (free a LOT of memory and hope it
collapses into higher order ones) is even heavier, freeing the wrong 8 pages
is less of a disturbance than freeing 8000 of the mostly wrong pages ;) 

I absolutely agree this heavy hammer only should trigger if there is a
request for a higher order page that isn't there. Doing it from a special
thread does make sense, makes it relatively easy to keep track of such
wakeups and more importantly rate limit them etc.


--UlVJffcvxoiEqYs2
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFBO13qxULwo51rQBIRAh29AJ9G+qbI1kjC+mlEAT/Puc1a6fBTXACeMEaB
6PTpaCS/kHTID9QBijMFhZM=
=aGN8
-----END PGP SIGNATURE-----

--UlVJffcvxoiEqYs2--

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262896AbVD2TcF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262896AbVD2TcF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 15:32:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262902AbVD2TcF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 15:32:05 -0400
Received: from palrel12.hp.com ([156.153.255.237]:29140 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S262896AbVD2TcB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 15:32:01 -0400
Date: Fri, 29 Apr 2005 12:33:54 -0700
From: Grant Grundler <iod00d@hp.com>
To: Brice Goglin <Brice.Goglin@ens-lyon.org>
Cc: Roland Dreier <roland@topspin.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, openib-general@openib.org,
       hch@infradead.org, Caitlin Bestler <caitlin.bestler@gmail.com>
Subject: Re: [openib-general] Re: RDMA memory registration
Message-ID: <20050429193354.GJ24871@esmail.cup.hp.com>
References: <20050426084234.A10366@topspin.com> <52mzrlsflu.fsf@topspin.com> <20050426122850.44d06fa6.akpm@osdl.org> <5264y9s3bs.fsf@topspin.com> <426EA220.6010007@ammasso.com> <20050426133752.37d74805.akpm@osdl.org> <5ebee0d105042907265ff58a73@mail.gmail.com> <469958e005042908566f177b50@mail.gmail.com> <52d5sdjzup.fsf_-_@topspin.com> <42727B60.7010507@ens-lyon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42727B60.7010507@ens-lyon.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2005 at 08:22:24PM +0200, Brice Goglin wrote:
> For instance, instead of adding PROT_DONT/ALWAYSCOPY, you may use
> an ioproc hook in the fork path. This hook (a function in your driver)
> would be called for each registered page. It will decide whether
> the page should be pre-copied or not and update the registration
> table (or whatever stores address translations in the NIC).
> In addition, the driver would probably pre-copy cow pages when
> registering them.

This doesn't scale well as more cards are added to the box.
I think I understand why it's good for single cards though.

> It's nice to see these two works coming to LKML at the same time.
> It would be great if we could merge them and get a generic solution
> that's suitable to both registration based cards (IB/Myri/Ammasso)
> and MMU-based cards (Quadrics).

Aren't the mellanox mem-free cards more or less MMU's as well?
I had that impression after attending Dror Goldberg's talk
though I don't think he asserted that.
Openib.org developers conf (Feb 2005) slideset is here:
	http://www.openib.org/docs/oib_wkshp_022005/memfree-hca-mellanox-dgoldenberg.pdf

Being mostly clueless about Quadrics implementation, I'm probably
missing something that makes Quadrics a MMU but not the IB variants.
Can someone clue me in please?

thanks,
grant

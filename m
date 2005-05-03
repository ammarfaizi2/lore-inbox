Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261784AbVECPfT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261784AbVECPfT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 11:35:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261789AbVECPfS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 11:35:18 -0400
Received: from palrel12.hp.com ([156.153.255.237]:65230 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S261784AbVECPe6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 11:34:58 -0400
Date: Tue, 3 May 2005 08:36:51 -0700
From: Grant Grundler <iod00d@hp.com>
To: David Addison <addy@quadrics.com>
Cc: Brice Goglin <Brice.Goglin@ens-lyon.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, openib-general@openib.org,
       hch@infradead.org, Caitlin Bestler <caitlin.bestler@gmail.com>
Subject: Re: [openib-general] Re: RDMA memory registration
Message-ID: <20050503153651.GB11344@esmail.cup.hp.com>
References: <20050426122850.44d06fa6.akpm@osdl.org> <5264y9s3bs.fsf@topspin.com> <426EA220.6010007@ammasso.com> <20050426133752.37d74805.akpm@osdl.org> <5ebee0d105042907265ff58a73@mail.gmail.com> <469958e005042908566f177b50@mail.gmail.com> <52d5sdjzup.fsf_-_@topspin.com> <42727B60.7010507@ens-lyon.org> <20050429193354.GJ24871@esmail.cup.hp.com> <42773964.1030101@quadrics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42773964.1030101@quadrics.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 03, 2005 at 09:42:12AM +0100, David Addison wrote:
> >This doesn't scale well as more cards are added to the box.
> >I think I understand why it's good for single cards though.
>
> With the IOPROC patch the device driver hooks are registered on a per 
> process or perhaps better still, a per VMA basis.

I was originally thinking the registrations are global (for all memory)
and not per process. Per process or per VMA seems reasonable to me.

> And for processes/VMAs where there are no registrations the overhead
> is very low.

Yes - thanks. I'm still reading the LKML thread you started:
	http://lkml.org/lkml/2005/4/26/198

In particular, the comments from Brice Goglin:
	http://lkml.org/lkml/2005/4/26/222

openib.org folks can find the IOPROC patch for 2.6.12-rc3 archived here:
	http://lkml.org/lkml/diff/2005/4/26/198/1

> With multiple cards in a box, all using different device drivers,
> I guess there could end up being multiple registrations per process/VMA.
> But I'm not sure this will be a common case for RDMA use in real life.

I agree. Gateways between fabrics is the only case I can think of.
This won't be a problem until someone at a large national lab tries
to connect two "legacy" fabrics together.

thanks,
grant

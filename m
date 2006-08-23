Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965220AbWHWVgq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965220AbWHWVgq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 17:36:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965219AbWHWVgq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 17:36:46 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:62609 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S965217AbWHWVgp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 17:36:45 -0400
Date: Wed, 23 Aug 2006 16:36:42 -0500
To: Arnd Bergmann <arnd@arndb.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, netdev@vger.kernel.org,
       James K Lewis <jklewis@us.ibm.com>, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 2/6]: powerpc/cell spidernet low watermark patch.
Message-ID: <20060823213642.GG4401@austin.ibm.com>
References: <20060818220700.GG26889@austin.ibm.com> <200608190109.15129.arnd@arndb.de> <1156055509.5803.77.camel@localhost.localdomain> <200608201203.15645.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608201203.15645.arnd@arndb.de>
User-Agent: Mutt/1.5.11
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 20, 2006 at 12:03:14PM +0200, Arnd Bergmann wrote:
> On Sunday 20 August 2006 08:31, Benjamin Herrenschmidt wrote:
> > > card->low_watermark->next->dmac_cmd_status |= SPIDER_NET_DESCR_TXDESFLG;
> > > mb();
> > > card->low_watermark->dmac_cmd_status &= ~SPIDER_NET_DESCR_TXDESFLG;
> > > card->low_watermark = card->low_watermark->next;
> > > 
> > > when we queue another frame for TX.
> > 
> > I would have expected those to be racy vs. the hardware... what if the
> > hardware is updating dmac_cmd_status just as your are trying to and the
> > bit out of it ?
> 
> Right, that doesn't work. It is the only bit we use in that byte though,
> so maybe it can be done with a single byte write.

Thanks, you're right, I missed that.  I'll change this to byte access 
shortly.  Any recommendations for style/api for byte access? 

I could create a searate patch to change struct descr {} to split 
the u32 into several u8's; there's a dozen spots that get touched.

Alternatel, I could do a cheesy cast to char[4] and access that way.
Opinions?

--linas

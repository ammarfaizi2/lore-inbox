Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932192AbWEASyS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932192AbWEASyS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 14:54:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932193AbWEASyS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 14:54:18 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:51399 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932192AbWEASyS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 14:54:18 -0400
Subject: Re: [PATCH 5 of 13] ipath - use proper address translation routine
From: Arjan van de Ven <arjan@infradead.org>
To: Roland Dreier <rdreier@cisco.com>
Cc: "Bryan O'Sullivan" <bos@pathscale.com>, openib-general@openib.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <ada3bftvatf.fsf@cisco.com>
References: <1ab168913f0fea5d18b4.1145913781@eng-12.pathscale.com>
	 <ada3bftvatf.fsf@cisco.com>
Content-Type: text/plain
Date: Mon, 01 May 2006 20:54:06 +0200
Message-Id: <1146509646.20760.63.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-05-01 at 11:50 -0700, Roland Dreier wrote:
>     Bryan> Move away from an obsolete, unportable routine for
>     Bryan> translating physical addresses.
> 
> This change:
> 
>  > -		isge->vaddr = bus_to_virt(sge->addr);
>  > +		isge->vaddr = phys_to_virt(sge->addr);
> 
> is really wrong.  bus_to_virt() is really what you want, because in
> this case the address is a bus address that came from dma_map_xxx().
> You're still going to be hosed on systems with IOMMUs for example.

do you really NEED the vaddr? 
(most of the time linux drivers don't need it, while other OSes do)
If you really need it you should grab it at dma_map time ...
(and realize that it's not kernel addressable per se ;)


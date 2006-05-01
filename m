Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932197AbWEATUI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932197AbWEATUI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 15:20:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932199AbWEATUI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 15:20:08 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:34702 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932197AbWEATUG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 15:20:06 -0400
Subject: Re: [PATCH 5 of 13] ipath - use proper address translation routine
From: Arjan van de Ven <arjan@infradead.org>
To: Roland Dreier <rdreier@cisco.com>
Cc: "Bryan O'Sullivan" <bos@pathscale.com>, openib-general@openib.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <aday7xltvtb.fsf@cisco.com>
References: <1ab168913f0fea5d18b4.1145913781@eng-12.pathscale.com>
	 <ada3bftvatf.fsf@cisco.com>
	 <1146509646.20760.63.camel@laptopd505.fenrus.org>
	 <aday7xltvtb.fsf@cisco.com>
Content-Type: text/plain
Date: Mon, 01 May 2006 21:20:00 +0200
Message-Id: <1146511201.20760.65.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-05-01 at 12:00 -0700, Roland Dreier wrote:
>     Arjan> do you really NEED the vaddr?  (most of the time linux
>     Arjan> drivers don't need it, while other OSes do) If you really
>     Arjan> need it you should grab it at dma_map time ...  (and
>     Arjan> realize that it's not kernel addressable per se ;)
> 
> Yes, they need some kind of vaddr.
> 
> It's kind of a layering problem.  The IB stack assumes that IB devices
> have a DMA engine that deals with bus addresses.  But the ipath driver
> has to simulate this by using a memcpy on the CPU to move data to the
> PCI device.
> 
> I really don't know what the right solution is.  Maybe having some way
> to override the dma mapping operations so that the ipath driver can
> keep the info it needs?

sounds like you need to redesign your layering ;)
In linux it's common to have the lowest level driver do the mapping
(even when the mid layer will provide the most commonly used helper to
do it for the common case)...



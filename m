Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933101AbWF2Xe0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933101AbWF2Xe0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 19:34:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933087AbWF2Xe0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 19:34:26 -0400
Received: from mx.pathscale.com ([64.160.42.68]:64409 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932645AbWF2XeY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 19:34:24 -0400
Subject: Re: [PATCH 39 of 39] IB/ipath - use streaming copy in RDMA
	interrupt handler to reduce packet loss
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: David Miller <davem@davemloft.net>
Cc: akpm@osdl.org, rdreier@cisco.com, mst@mellanox.co.il,
       openib-general@openib.org, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
In-Reply-To: <20060629.150319.104035601.davem@davemloft.net>
References: <1b00209ef20a0e7893d8.1151617290@eng-12.pathscale.com>
	 <20060629.145027.41636491.davem@davemloft.net>
	 <1151618377.10886.23.camel@chalcedony.pathscale.com>
	 <20060629.150319.104035601.davem@davemloft.net>
Content-Type: text/plain
Date: Thu, 29 Jun 2006 16:34:23 -0700
Message-Id: <1151624063.10886.34.camel@chalcedony.pathscale.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-06-29 at 15:03 -0700, David Miller wrote:

> I'm not good with names :-)

Heh.  I'll call it memcpy_nc for now, then, and people can retch all
over the name as they please when I submit a more suitably generic
patch.

> Note that there also might be cases where using such a memcpy
> variant might be the wrong thing to do.  For example, for a very
> tightly coupled CMT cpu implementation which has the memory controller,
> L2 cache, PCI controller, etc. all on the same die and the PCI controller
> makes use of the L2 cache just like the cpu threads do, using this
> kind of memcpy would always be the wrong thing to do.

I'm not quite following you, though I assume you're referring to Niagara
or Rock :-)  Are you saying a memcpy_nc would do worse than plain
memcpy, or worse than some other memcpy-like routine?

	<b


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750763AbWIAUp3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750763AbWIAUp3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 16:45:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750803AbWIAUp3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 16:45:29 -0400
Received: from mx.pathscale.com ([64.160.42.68]:41858 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1750763AbWIAUp2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 16:45:28 -0400
Subject: Re: [openib-general] 2.6.18-rc5-mm1:
	drivers/infiniband/hw/amso1100/c2.c compile error
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Roland Dreier <rdreier@cisco.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       openib-general@openib.org, Adrian Bunk <bunk@stusta.de>,
       "David S. Miller" <davem@davemloft.net>
In-Reply-To: <ada8xl3ics4.fsf@cisco.com>
References: <20060901015818.42767813.akpm@osdl.org>
	 <20060901160023.GB18276@stusta.de> <20060901101340.962150cb.akpm@osdl.org>
	 <adak64nij8f.fsf@cisco.com> <20060901112312.5ff0dd8d.akpm@osdl.org>
	 <ada8xl3ics4.fsf@cisco.com>
Content-Type: text/plain
Date: Fri, 01 Sep 2006 13:45:27 -0700
Message-Id: <1157143527.20958.8.camel@chalcedony.pathscale.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-09-01 at 12:53 -0700, Roland Dreier wrote:

> Yes, I agree that's a good plan, especially the documentation part.
> However I would argue that what's in drivers/infiniband/hw/mthca/mthca_doorbell.h 
> is legitimate: the driver uses __raw_writeq() when it exists and uses
> two __raw_writel()s properly serialized with a device-specific lock to
> get exactly the atomicity it needs on 32-bit archs.

On the off chance that you might be arguing that mthca_write64 could be
a candidate drop-in for writeq on 32-bit arches:

That approach might work on mthca hardware, but it's not safe in
general.  The ipath driver requires a proper writeq(), for example,
because the hardware will quite legitimately treat 32-bit writes to some
registers as separate accesses, and screw things up royally.

You get atomicity from the perspective of software with this approach,
but you can do exciting and bad things to hardware.

	<b


-- 
VGER BF report: H 3.23386e-12

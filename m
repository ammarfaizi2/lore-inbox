Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932436AbVL1BKT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932436AbVL1BKT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 20:10:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932437AbVL1BKT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 20:10:19 -0500
Received: from sj-iport-3-in.cisco.com ([171.71.176.72]:56214 "EHLO
	sj-iport-3.cisco.com") by vger.kernel.org with ESMTP
	id S932436AbVL1BKS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 20:10:18 -0500
X-IronPort-AV: i="3.99,299,1131350400"; 
   d="scan'208"; a="384058345:sNHT30212124"
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: linux-kernel@vger.kernel.org, mpm@selenic.com, akpm@osdl.org,
       hch@infradead.org
Subject: Re: [PATCH 1 of 3] Introduce __memcpy_toio32
X-Message-Flag: Warning: May contain useful information
References: <7b7b442a4d6338ae8ca7.1135726915@eng-12.pathscale.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Tue, 27 Dec 2005 17:10:14 -0800
In-Reply-To: <7b7b442a4d6338ae8ca7.1135726915@eng-12.pathscale.com> (Bryan
 O'Sullivan's message of "Tue, 27 Dec 2005 15:41:55 -0800")
Message-ID: <adazmmmc9hl.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.17 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-OriginalArrivalTime: 28 Dec 2005 01:10:16.0195 (UTC) FILETIME=[764E8D30:01C60B4B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A couple of comments here:

 > +/*
 > + * Copy data to an MMIO region.  MMIO space accesses are performed
 > + * in the sizes indicated in each function's name.
 > + */
 > +void fastcall __memcpy_toio32(volatile void __iomem *d, const void *s, size_t count)
 > +{
 > +	volatile u32 __iomem *dst = d;
 > +	const u32 *src = s;
 > +
 > +	while (--count >= 0) {
 > +		__raw_writel(*src++, dst++);
 > +	}

I think the principle of least surprise calls for memcpy_toio32 to be
ordered the same way memcpy_toio is.  In other words there should be a
wmb() after the loop.

Also, no need for the { } for the while loop.

 > +}
 > +
 > +EXPORT_SYMBOL_GPL(__memcpy_toio32);

You're adding this symbol and exporting it even if the arch will
supply its own version.  So this is pure kernel .text bloat...

 - R.

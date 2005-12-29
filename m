Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750708AbVL2Of6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750708AbVL2Of6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 09:35:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750731AbVL2Of6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 09:35:58 -0500
Received: from general.keba.co.at ([193.154.24.243]:742 "EHLO helga.keba.co.at")
	by vger.kernel.org with ESMTP id S1750708AbVL2Of5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 09:35:57 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: SLAB-related panic in 2.6.15-rc7-rt1 on ARM
Date: Thu, 29 Dec 2005 15:35:54 +0100
Message-ID: <AAD6DA242BC63C488511C611BD51F367323305@MAILIT.keba.co.at>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: SLAB-related panic in 2.6.15-rc7-rt1 on ARM
Thread-Index: AcYMgYuQ6UC22iBIRVi8jsgKcB0acgAApmog
From: "kus Kusche Klaus" <kus@keba.com>
To: "Pekka J Enberg" <penberg@cs.Helsinki.FI>
Cc: "Ingo Molnar" <mingo@elte.hu>,
       "linux-kernel" <linux-kernel@vger.kernel.org>, <clameter@sgi.com>,
       <mpm@selenic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Pekka J Enberg
> On Thu, 29 Dec 2005, kus Kusche Klaus wrote:
> > (note the very early BUG and two "MM: invalid domain"):
> 
> I think you'll get those with slob as well. The slab 
> allocator hasn't had 
> the chance to initialize itself yet so they're probably not related.

You're right, these two messages also show up with slob.

> > Unhandled fault: alignment exception (0xc0207003) at 0x00000163
> > PC is at get_page_from_freelist+0x1c/0x400
> > LR is at __alloc_pages+0x68/0x2c0
> 
> I am still betting on alloc_pages_node(). You could try the 
> following to 
> prove me wrong. It's not a real fix though.

You're right again, this one-liner makes slab work.
(by the way, line numbers differ by miles?)

> -	page = alloc_pages_node(nodeid, flags, cachep->gfporder);
> +	page = alloc_pages(flags, cachep->gfporder);

Thanks!

-- 
Klaus Kusche                 (Software Development - Control Systems)
KEBA AG             Gewerbepark Urfahr, A-4041 Linz, Austria (Europe)
Tel: +43 / 732 / 7090-3120                 Fax: +43 / 732 / 7090-6301
E-Mail: kus@keba.com                                WWW: www.keba.com

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135545AbREBPKu>; Wed, 2 May 2001 11:10:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135574AbREBPKk>; Wed, 2 May 2001 11:10:40 -0400
Received: from geos.coastside.net ([207.213.212.4]:48599 "EHLO
	geos.coastside.net") by vger.kernel.org with ESMTP
	id <S135545AbREBPKW>; Wed, 2 May 2001 11:10:22 -0400
Mime-Version: 1.0
Message-Id: <p05100343b715d114a239@[207.213.214.37]>
In-Reply-To: <Pine.LNX.4.31.0105011542410.2667-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.31.0105011542410.2667-100000@penguin.transmeta.com>
Date: Wed, 2 May 2001 08:10:10 -0700
To: Linus Torvalds <torvalds@transmeta.com>
From: Jonathan Lundell <jlundell@pobox.com>
Subject: Re: isa_read/write not available on ppc - solution suggestions ??
Cc: <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 3:46 PM -0700 2001-05-01, Linus Torvalds wrote:
>On Tue, 1 May 2001, Russell King wrote:
>  >
>>  In which case, can we change the following in IO-mapping.txt please?
>
>Oh, sorry. I misread your question. The _return_ value is a cookie.
>
>The first argument should basically be the start of a "struct pci_dev"
>resource entry, but obviously architecture-specific code can (and does)
>know what the thing means. And the ISA space (ie 0xA0000-0x100000) has
>been considered an acceptable special case.
>
>So the only usage that is "portable" is to do something like
>
>	cookie = ioremap(pdev->resource[0].start, pdev->resource[0].len);
>
>and I guess we should actually create some helper functions for that too.
>
>You can use ioremap in other ways, but there's nothing to say that they
>will work reliably across multiple PCI buses etc.

What's the Linu[sx] attitude to using a type to help control (and 
illuminate) the use of these objects? I'm thinking here in particular 
of the cookie returned by ioremap() and used by readx/writex, but I 
suppose there might be similar applicability to its first parameter.
-- 
/Jonathan Lundell.

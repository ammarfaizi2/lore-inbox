Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315525AbSEQJqK>; Fri, 17 May 2002 05:46:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315526AbSEQJqJ>; Fri, 17 May 2002 05:46:09 -0400
Received: from gw.chygwyn.com ([62.172.158.50]:9745 "EHLO gw.chygwyn.com")
	by vger.kernel.org with ESMTP id <S315525AbSEQJqJ>;
	Fri, 17 May 2002 05:46:09 -0400
From: Steven Whitehouse <steve@gw.chygwyn.com>
Message-Id: <200205170926.KAA30210@gw.chygwyn.com>
Subject: Re: Kernel deadlock using nbd over acenic driver.
To: ptb@it.uc3m.es
Date: Fri, 17 May 2002 10:26:59 +0100 (BST)
Cc: oxymoron@waste.org (Oliver Xymoron),
        chen_xiangping@emc.com (chen xiangping),
        jes@wildopensource.com ('Jes Sorensen'), linux-kernel@vger.kernel.org
In-Reply-To: <200205170701.g4H71CB25476@oboe.it.uc3m.es> from "Peter T. Breuer" at May 17, 2002 09:01:12 AM
Organization: ChyGywn Limited
X-RegisteredOffice: 7, New Yatt Road, Witney, Oxfordshire. OX28 1NU England
X-RegisteredNumber: 03887683
Reply-To: Steve Whitehouse <Steve@ChyGwyn.com>
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> 
> "Steven Whitehouse wrote:"
> > Thats effectively what PF_MEMALLOC does. The code in question is in
> > page_alloc.c:__alloc_pages just before and after the rebalance: label.
> > The z->pages_min gives a per zone minimum for "other processes" that are
> > not PF_MEMALLOC,
> 
> A related question, then ... can one adjust the difference between the
> ceiling for "normal" processes and PF_MEMALLOC processes, and if so,
> how?
> 
> Peter
> 

In page_alloc.c:__alloc_pages() the minimum is calculated for each memory
zone as (1UL << order) plus z->pages_low for each zone scanned whilst
looking for memory. Various scans are done, but z->pages_min is the key
number from which the limits are calculated.

It appears that z->pages_min is initialized in 
page_alloc.c:free_area_init_core() to the real size of the zone divided
by zone_balance_ratio[] (set to 128 by default) for that zone and clamped to 
zone_balance_max[] (set to 255 by default) and zone_balance_min[] (set to 20
by default).

It appears that the memfrac= command line option should allow tweeking
of zone_balance_ratio[] but if you've got more than approx 128M of memory it
would appear (if I've understood this correctly) that you'll have the
maximum of 255 pages for z->pages_min.

Steve.



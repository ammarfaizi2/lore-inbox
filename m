Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030373AbVKCQU5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030373AbVKCQU5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 11:20:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030375AbVKCQU5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 11:20:57 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:48770 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030373AbVKCQU4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 11:20:56 -0500
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
From: Arjan van de Ven <arjan@infradead.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: "Martin J. Bligh" <mbligh@mbligh.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Dave Hansen <haveblue@us.ibm.com>, Ingo Molnar <mingo@elte.hu>,
       Mel Gorman <mel@csn.ul.ie>, Andrew Morton <akpm@osdl.org>,
       kravetz@us.ibm.com, linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lhms <lhms-devel@lists.sourceforge.net>,
       Arjan van de Ven <arjanv@infradead.org>
In-Reply-To: <Pine.LNX.4.64.0511030747450.27915@g5.osdl.org>
References: <4366C559.5090504@yahoo.com.au>
	 <Pine.LNX.4.58.0511010137020.29390@skynet> <4366D469.2010202@yahoo.com.au>
	 <Pine.LNX.4.58.0511011014060.14884@skynet> <20051101135651.GA8502@elte.hu>
	 <1130854224.14475.60.camel@localhost> <20051101142959.GA9272@elte.hu>
	 <1130856555.14475.77.camel@localhost> <20051101150142.GA10636@elte.hu>
	 <1130858580.14475.98.camel@localhost> <20051102084946.GA3930@elte.hu>
	 <436880B8.1050207@yahoo.com.au> <1130923969.15627.11.camel@localhost>
	 <43688B74.20002@yahoo.com.au> <255360000.1130943722@[10.10.2.4]>
	 <4369824E.2020407@yahoo.com.au>  <306020000.1131032193@[10.10.2.4]>
	 <1131032422.2839.8.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.64.0511030747450.27915@g5.osdl.org>
Content-Type: text/plain
Date: Thu, 03 Nov 2005 17:20:32 +0100
Message-Id: <1131034832.2839.13.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 2.9 (++)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (2.9 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	2.8 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-11-03 at 07:51 -0800, Linus Torvalds wrote:
> 
> On Thu, 3 Nov 2005, Arjan van de Ven wrote:
> 
> > On Thu, 2005-11-03 at 07:36 -0800, Martin J. Bligh wrote:
> > > >> Can we quit coming up with specialist hacks for hotplug, and try to solve
> > > >> the generic problem please? hotplug is NOT the only issue here. Fragmentation
> > > >> in general is.
> > > >> 
> > > > 
> > > > Not really it isn't. There have been a few cases (e1000 being the main
> > > > one, and is fixed upstream) where fragmentation in general is a problem.
> > > > But mostly it is not.
> > > 
> > > Sigh. OK, tell me how you're going to fix kernel stacks > 4K please. 
> > 
> > with CONFIG_4KSTACKS :)
> 
> 2-page allocations are _not_ a problem.

agreed for the general case. There are some corner cases that you can
trigger deliberate in an artifical setting with lots of java threads
(esp on x86 on a 32Gb box; the lowmem zone works as a lever here leading
to "hyperfragmentation"; otoh on x86 you can do 4k stacks and it's gone
mostly)


> Fragmentation means that it gets _exponentially_ more unlikely that you 
> can allocate big contiguous areas. But contiguous areas of order 1 are 
> very very likely indeed. It's only the _big_ areas that aren't going to 
> happen.

yup. only possible exception is the leveraged scenario .. thank god for
64 bit x86-64.



(and in the leveraged scenario I don't think active defragmentation will
buy you much over the long term at all)


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750726AbVKOKAH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750726AbVKOKAH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 05:00:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751417AbVKOKAH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 05:00:07 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:10682 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750726AbVKOKAF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 05:00:05 -0500
Subject: Re: [PATCH 03/05] mm rationalize __alloc_pages ALLOC_* flag names
From: Arjan van de Ven <arjan@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, pj@sgi.com,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org, Simon.Derr@bull.net,
       clameter@sgi.com, rohit.seth@intel.com
In-Reply-To: <20051115010303.6bc04222.akpm@osdl.org>
References: <20051114040329.13951.39891.sendpatchset@jackhammer.engr.sgi.com>
	 <20051114040353.13951.82602.sendpatchset@jackhammer.engr.sgi.com>
	 <4379A399.1080407@yahoo.com.au>  <20051115010303.6bc04222.akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 15 Nov 2005 10:59:57 +0100
Message-Id: <1132048798.2822.15.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 1.8 (+)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (1.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[213.93.14.173 listed in dnsbl.sorbs.net]
	1.7 RCVD_IN_NJABL_DUL      RBL: NJABL: dialup sender did non-local SMTP
	[213.93.14.173 listed in combined.njabl.org]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-11-15 at 01:03 -0800, Andrew Morton wrote:
> Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> >
> > Paul Jackson wrote:
> > > Rationalize mm/page_alloc.c:__alloc_pages() ALLOC flag names.
> > > 
> > 
> > I don't really see the need for this. The names aren't
> > clearly better, and the downside is that they move away
> > from the terminlogy we've been using in the page allocator
> > for the past few years.
> 
> I thought they were heaps better, actually.
> 
> -#define ALLOC_NO_WATERMARKS	0x01 /* don't check watermarks at all */
> -#define ALLOC_HARDER		0x02 /* try to alloc harder */
> -#define ALLOC_HIGH		0x04 /* __GFP_HIGH set */
> +#define ALLOC_DONT_DIP	0x01 	/* don't dip into memory reserves */
> +#define ALLOC_DIP_SOME	0x02 	/* dip into reserves some */
> +#define ALLOC_DIP_ALOT	0x04 	/* dip into reserves further */
> +#define ALLOC_MUSTHAVE	0x08 	/* ignore all constraints */
> 
> very explicit.

maybe. 
however... if names get changed anyway, maybe name them based on intent?

ALLOC_NORMAL  
ALLOC_KERNELTHREAD
ALLOC_VMCAUSED
ALLOC_WOULDDEADLOCK 

or something.. yes these are lame

perhaps both are needed.. bitflags for the implementation, and defines
based on usage that are compounded bitflags..



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964859AbWHLPHb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964859AbWHLPHb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 11:07:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964858AbWHLPHb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 11:07:31 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:52516 "EHLO
	amsfep18-int.chello.nl") by vger.kernel.org with ESMTP
	id S964856AbWHLPHa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 11:07:30 -0400
Subject: rename *MEMALLOC flags (was: Re: [RFC][PATCH 3/4] deadlock
	prevention core)
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       Indan Zupancic <indan@nul.nu>, Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       Daniel Phillips <phillips@google.com>, Rik van Riel <riel@redhat.com>,
       David Miller <davem@davemloft.net>
In-Reply-To: <44DDE8B6.8000900@garzik.org>
References: <20060812141415.30842.78695.sendpatchset@lappy>
	 <20060812141445.30842.47336.sendpatchset@lappy>
	 <44DDE8B6.8000900@garzik.org>
Content-Type: text/plain
Date: Sat, 12 Aug 2006 17:06:41 +0200
Message-Id: <1155395201.13508.44.camel@lappy>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-08-12 at 10:41 -0400, Jeff Garzik wrote:
> Peter Zijlstra wrote:
> > Index: linux-2.6/include/linux/gfp.h
> > ===================================================================
> > --- linux-2.6.orig/include/linux/gfp.h	2006-08-12 12:56:06.000000000 +0200
> > +++ linux-2.6/include/linux/gfp.h	2006-08-12 12:56:09.000000000 +0200
> > @@ -46,6 +46,7 @@ struct vm_area_struct;
> >  #define __GFP_ZERO	((__force gfp_t)0x8000u)/* Return zeroed page on success */
> >  #define __GFP_NOMEMALLOC ((__force gfp_t)0x10000u) /* Don't use emergency reserves */
> >  #define __GFP_HARDWALL   ((__force gfp_t)0x20000u) /* Enforce hardwall cpuset memory allocs */
> > +#define __GFP_MEMALLOC  ((__force gfp_t)0x40000u) /* Use emergency reserves */
> 
> This symbol name has nothing to do with its purpose.  The entire area of 
> code you are modifying could be described as having something to do with 
> 'memalloc'.
> 
> GFP_EMERGENCY or GFP_USE_RESERVES or somesuch would be a far better 
> symbol name.
> 
> I recognize that is matches with GFP_NOMEMALLOC, but that doesn't change 
> the situation anyway.  In fact, a cleanup patch to rename GFP_NOMEMALLOC 
> would be nice.

I'm rather bad at picking names, but here goes:

PF_MEMALLOC      -> PF_EMERGALLOC
__GFP_NOMEMALLOC -> __GFP_NOEMERGALLOC
__GFP_MEMALLOC   -> __GFP_EMERGALLOC

Is that suitable and shall I prepare patches? Or do we want more ppl to
chime in and have a few more rounds?


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932462AbVJGMdm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932462AbVJGMdm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 08:33:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932500AbVJGMdm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 08:33:42 -0400
Received: from mail28.syd.optusnet.com.au ([211.29.133.169]:43434 "EHLO
	mail28.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932462AbVJGMdl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 08:33:41 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Pekka J Enberg <penberg@cs.helsinki.fi>
Subject: Re: [PATCH] vm - swap_prefetch-15
Date: Fri, 7 Oct 2005 22:33:11 +1000
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org, ck@vds.kolivas.org
References: <200510070001.01418.kernel@kolivas.org> <200510072208.01357.kernel@kolivas.org> <Pine.LNX.4.58.0510071511040.6755@sbz-30.cs.Helsinki.FI>
In-Reply-To: <Pine.LNX.4.58.0510071511040.6755@sbz-30.cs.Helsinki.FI>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510072233.12216.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Oct 2005 22:26, Pekka J Enberg wrote:
> On Fri, 7 Oct 2005, Con Kolivas wrote:
> > Makes sense but it is only used in the CONFIG_SWAP_PREFETCH case so it
> > would end up as a static inline in swap.h to avoid ending being #ifdefed
> > in page_alloc.c. Do you think that's preferable to having it in
> > swap_prefetch.c ?
>
> But then you would still have to open up buffered_rmqueue() and
> zone_statistics() to everyone, no? 

bah of course..  /me slaps forehead

> How about you implement a new gfp flag 
> __GFP_NEVER_RECLAIM similar to __GFP_NORECLAIM instead so you don't have
> to duplicate __page_alloc()?

That will end up being far more intrusive than this version and __alloc_pages 
would need more tests that affect every call to __alloc_pages which seems 
much more expensive to me than exporting buffered_rmqueue and 
zone_statistics, and the modified __alloc_pages will still be a much more 
complicated function than prefetch_get_page. 

Thanks,
Con

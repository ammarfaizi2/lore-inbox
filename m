Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932436AbWGHAXZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932436AbWGHAXZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 20:23:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932440AbWGHAXY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 20:23:24 -0400
Received: from cantor.suse.de ([195.135.220.2]:52888 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932437AbWGHAXX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 20:23:23 -0400
From: Andi Kleen <ak@suse.de>
To: Christoph Lameter <clameter@sgi.com>
Subject: Re: [RFC 4/8] page allocator: Optional ZONE_DMA
Date: Sat, 8 Jul 2006 02:23:01 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org, Nick Piggin <nickpiggin@yahoo.com.au>,
       Christoph Hellwig <hch@infradead.org>,
       Marcelo Tosatti <marcelo@kvack.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Martin Bligh <mbligh@google.com>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
References: <20060708000501.3829.25578.sendpatchset@schroedinger.engr.sgi.com> <20060708000522.3829.85832.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20060708000522.3829.85832.sendpatchset@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607080223.01380.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 08 July 2006 02:05, Christoph Lameter wrote:
> Make ZONE_DMA optional in the page allocator

Hmm, we should rename you the "ifdef warrior"

> - ifdef all code for ZONE_DMA and related definition
> 
> - Without ZONE_DMA, ZONE_HIGHMEM and ZONE_DMA32 we fall back
>   to an empty GFP_ZONEMASK and a ZONES_SHIFT of zero (since there
>   is only one zone....).
> 
> - We need to fix the use of ZONE_DMA in the memory policy layer.
>   ZONE_DMA is used there as the first zone so use 0 instead.


Is the barely better code really worth all the ugliness from the ifdefs? I have doubts.

I think your idea of saving some cache lines by not having the unused
zones in the fallback lists etc. is a good one, but your current implementation
with its ifdef maze is extremly ugly. Surely this can be a done less
intrusively?

-Andi

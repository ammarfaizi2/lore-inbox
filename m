Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751583AbVKBLEj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751583AbVKBLEj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 06:04:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751584AbVKBLEj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 06:04:39 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:19938 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751582AbVKBLEi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 06:04:38 -0500
To: Ingo Molnar <mingo@elte.hu>
cc: Kamezawa Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
       Dave Hansen <haveblue@us.ibm.com>, Mel Gorman <mel@csn.ul.ie>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       "Martin J. Bligh" <mbligh@mbligh.org>, Andrew Morton <akpm@osdl.org>,
       kravetz@us.ibm.com, linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lhms <lhms-devel@lists.sourceforge.net>
Reply-To: Gerrit Huizenga <gh@us.ibm.com>
From: Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19 
In-reply-to: Your message of Wed, 02 Nov 2005 11:41:31 +0100.
             <20051102104131.GA7780@elte.hu> 
Date: Wed, 02 Nov 2005 03:04:28 -0800
Message-Id: <E1EXGPs-0006JA-00@w-gerrit.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 02 Nov 2005 11:41:31 +0100, Ingo Molnar wrote:
> 
> * Gerrit Huizenga <gh@us.ibm.com> wrote:
> 
> > > generic unpluggable kernel RAM _will not work_.
> > 
> > Actually, it will.  Well, depending on terminology.
> 
> 'generic unpluggable kernel RAM' means what it says: any RAM seen by the 
> kernel can be unplugged, always. (as long as the unplug request is 
> reasonable and there is enough free space to migrate in-use pages to).
 
 Okay, I understand your terminology.  Yes, I can not point to any
 particular piece of memory and say "I want *that* one" and have that
 request succeed.  However, I can say "find me 50 chunks of memory
 of your choosing" and have a very good chance of finding enough
 memory to satisfy my request.

> > There are two usage models here - those which intend to remove 
> > physical elements and those where the kernel returnss management of 
> > its virtualized "physical" memory to a hypervisor.  In the latter 
> > case, a hypervisor already maintains a virtual map of the memory and 
> > the OS needs to release virtualized "physical" memory.  I think you 
> > are referring to RAM here as the physical component; however these 
> > same defrag patches help where a hypervisor is maintaining the real 
> > physical memory below the operating system and the OS is managing a 
> > virtualized "physical" memory.
> 
> reliable unmapping of "generic kernel RAM" is not possible even in a 
> virtualized environment. Think of the 'live pointers' problem i outlined 
> in an earlier mail in this thread today.

 Yeah - and that isn't what is being proposed here.  The goal is to ask
 the kernel to identify some memory which can be legitimately freed and
 hasten the freeing of that memory.

gerrit

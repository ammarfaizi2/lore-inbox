Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932598AbVKBMBA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932598AbVKBMBA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 07:01:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932650AbVKBMBA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 07:01:00 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:31891 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932598AbVKBMA7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 07:00:59 -0500
Date: Wed, 2 Nov 2005 13:00:48 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Gerrit Huizenga <gh@us.ibm.com>
Cc: Kamezawa Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
       Dave Hansen <haveblue@us.ibm.com>, Mel Gorman <mel@csn.ul.ie>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       "Martin J. Bligh" <mbligh@mbligh.org>, Andrew Morton <akpm@osdl.org>,
       kravetz@us.ibm.com, linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lhms <lhms-devel@lists.sourceforge.net>
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
Message-ID: <20051102120048.GA10081@elte.hu>
References: <20051102104131.GA7780@elte.hu> <E1EXGPs-0006JA-00@w-gerrit.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1EXGPs-0006JA-00@w-gerrit.beaverton.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Gerrit Huizenga <gh@us.ibm.com> wrote:

> 
> On Wed, 02 Nov 2005 11:41:31 +0100, Ingo Molnar wrote:
> > 
> > * Gerrit Huizenga <gh@us.ibm.com> wrote:
> > 
> > > > generic unpluggable kernel RAM _will not work_.
> > > 
> > > Actually, it will.  Well, depending on terminology.
> > 
> > 'generic unpluggable kernel RAM' means what it says: any RAM seen by the 
> > kernel can be unplugged, always. (as long as the unplug request is 
> > reasonable and there is enough free space to migrate in-use pages to).
>  
>  Okay, I understand your terminology.  Yes, I can not point to any
>  particular piece of memory and say "I want *that* one" and have that
>  request succeed.  However, I can say "find me 50 chunks of memory
>  of your choosing" and have a very good chance of finding enough
>  memory to satisfy my request.

but that's obviously not 'generic unpluggable kernel RAM'. It's very 
special RAM: RAM that is free or easily freeable. I never argued that 
such RAM is not returnable to the hypervisor.

> > reliable unmapping of "generic kernel RAM" is not possible even in a 
> > virtualized environment. Think of the 'live pointers' problem i outlined 
> > in an earlier mail in this thread today.
> 
>  Yeah - and that isn't what is being proposed here.  The goal is to 
>  ask the kernel to identify some memory which can be legitimately 
>  freed and hasten the freeing of that memory.

but that's very easy to identify: check the free list or the clean 
list(s). No defragmentation necessary. [unless the unit of RAM mapping 
between hypervisor and guest is too coarse (i.e. not 4K pages).]

	Ingo

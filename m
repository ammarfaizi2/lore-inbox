Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751020AbVKDQIU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751020AbVKDQIU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 11:08:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751012AbVKDQIU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 11:08:20 -0500
Received: from smtp.osdl.org ([65.172.181.4]:64973 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751020AbVKDQIT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 11:08:19 -0500
Date: Fri, 4 Nov 2005 08:07:47 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andy Nelson <andy@thermo.lanl.gov>
cc: mingo@elte.hu, akpm@osdl.org, arjan@infradead.org, arjanv@infradead.org,
       haveblue@us.ibm.com, kravetz@us.ibm.com,
       lhms-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, mbligh@mbligh.org, mel@csn.ul.ie,
       nickpiggin@yahoo.com.au, pj@sgi.com
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
In-Reply-To: <20051104153903.E5D561845FF@thermo.lanl.gov>
Message-ID: <Pine.LNX.4.64.0511040801450.27915@g5.osdl.org>
References: <20051104153903.E5D561845FF@thermo.lanl.gov>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 4 Nov 2005, Andy Nelson wrote:
> 
> AFAIK, mips chips have a software TLB refill that takes 1000
> cycles more or less. I could be wrong.

You're not far off.

Time it on a real machine some day. On a modern x86, you will fill a TLB 
entry in anything from 1-8 cycles if it's in L1, and add a couple of dozen 
cycles for L2.

In fact, the L1 TLB miss can often be hidden by the OoO engine.

Now, do the math. Your "3-4 time slowdown" with several hundred cycle TLB 
miss just GOES AWAY with real hardware. Yes, you'll still see slowdowns, 
but they won't be nearly as noticeable. And having a simpler and more 
efficient kernel will actually make _up_ for them in many cases. For 
example, you can do all your calculations on idle workstations that don't 
mysteriously just crash because somebody was also doing something else on 
them.

Face it. MIPS sucks. It was clean, but it didn't perform very well. SGI 
doesn't sell those things very actively these days, do they?

So don't blame Linux. Don't make sweeping statements based on hardware 
situations that just aren't relevant any more. 

If you ever see a machine again that has a huge TLB slowdown, let the 
machine vendor know, and then SWITCH VENDORS. Linux will work on sane 
machines too.

		Linus

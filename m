Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261246AbVBFRbd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261246AbVBFRbd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 12:31:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261247AbVBFRbd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 12:31:33 -0500
Received: from fw.osdl.org ([65.172.181.6]:35732 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261246AbVBFRb3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 12:31:29 -0500
Date: Sun, 6 Feb 2005 09:31:20 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Arjan van de Ven <arjan@infradead.org>
cc: Andi Kleen <ak@suse.de>, Ingo Molnar <mingo@elte.hu>,
       Christoph Hellwig <hch@infradead.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, drepper@redhat.com
Subject: Re: [PROPOSAL/PATCH] Remove PT_GNU_STACK support before 2.6.11
In-Reply-To: <1107710023.22680.138.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.58.0502060920050.2165@ppc970.osdl.org>
References: <20050206120244.GA28061@elte.hu> <20050206124523.GA762@elte.hu>
  <20050206125002.GF30109@wotan.suse.de>  <1107694800.22680.90.camel@laptopd505.fenrus.org>
  <20050206130152.GH30109@wotan.suse.de>  <20050206130650.GA32015@infradead.org>
  <20050206131130.GJ30109@wotan.suse.de> <20050206133239.GA4483@elte.hu> 
 <20050206134640.GB30476@wotan.suse.de> <20050206140802.GA6323@elte.hu> 
 <20050206142936.GC30476@wotan.suse.de>  <Pine.LNX.4.58.0502060907220.2165@ppc970.osdl.org>
 <1107710023.22680.138.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 6 Feb 2005, Arjan van de Ven wrote:
> 
> Note that these techniques all exist today. The only issue is that the
> current code doesn't do the RWE->READIMPLIESEXEC binding, which my patch
> fixed. 

My main objection to your patch is the naming. If 'executable_stack' 
affects the heap, then why is it called "executable_STACK"?

Wouldn't it be much nicer to

 - get rid of "EXSTACK_DEFAULT" as a special case, and instead just have 
   the architecture _initialize_ the damn variable to what it wants? In 
   other words, make it a nice understandable binary value (or maybe a 
   bitmask, if you want to have separate flags for stack/heap/mmap), 
   rather than a ternary value where one of the values means something 
   arch-dependent.

 - just rename the dang thing to "read_implies_exec" and be done with it?

Hmm? Wouldn't that make a lot more sense?

And if you want to split things up, there's at least three flags there:  
"stack" vs "file mapping" vs "anonymous mapping". For example, it might
well make sense to enforce PROT_EXEC on real file mappings, but not on the
stack or heap..  So "read_implies_exec" might well be a collection of bits 
to enable these one by one (and make the "legacy app" thing make it enable 
read-implies-exec for all the cases).

		Linus

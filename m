Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030377AbWGFSBH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030377AbWGFSBH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 14:01:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030378AbWGFSBH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 14:01:07 -0400
Received: from smtp.osdl.org ([65.172.181.4]:48064 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030377AbWGFSBG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 14:01:06 -0400
Date: Thu, 6 Jul 2006 11:00:43 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, arjan@infradead.org
Subject: Re: [patch] spinlocks: remove 'volatile'
In-Reply-To: <Pine.LNX.4.61.0607061333450.11071@chaos.analogic.com>
Message-ID: <Pine.LNX.4.64.0607061057240.12404@g5.osdl.org>
References: <20060705114630.GA3134@elte.hu> <20060705101059.66a762bf.akpm@osdl.org>
 <20060705193551.GA13070@elte.hu> <20060705131824.52fa20ec.akpm@osdl.org>
 <Pine.LNX.4.64.0607051332430.12404@g5.osdl.org> <20060705204727.GA16615@elte.hu>
 <Pine.LNX.4.64.0607051411460.12404@g5.osdl.org> <20060705214502.GA27597@elte.hu>
 <Pine.LNX.4.64.0607051458200.12404@g5.osdl.org> <Pine.LNX.4.64.0607051555140.12404@g5.osdl.org>
 <20060706081639.GA24179@elte.hu> <Pine.LNX.4.61.0607060756050.8312@chaos.analogic.com>
 <Pine.LNX.4.64.0607060856080.12404@g5.osdl.org> <Pine.LNX.4.64.0607060911530.12404@g5.osdl.org>
 <Pine.LNX.4.61.0607061333450.11071@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 6 Jul 2006, linux-os (Dick Johnson) wrote:
> 
> Linus, you may have been reading too many novels.
> 
> If I have some code that does:
> 
> extern int spinner;
> 
> funct(){
>      while(spinner)
>          ;
> 
> The 'C' compiler has no choice but to actually make that memory access
> and read the variable because the variable is in another module (a.k.a.
> file).

You don't know how C works, do you?

You also have no idea of what out-of-order memory accesses do to OS code, 
right?

THE FACT IS, "volatile" IS USELESS, BADLY DEFINED, AND AN ALMOST 
COMPLETELY SURE SIGN OF BUGS.

Go on, do your own OS, and try to use "volatile" in it as the 
serialization abstraction. I personally will guarantee that you will fail. 
But hey, you can prove me wrong.

In the meantime, in Linux, "volatile" is considered a bug in any but the 
two special cases I already mentioned.

			Linus

Return-Path: <linux-kernel-owner+w=401wt.eu-S932827AbWLSQvk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932827AbWLSQvk (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 11:51:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932832AbWLSQvk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 11:51:40 -0500
Received: from smtp.osdl.org ([65.172.181.25]:45133 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932827AbWLSQvj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 11:51:39 -0500
Date: Tue, 19 Dec 2006 08:51:16 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Andrew Morton <akpm@osdl.org>,
       andrei.popa@i-neo.ro,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Hugh Dickins <hugh@veritas.com>, Florian Weimer <fw@deneb.enyo.de>,
       Marc Haber <mh+linux-kernel@zugschlus.de>,
       Martin Michlmayr <tbm@cyrius.com>
Subject: Re: 2.6.19 file content corruption on ext3
In-Reply-To: <4587B762.2030603@yahoo.com.au>
Message-ID: <Pine.LNX.4.64.0612190847270.3479@woody.osdl.org>
References: <1166314399.7018.6.camel@localhost>  <20061217040620.91dac272.akpm@osdl.org>
 <1166362772.8593.2.camel@localhost>  <20061217154026.219b294f.akpm@osdl.org>
 <1166460945.10372.84.camel@twins> <Pine.LNX.4.64.0612180933560.3479@woody.osdl.org>
 <45876C65.7010301@yahoo.com.au> <Pine.LNX.4.64.0612182230301.3479@woody.osdl.org>
 <45878BE8.8010700@yahoo.com.au> <Pine.LNX.4.64.0612182313550.3479@woody.osdl.org>
 <Pine.LNX.4.64.0612182342030.3479@woody.osdl.org> <4587B762.2030603@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 19 Dec 2006, Nick Piggin wrote:
> 
> Counterexample? Well AFAIKS, the clearing of PG_dirty in ttfb() in
> response to finding all buffers clean is perfectly valid. What makes
> you think otherwise?

If the page really is clean, then why the heck cant' we just clean the 
page table bits too?

Either it's clean or it isn't. If all the buffers being clean means that 
the page is clean, then it's clean. WE SHOULD NOT THINK THAT PTE'S ARE ANY 
DIFFERENT.

I really don't see your point. Is it clean? If it is, then clear the damn 
dirty bits from the page tables too. Don't go pussyfooting around the 
issue and confuse yourself and everybody but me by saying "but if it's 
dirty in the page tables, it's magically dirty". NO.

It really is that simple. Is it clean or not?

If it's clean, you can remove ALL the dirty bits. Not just some.

			Linus

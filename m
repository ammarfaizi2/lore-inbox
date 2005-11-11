Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751239AbVKKVoP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751239AbVKKVoP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 16:44:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751242AbVKKVoP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 16:44:15 -0500
Received: from mx2.suse.de ([195.135.220.15]:58829 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751239AbVKKVoP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 16:44:15 -0500
From: Andi Kleen <ak@suse.de>
To: coywolf@sosdg.org
Subject: Re: [patch] mark text section read-only
Date: Fri, 11 Nov 2005 22:43:41 +0100
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>,
       Josh Boyer <jdub@us.ibm.com>, akpm@osdl.org
References: <20051107105624.GA6531@infradead.org> <2cd57c900511111057n3a7741ddw@mail.gmail.com> <20051111190447.GA14481@everest.sosdg.org>
In-Reply-To: <20051111190447.GA14481@everest.sosdg.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511112243.42255.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 11 November 2005 20:04, Coywolf Qi Hunt wrote:
> On Sat, Nov 12, 2005 at 02:57:02AM +0800, Coywolf Qi Hunt wrote:
> > And we could also mark text section read-only and data/stack section
> > noexec if NX is supported. But I doubt the whole thing would really
> > help much. Kill the kernel thread? We can't. We only run into a panic.
> > Anyway I'd attach a quick patch to mark text section read only in the
> > next mail.


I think this whole thing is only usable as a debugging option. It shouldn't
be used by default on production systems because it will increase TLB
pressure by splitting up the large pages used by kernel. And TLB pressure
is critical in many workloads.

It definitely shouldn't be on by default.

Then the text section will likely not be page aligned, so it would be 
surprising if it even worked.

At least on x86-64 it is pretty useless too because the .text section can
be accessed over its alias in the direct mapping.

Overall I doubt it is worth it even as a debugging option. I so far cannot
remember a single bug that was caused by overwriting kernel text.

-Andi


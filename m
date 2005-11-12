Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932384AbVKLOch@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932384AbVKLOch (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 09:32:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932386AbVKLOch
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 09:32:37 -0500
Received: from nproxy.gmail.com ([64.233.182.200]:54622 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932384AbVKLOcg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 09:32:36 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XIrWJWSYhMJmJjWcGY81fZFe4hjOnZKuU9D/Tn1WKr66ShCUDPNnrfXAlFRBMr+f4Uo+WK6P7V0ERXwdfLkdWoaOqg1MTaSOU89wxnBPYBTGs892e5cszXM6yRz45Lu/omZO3qQcbT313s/D80PK7J+sZuD61phu1psvs7Z/EVg=
Message-ID: <2cd57c900511120632y1e7993ber@mail.gmail.com>
Date: Sat, 12 Nov 2005 22:32:34 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
To: Andi Kleen <ak@suse.de>
Subject: Re: [patch] mark text section read-only
Cc: coywolf@sosdg.org, linux-kernel@vger.kernel.org,
       Arjan van de Ven <arjan@infradead.org>, Josh Boyer <jdub@us.ibm.com>,
       akpm@osdl.org
In-Reply-To: <200511112243.42255.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051107105624.GA6531@infradead.org>
	 <2cd57c900511111057n3a7741ddw@mail.gmail.com>
	 <20051111190447.GA14481@everest.sosdg.org>
	 <200511112243.42255.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2005/11/12, Andi Kleen <ak@suse.de>:
> On Friday 11 November 2005 20:04, Coywolf Qi Hunt wrote:
> > On Sat, Nov 12, 2005 at 02:57:02AM +0800, Coywolf Qi Hunt wrote:
> > > And we could also mark text section read-only and data/stack section
> > > noexec if NX is supported. But I doubt the whole thing would really
> > > help much. Kill the kernel thread? We can't. We only run into a panic.
> > > Anyway I'd attach a quick patch to mark text section read only in the
> > > next mail.
>
>
> I think this whole thing is only usable as a debugging option. It shouldn't
> be used by default on production systems because it will increase TLB
> pressure by splitting up the large pages used by kernel. And TLB pressure
> is critical in many workloads.
>
> It definitely shouldn't be on by default.
>
> Then the text section will likely not be page aligned, so it would be
> surprising if it even worked.

It works. I have tested it with { c=_stext[0]; _stext[0]=c;}. No
effect when it's disabled; panic when it's enabled.

The symbol `_text' is always page aligned. `_etext' is not, but we don't care.

(Bugs: It would conflict with kprobes.)

>
> At least on x86-64 it is pretty useless too because the .text section can
> be accessed over its alias in the direct mapping.

OK, for x86 only then.

>
> Overall I doubt it is worth it even as a debugging option. I so far cannot
> remember a single bug that was caused by overwriting kernel text.

I had the same concern basically. But I am convinced after seeing the
bug Nikita Danilov points out.
--
Coywolf Qi Hunt
http://sosdg.org/~coywolf/

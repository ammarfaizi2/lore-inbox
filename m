Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751402AbWILHVI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751402AbWILHVI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 03:21:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751403AbWILHVH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 03:21:07 -0400
Received: from wx-out-0506.google.com ([66.249.82.230]:18541 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751402AbWILHVE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 03:21:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qQbDOaP3QbZadyaaePAF/CBBqVy0NYSYsH3bjQ32otlB7FP9e7hsWMOAywOyhO19/1+qEp5IXxP5KvfpQuQoyR1GEHXa66Fp2ARtxg+W0mZckwAvKz28olcfC9+VhzJ8biKQmVOfz9MdP+CNtdbLKLACMetd0zFiaKwk0AKYUQE=
Message-ID: <787b0d920609120021l7a4a2ce3ida379fbd69bd13b9@mail.gmail.com>
Date: Tue, 12 Sep 2006 03:21:03 -0400
From: "Albert Cahalan" <acahalan@gmail.com>
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
Subject: Re: Opinion on ordering of writel vs. stores to RAM
Cc: jbarnes@virtuousgeek.org, alan@lxorguk.ukuu.org.uk, davem@davemloft.net,
       jeff@garzik.org, paulus@samba.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org, segher@kernel.crashing.org
In-Reply-To: <1158045420.15465.97.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <787b0d920609112130v2d855023ief2457942736ccfd@mail.gmail.com>
	 <1158039004.15465.62.camel@localhost.localdomain>
	 <787b0d920609112304x3342e3bek88a8e12da62adac4@mail.gmail.com>
	 <1158041558.15465.77.camel@localhost.localdomain>
	 <787b0d920609120009q7b7bf47dw9d320e838cf191a@mail.gmail.com>
	 <1158045420.15465.97.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/12/06, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>
> > If I see an io_to_io_barrier(), how am I to tell if it is
> > read to read, write to write, read to write, write to read,
> > read/write to read, read/write to write, read to read/write,
> > write to read/write, or read/write to read/write?
> >
> > Considering just reads and writes to MMIO, there are
> > 9 possible types of fence. SPARC seems to cover a
> > decent number of these distinctly; the instruction takes
> > an immediate value as flags.
>
> We need to decide wether a single one doing a full MMIO fence (and not
> memory) is enough or if the performance different justifies maybe having
> io_to_io_{wmb,rmb,mb}. I don't see any real use for more combinations.

Remember: it's more than just performance. It's documentation
in the code.

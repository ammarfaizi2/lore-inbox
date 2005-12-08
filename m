Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932703AbVLHXKr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932703AbVLHXKr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 18:10:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932704AbVLHXKq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 18:10:46 -0500
Received: from wproxy.gmail.com ([64.233.184.196]:14306 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932703AbVLHXKq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 18:10:46 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NJbwoKqNz8LJyyyO/rDNLhGXSCvGn+gKTq31AvM4jJH9WWyoD9IvAsMS3YqpqHVGE08Ek23Mh0tj6qJoMC0MDFEuV11mdsJL0WvBVsQZdueArh6h0nQmQEawVQoL5lNys5FQ73Lp1/JBODrliO+/OAvOYgyA079m8WNNdFl3xy8=
Message-ID: <9a8748490512081510t110ce557r7d17fa8ecf6fc2d6@mail.gmail.com>
Date: Fri, 9 Dec 2005 00:10:45 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] Decrease number of pointer derefs in nfnetlink_queue.c
Cc: linux-kernel@vger.kernel.org, coreteam@netfilter.org,
       jmorris@intercode.com.au, laforge@netfilter.org, akpm@osdl.org
In-Reply-To: <20051208.145148.36886043.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200512082336.01678.jesper.juhl@gmail.com>
	 <20051208.145148.36886043.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/8/05, David S. Miller <davem@davemloft.net> wrote:
> From: Jesper Juhl <jesper.juhl@gmail.com>
> Date: Thu, 8 Dec 2005 23:36:01 +0100
>
> > Here's a small patch to decrease the number of pointer derefs in
> > net/netfilter/nfnetlink_queue.c
> >
> > Benefits of the patch:
> >  - Fewer pointer dereferences should make the code slightly faster.
> >  - Size of generated code is smaller
> >  - improved readability
>
> And you verified the compiler isn't making these transformations
> already?  It should be doing so via Common Subexpression Elimination
> unless the derefs are scattered around with interspersed function
> calls in which case the compiler cannot prove that the memory
> behind the pointer does not change.
>
I've not verified that by actually looking at the generated asm, no.
But given the (sometimes rather large) savings in size for some of the
files I patched I concluded that the compiler was not optimizing that
away.
Even if the compiler does optimize it, it obviously doesn't do as good
a job as it could (or I wouldn't be saving all those bytes by doing
this), and it's not just my gcc 3.3.6, Ingo tested my initial "test
the waters" patch with gcc 4.0.2 and saw similar savings (80 bytes in
that case - kernel/exit.c).


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html

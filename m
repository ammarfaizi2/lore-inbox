Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261809AbVDOMFz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261809AbVDOMFz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 08:05:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261813AbVDOMFz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 08:05:55 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:62475 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261809AbVDOMFr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 08:05:47 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: hch@infradead.org (Christoph Hellwig)
Subject: Re: [PATCH] fs/fcntl.c : don't test unsigned value for less than zero
Cc: matthew@wil.cx, hch@infradead.org, juhl-lkml@dif.dk,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Organization: Core
In-Reply-To: <20050415113218.GA22528@infradead.org>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.27-hx-1-686-smp (i686))
Message-Id: <E1DMPXN-0004sh-00@gondolin.me.apana.org.au>
Date: Fri, 15 Apr 2005 22:03:05 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:
>
>> No, it was exactly this patch:
>> http://www.ussg.iu.edu/hypermail/linux/kernel/0401.0/1816.html
> 
> Hmm.  Looks I absolutely disagree with Linus on this one ;-)

Me too.  The compiler doesn't really have much choice here.  If
it ignores all comparisons of unsigned integers to less than zero
then we could miss real bugs like this:

int foo(unsigned int val)
{
	return val < 0;
}

where the user probably wanted a signed comparison.

I suppose it could be smart and stay quiet about

val < 0 || val > BOUND

However, gcc is slow enough as it is without adding unnecessary
smarts like this.
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

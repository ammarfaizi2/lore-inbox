Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261799AbVBTKpd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261799AbVBTKpd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Feb 2005 05:45:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261796AbVBTKpd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Feb 2005 05:45:33 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:23051 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261799AbVBTKpX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Feb 2005 05:45:23 -0500
From: Herbert Xu <herbert@gondor.apana.org.au>
To: arjan@infradead.org (Arjan van de Ven)
Subject: Re: [2.6 patch] drivers/net/smc-mca.c: cleanups
Cc: willy@w.ods.org, jgarzik@pobox.com, bunk@stusta.de,
       linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Organization: Core
In-Reply-To: <1108827830.6304.120.camel@laptopd505.fenrus.org>
X-Newsgroups: apana.lists.os.linux.kernel,apana.lists.os.linux.net
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.27-hx-1-686-smp (i686))
Message-Id: <E1D2oSy-0006aR-00@gondolin.me.apana.org.au>
Date: Sun, 20 Feb 2005 21:37:32 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjan@infradead.org> wrote:
>
>>  I've used this technique in a few very
>> small programs to reduce their size (I could strip off both their bss and
>> data sections to save space). Also, I believe that the compiler is able
>> to optimize code using consts, but this is pure speculation, I've not
>> verified it.
> 
> Afaik that's the main difference between C and C++; in C you can still
> change "const" variables... in C++ thats illegal (at least that's what I
> remember and google seems to support somewhat ;)

The compiler does use the const modifier on a static object to optimise
code.  Try compiling this program:

const int x;

int bar(int);

int foo(void)
{
	bar(x);
	return bar(x);
}

With the const gcc (3.3.4) will only load x once while it'll reload
it after calling bar if you remove the const modifier.
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

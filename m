Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267690AbUIHIfa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267690AbUIHIfa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 04:35:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268274AbUIHIfa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 04:35:30 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:30985 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S267690AbUIHIfS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 04:35:18 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: herbert@gondor.apana.org.au (Herbert Xu)
Subject: Re: netpoll trapped question
Cc: jmoyer@redhat.com, mpm@selenic.com, linux-kernel@vger.kernel.org
Organization: Core
In-Reply-To: <E1C4xil-0005yZ-00@gondolin.me.apana.org.au>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.26-1-686-smp (i686))
Message-Id: <E1C4xuo-0005zw-00@gondolin.me.apana.org.au>
Date: Wed, 08 Sep 2004 18:34:54 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Xu <herbert@gondor.apana.org.au> wrote:
> Jeff Moyer <jmoyer@redhat.com> wrote:
>> 
>> mpm> Yes, true. But we're still in trouble if we have nic irq handler ->
>> mpm> take private lock -> printk -> netconsole -> nic irq handler -> take
>> mpm> private lock. See?
>> 
>> Okay, so that one has to be addressed on a per-driver basis.  There's no
>> way for us to detect that situation.  And how do drivers address this?
>> Simply don't printk inside the lock?  I think that's reasonable.
> 
> Why not queue the message whenever you're in IRQ context, and only
> print when you are not?

Actually how can this happen at all? The IRQ handler should've disabled
local IRQs which prevents the second handler from occuring.
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

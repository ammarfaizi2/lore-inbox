Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261403AbVAMVGk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261403AbVAMVGk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 16:06:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261483AbVAMVEm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 16:04:42 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:43012 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261699AbVAMVCm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 16:02:42 -0500
Date: Fri, 14 Jan 2005 08:01:42 +1100
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Scott Doty <scott@sonic.net>, linux-kernel@vger.kernel.org,
       davem@redhat.com
Subject: Re: 2.4.28(+?): Strange ARP problem
Message-ID: <20050113210142.GA27481@gondor.apana.org.au>
References: <20050113145029.GA22622@sonic.net> <20050113120900.GA5681@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050113120900.GA5681@logos.cnet>
User-Agent: Mutt/1.5.6+20040722i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2005 at 10:09:00AM -0200, Marcelo Tosatti wrote:
> 
> Maybe you can try earlier v2.4.28's (-rc1 for one) to check where 
> the problem starts to happen?

The symptom sounds like the bug in the 2.4 backport of the neighbour
hash updates.  In neigh_create, hash_val needs to be computed inside
the lock (and after the growing), not outside.

Someone even posted a patch for it.  I'll dig it up tonight if it
doesn't show up by then.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

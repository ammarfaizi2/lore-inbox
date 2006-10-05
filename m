Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932326AbWJEWET@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932326AbWJEWET (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 18:04:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932329AbWJEWET
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 18:04:19 -0400
Received: from rhun.apana.org.au ([64.62.148.172]:41732 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S932326AbWJEWES
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 18:04:18 -0400
Date: Fri, 6 Oct 2006 08:02:59 +1000
To: Andrew Morton <akpm@osdl.org>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>,
       "Ananiev, Leonid I" <leonid.i.ananiev@intel.com>,
       tim.c.chen@linux.intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix WARN_ON / WARN_ON_ONCE regression
Message-ID: <20061005220259.GA26202@gondor.apana.org.au>
References: <B41635854730A14CA71C92B36EC22AAC3F3FBA@mssmsx411> <20061005143748.2f6594a2.akpm@osdl.org> <45257C65.3030600@goop.org> <20061005145213.f3eaaf7d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061005145213.f3eaaf7d.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2006 at 02:52:13PM -0700, Andrew Morton wrote:
>
> Herbert had a good-sounding reason for wanting this feature, but afaict he
> hasn't proceeded to use it at this stage.  And he's hiding from us ;)

Well you guys had everything under control so I was happy to stay
behind my rock :)

The original reason for the return value is so you can do

if (WARN_ON(impossible_condition)) {
	attempt_to_continue;
}

instead of 

if (unlikely(impossible_condition)) {
	WARN_ON(1);
	attempt_to_continue;
}

Oh and yes the unlikely does make a difference in a statement
expression.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

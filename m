Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265067AbUEVAXU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265067AbUEVAXU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 20:23:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264562AbUEVAEk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 20:04:40 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:64525 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S265211AbUEUXqm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 19:46:42 -0400
Date: Sat, 22 May 2004 09:46:33 +1000
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PCMCIA] Check return status of register calls in i82365
Message-ID: <20040521234633.GA25889@gondor.apana.org.au>
References: <20040521115529.GA1408@gondor.apana.org.au> <20040521164111.26e90aa6.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040521164111.26e90aa6.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 21, 2004 at 04:41:11PM -0700, Andrew Morton wrote:
> Herbert Xu <herbert@gondor.apana.org.au> wrote:
> >
> > i82365 calls driver_register and platform_device_register without
> > checking their return values.  This patch fixes that.
> 
> It does more than that - you've also changed it to run platform_device_register()
> prior to isa_probe().  How come?

1. The platform device being registered is a place-holder that does not
   rely on the probing at all.
2. If it was done after the probe then should the registration fail, we'll
   have to roll back all the changes done by isa_probe().

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

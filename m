Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261227AbVDMXll@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261227AbVDMXll (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 19:41:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261229AbVDMXll
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 19:41:41 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:25864 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261227AbVDMXlh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 19:41:37 -0400
Date: Thu, 14 Apr 2005 09:39:04 +1000
To: Pavel Machek <pavel@ucw.cz>
Cc: Andreas Steinmetz <ast@domdv.de>, rjw@sisk.pl,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH encrypted swsusp 1/3] core functionality
Message-ID: <20050413233904.GA31174@gondor.apana.org.au>
References: <E1DLgWi-0003Ag-00@gondolin.me.apana.org.au> <425D17B0.8070109@domdv.de> <20050413212731.GA27091@gondor.apana.org.au> <425D9D50.9050507@domdv.de> <20050413231044.GA31005@gondor.apana.org.au> <20050413232431.GF27197@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050413232431.GF27197@elf.ucw.cz>
User-Agent: Mutt/1.5.6+20040907i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2005 at 01:24:31AM +0200, Pavel Machek wrote:
>
> > The ssh keys are *encrypted* in the swap when dmcrypt is used.
> > When the swap runs over dmcrypt all writes including those from
> > swsusp are encrypted.
> 
> Andreas is right. They are encrypted in swap, but they should not be
> there at all. And they are encrypted by key that is still available
> after resume. Bad.

The dmcrypt swap can only be unlocked by the user with a passphrase,
which is analogous to how you unlock your ssh private key stored
on the disk using a passphrase.

So I don't see the problem.

> First version simply overwrote suspend image in swap with zeros. This
> is more clever way to do same thing.

This version looks to me like a custom implementation of dmcrypt that
lives inside swsusp which ends up being either less secure than simply
using dmcrypt due to the lack of a passphrase, or it's going to involve
more hacks to get a passphrase from the user at resume time.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

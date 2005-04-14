Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261400AbVDNAgJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261400AbVDNAgJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 20:36:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261402AbVDNAgI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 20:36:08 -0400
Received: from waste.org ([216.27.176.166]:28836 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261400AbVDNAgE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 20:36:04 -0400
Date: Wed, 13 Apr 2005 17:35:06 -0700
From: Matt Mackall <mpm@selenic.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, Andreas Steinmetz <ast@domdv.de>,
       rjw@sisk.pl, linux-kernel@vger.kernel.org
Subject: Re: [PATCH encrypted swsusp 1/3] core functionality
Message-ID: <20050414003506.GQ25554@waste.org>
References: <E1DLgWi-0003Ag-00@gondolin.me.apana.org.au> <425D17B0.8070109@domdv.de> <20050413212731.GA27091@gondor.apana.org.au> <425D9D50.9050507@domdv.de> <20050413231044.GA31005@gondor.apana.org.au> <20050413232431.GF27197@elf.ucw.cz> <20050413233904.GA31174@gondor.apana.org.au> <20050413234602.GA10210@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050413234602.GA10210@elf.ucw.cz>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2005 at 01:46:02AM +0200, Pavel Machek wrote:
> On ??t 14-04-05 09:39:04, Herbert Xu wrote:
> > On Thu, Apr 14, 2005 at 01:24:31AM +0200, Pavel Machek wrote:
> > >
> > > > The ssh keys are *encrypted* in the swap when dmcrypt is used.
> > > > When the swap runs over dmcrypt all writes including those from
> > > > swsusp are encrypted.
> > > 
> > > Andreas is right. They are encrypted in swap, but they should not be
> > > there at all. And they are encrypted by key that is still available
> > > after resume. Bad.
> > 
> > The dmcrypt swap can only be unlocked by the user with a passphrase,
> > which is analogous to how you unlock your ssh private key stored
> > on the disk using a passphrase.
> 
> Once more:
> 
> Andreas' implementation destroys the key during resume.

This solution is all wrong.

If you want security of the suspend image while "suspended", encrypt
with dm-crypt. If you want security of the swap image after resume,
zero out the portion of swap used. If you want both, do both.

You could even just zero out those regions which were mlocked at
suspend. If it wasn't mlocked, it might be on swap already anyway.

Re-implementing dm-crypt for this purpose is ridiculous.

-- 
Mathematics is the supreme nostalgia of our time.

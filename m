Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275525AbTHNUTE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 16:19:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275529AbTHNUTE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 16:19:04 -0400
Received: from waste.org ([209.173.204.2]:44191 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S275525AbTHNUTB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 16:19:01 -0400
Date: Thu, 14 Aug 2003 15:18:47 -0500
From: Matt Mackall <mpm@selenic.com>
To: James Morris <jmorris@intercode.com.au>
Cc: Andrew Morton <akpm@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
       davem@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cryptoapi: Fix sleeping
Message-ID: <20030814201847.GO325@waste.org>
References: <20030814071519.GJ325@waste.org> <Mutt.LNX.4.44.0308150301500.25141-100000@excalibur.intercode.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Mutt.LNX.4.44.0308150301500.25141-100000@excalibur.intercode.com.au>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 15, 2003 at 03:08:12AM +1000, James Morris wrote:
> On Thu, 14 Aug 2003, Matt Mackall wrote:
> 
> > It's basically trying to be friendly. Since we can't really detect
> > when it's safe to do such yields, we should be explicitly flag the
> > uses where its ok. Something like this:
> 
> I think this is the best approach.
> 
> >  #define CRYPTO_TFM_MODE_MASK		0x000000ff
> >  #define CRYPTO_TFM_REQ_MASK		0x000fff00
> > -#define CRYPTO_TFM_RES_MASK		0xfff00000
> > +#define CRYPTO_TFM_RES_MASK		0x7ff00000
> > +#define CRYPTO_TFM_API_MASK		0x80000000
> 
> This doesn't leave much room for API flags -- the CRYPTO_TFM_REQ_MASK 
> could be made smaller.

Leaves no room actually. I figured this would be easy to move around
after the fact.

On the subject of flags, what's the best way for an algorithm init
function to get at the tfm structures (and thereby the flags) given a
ctxt? Pointer math on a ctxt?

-- 
Matt Mackall : http://www.selenic.com : of or relating to the moon

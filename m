Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262199AbVATWJo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262199AbVATWJo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 17:09:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262185AbVATWIw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 17:08:52 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:56326 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S262186AbVATWHd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 17:07:33 -0500
Date: Fri, 21 Jan 2005 09:07:13 +1100
To: linux-kernel@vger.kernel.org
Subject: Re: [patch 2.4.29] i810_audio: offset LVI from CIV to avoid stalled start
Message-ID: <20050120220713.GA16599@gondor.apana.org.au>
References: <20050120202258.GA7687@tuxdriver.com> <20050120210739.GC7687@tuxdriver.com> <20050120212346.GD7687@tuxdriver.com> <20050120220120.GF7687@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050120220120.GF7687@tuxdriver.com>
User-Agent: Mutt/1.5.6+20040722i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2005 at 05:01:21PM -0500, John W. Linville wrote:
> On Thu, Jan 20, 2005 at 04:23:46PM -0500, John W. Linville wrote:
> 
> > +	/* if we are currently stopped, then our CIV is actually set to our
> > +	 * *last* sg segment and we are ready to wrap to the next.  However,
> > +	 * if we set our LVI to the last sg segment, then it won't wrap to
> > +	 * the next sg segment, it won't even get a start.  So, instead, when
> > +	 * we are stopped, we increment the CIV value to the next sg segment
> > +	 * to be played so that when we call start, things will operate
> > +	 * properly
> > +	 */
> 
> Is this (slightly altered) comment more to your liking?  If so,
> I'll post an additive patch for the 2.6 version...

IMHO the last sentence is still wrong.  We're not touching the value
of CIV at all.  We're setting LVI to CIV + 1...

OTOH, perhaps we should actually try implementing what the comment
suggests?
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

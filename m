Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161017AbWFVJMp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161017AbWFVJMp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 05:12:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161018AbWFVJMp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 05:12:45 -0400
Received: from rhun.apana.org.au ([64.62.148.172]:32262 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1161015AbWFVJMo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 05:12:44 -0400
Date: Thu, 22 Jun 2006 19:12:29 +1000
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, snakebyte@gmx.de,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       davem@davemloft.net
Subject: Re: Memory corruption in 8390.c ? (was Re: Possible leaks in network drivers)
Message-ID: <20060622091229.GA28488@gondor.apana.org.au>
References: <1150909982.15275.100.camel@localhost.localdomain> <E1FtDU0-0005nd-00@gondolin.me.apana.org.au> <20060622023029.GA6156@gondor.apana.org.au> <449A533E.4090201@pobox.com> <20060622082931.GA26083@gondor.apana.org.au> <449A5B83.4090104@pobox.com> <20060622090227.GA28367@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060622090227.GA28367@gondor.apana.org.au>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2006 at 07:02:27PM +1000, herbert wrote:
>
> > >cassini.c
> > >starfire.c
> > >yellowfin.c
> > 
> > That doesn't really invalidate the point :)  These drivers are still 
> > only padding very small packets.
> 
> Hmm, at least cassini pads it to 255 for gigabit...

The one in starfire looks especially dodgy.  It supports SG and also
requires the whole length to be a multiple of 4 if the firmware is
broken.  The question is do they really intend this or do they want
each fragment to terminate on a 4-byte boundary.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

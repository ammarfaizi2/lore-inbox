Return-Path: <linux-kernel-owner+willy=40w.ods.org-S272256AbVBESiY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272256AbVBESiY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 13:38:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272480AbVBESiY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 13:38:24 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:61702 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S272256AbVBESea
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 13:34:30 -0500
Date: Sun, 6 Feb 2005 05:33:46 +1100
To: "YOSHIFUJI Hideaki / ?$B5HF#1QL@" <yoshfuji@linux-ipv6.org>
Cc: andre@tomt.net, davem@davemloft.net,
       mirko.parthey@informatik.tu-chemnitz.de, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, shemminger@osdl.org
Subject: Re: PROBLEM: 2.6.11-rc2 hangs on bridge shutdown (br0)
Message-ID: <20050205183346.GB11716@gondor.apana.org.au>
References: <20050204213813.4bd642ad.davem@davemloft.net> <20050205061110.GA18275@gondor.apana.org.au> <4204AA7C.9010509@tomt.net> <20050205.203900.66065862.yoshfuji@linux-ipv6.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050205.203900.66065862.yoshfuji@linux-ipv6.org>
User-Agent: Mutt/1.5.6+20040722i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 05, 2005 at 08:39:00PM +0900, YOSHIFUJI Hideaki / ?$B5HF#1QL@ wrote:
> 
> I think "Make loopback idev stick around" patches
> (for IPv4 and IPv6) could be start of that.

Unfortunately that patch can't fix this particular problem.  This
problem will show up whenever there is a dst on the GC list that
has split devices and a non-zero refcnt.

So if you had a process holding that dst you can still get a dead-lock.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

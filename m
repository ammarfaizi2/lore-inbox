Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275644AbTHOCVU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 22:21:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275648AbTHOCVU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 22:21:20 -0400
Received: from waste.org ([209.173.204.2]:28593 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S275644AbTHOCVT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 22:21:19 -0400
Date: Thu, 14 Aug 2003 21:21:16 -0500
From: Matt Mackall <mpm@selenic.com>
To: David Wagner <daw@mozart.cs.berkeley.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] Make cryptoapi non-optional?
Message-ID: <20030815022116.GV325@waste.org>
References: <20030809173329.GU31810@waste.org> <20030814165320.GA2839@speare5-1-14> <bhgoj9$9ab$1@abraham.cs.berkeley.edu> <20030815001713.GD5333@speare5-1-14> <bhhe09$hve$1@abraham.cs.berkeley.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bhhe09$hve$1@abraham.cs.berkeley.edu>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 15, 2003 at 01:45:45AM +0000, David Wagner wrote:
> Val Henson  wrote:
> >On Thu, Aug 14, 2003 at 07:40:25PM +0000, David Wagner wrote:
> >> I don't see where you are getting this from.  Define
> >>   F(x) = first80bits(SHA(x))
> >>   G(x) = first80bits(SHA(x)) xor last80bits(SHA(x)).
> >> What makes you think that F is a better (or worse) hash function than G?
> >
> >See Matt Mackall's earlier post on correlation, excerpted at the end
> >of this message.  Basically, with two strings x and y, the entropy of
> >x alone or y alone is always greater than or equal to the entropy of x
> >xored with y.
> >
> >entropy(x) >= entropy(x xor y)
> >entropy(y) >= entropy(x xor y)
> 
> Sorry; that's not accurate.  Here's a counterexample.  Let x and y be
> two 80-bit strings.  Assume that x is either 0 or 1 (equal probability
> for both possibilities).  Assume y is either 0 or 2 (equal probability
> for both possibilities), and is independent of x.  Then
>   entropy(x) = 1 bit
>   entropy(y) = 1 bit
>   entropy(x xor y) = 2 bits

Indeed. But here we're already assuming the entropy of x and y are
approximately the same as their size.

> The difference between F and G is very small, and there is not much
> basis for choosing one over the other.

The debate is really about the merits of F vs the original hash, and
it only came up because I had taken out the folding when trying to
benchmark $subject. My current code gets around that whole debate by
using F for /dev/random and (almost all of) the original hash for
/dev/urandom so we have both paranoid and fast. Now can we please
discuss the merits of $subject?

See this:

http://groups.google.com/groups?hl=en&lr=&ie=UTF-8&selm=jW3A.6xq.3%40gated-at.bofh.it&rnum=1

-- 
Matt Mackall : http://www.selenic.com : of or relating to the moon

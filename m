Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261444AbUCKHG2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 02:06:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261437AbUCKHG2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 02:06:28 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:11275 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261444AbUCKHGY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 02:06:24 -0500
Date: Thu, 11 Mar 2004 07:50:41 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Peter Williams <peterw@aurema.com>, root@chaos.analogic.com,
       "Randy.Dunlap" <rddunlap@osdl.org>, linux-kernel@vger.kernel.org,
       "Godbole, Amarendra (GE Consumer & Industrial)" 
	<Amarendra.Godbole@ge.com>
Subject: Re: (0 == foo), rather than (foo == 0)
Message-ID: <20040311065041.GB14537@alpha.home.local>
References: <905989466451C34E87066C5C13DDF034593392@HYDMLVEM01.e2k.ad.ge.com> <20040310100215.1b707504.rddunlap@osdl.org> <Pine.LNX.4.53.0403101324120.18709@chaos> <404F9E28.4040706@aurema.com> <Pine.LNX.4.58.0403101832580.1045@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0403101832580.1045@ppc970.osdl.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Mar 10, 2004 at 06:36:22PM -0800, Linus Torvalds wrote:
> 
> And while "0 == foo" may be logically the same thing as "foo == 0", the 
> fact is, the latter is what people are used to seeing. And by being used 
> to seeing it, they have an easier time thinking about it.
> 
> As a result, using the former just tends to increase peoples confusion by
> making code harder to read, which in turn tends to increase the chance of 
> bugs.

I have a friend who constantly uses it, and his code is unreadable, because
sometimes, a "0 == xxx" becomes "0 <= xxx" or "0 >= xxx" which is difficult
to understand. Thinking that xxx is negative because it's written on the
right side of a >= is complicated. And the worst he does is when he uses
functions : 

   if (0 < strcmp(a, "xxx")) ...
   if (sizeof(t) > read(fd, t, sizeof(t)) ...

I have already helped him track bugs in his programs, and some of them were
just related to this usage, because nobody's brain can understand these
constructions immediately without thinking a bit. So I'm all against this
sort of thing.

Cheers,
Willy


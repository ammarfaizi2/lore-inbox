Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272469AbTHJHae (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 03:30:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272480AbTHJHae
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 03:30:34 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:1803 "EHLO www.home.local")
	by vger.kernel.org with ESMTP id S272469AbTHJHa1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 03:30:27 -0400
Date: Sun, 10 Aug 2003 09:29:45 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Albert Cahalan <albert@users.sourceforge.net>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>, davem@redhat.com,
       jamie@shareable.org, chip@pobox.com
Subject: Re: [PATCH] 2.4.22pre10: {,un}likely_p() macros for pointers
Message-ID: <20030810072945.GA14038@alpha.home.local>
References: <1060488233.780.65.camel@cube>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1060488233.780.65.camel@cube>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Albert,

On Sun, Aug 10, 2003 at 12:03:54AM -0400, Albert Cahalan wrote:
> I looked at the assembly (ppc, gcc 3.2.3) and didn't
> see any overhead.

same here on x86, gcc-2.95.3 and gcc-3.3.1. The compiler is smart enough not
to add several intermediate tests for !!(x).
 
> The !!x gives you a 0 or 1 while converting the type.
> So a (char*)0xfda9c80300000000ull will become a 1 of
> an acceptable type, allowing the macro to work as desired.

I agree (I didn't think about pointers, BTW). But what I meant is that we
don't need the result to be precisely 1, but we need it to be something the
compiler interpretes as different from zero, to match the condition. So it
should be cleaner to always check against 0 which is also OK for pointers,
whatever their type (according to Chip's link) :

  likely => __builtin_expect(!(x), 0)
unlikely => __builtin_expect((x), 0)

Cheers,
Willy


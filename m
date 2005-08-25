Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964955AbVHYWRK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964955AbVHYWRK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 18:17:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964956AbVHYWRJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 18:17:09 -0400
Received: from are.twiddle.net ([64.81.246.98]:59542 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id S964955AbVHYWRI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 18:17:08 -0400
Date: Thu, 25 Aug 2005 15:16:49 -0700
From: Richard Henderson <rth@twiddle.net>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: Alexey Dobriyan <adobriyan@gmail.com>, Paul Jackson <pj@sgi.com>,
       paulus@samba.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Linux-2.6.13-rc7
Message-ID: <20050825221649.GA31305@twiddle.net>
Mail-Followup-To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
	Alexey Dobriyan <adobriyan@gmail.com>, Paul Jackson <pj@sgi.com>,
	paulus@samba.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0508232203520.3317@g5.osdl.org> <20050824064342.GH9322@parcelfarce.linux.theplanet.co.uk> <20050824114351.4e9b49bb.pj@sgi.com> <20050824191544.GM9322@parcelfarce.linux.theplanet.co.uk> <20050824201301.GA23715@mipter.zuzino.mipt.ru> <20050824213859.GN9322@parcelfarce.linux.theplanet.co.uk> <20050825072731.GA876@mipter.zuzino.mipt.ru> <20050825190755.GV9322@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050825190755.GV9322@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2005 at 08:07:55PM +0100, Al Viro wrote:
> IMO that's a question to rth: why do we really need to block always_inline
> on alpha?

Because I use "extern inline" in the proper way.  That is, I have both
inline and out-of-line versions of some routines.  These routines have
their address taken to be put into the alpha_machine_vector structures,
so we're guaranteed that they'll be out-of-line at least once.

But if you define inline to always_inline, the compiler complains when
its forced to fall back to the out-of-line copy.  And rightly so -- the
feature was INVENTED for using compiler intrinsics that would in fact
not produce valid assembly unless certain parameters are constants.

I've complained about this before.  You always-inline savages have 
obsconded with ALL THREE inline keywords -- "inline", "__inline" and
"__inline__" -- so there is in fact no way to accomplish what I want.

So in a fit of pique I've locally undone not just one, but all of the
always-inline crap.

All that said, something's wrong if we couldn't generate an out-of-line
copy of kmalloc.  The entire block protected by __builtin_constant_p
should have been eliminated.  File a gcc bugzilla report.  


r~

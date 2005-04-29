Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262389AbVD2Fde@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262389AbVD2Fde (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 01:33:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262388AbVD2Fdd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 01:33:33 -0400
Received: from are.twiddle.net ([64.81.246.98]:48523 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id S262387AbVD2Fd0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 01:33:26 -0400
Date: Thu, 28 Apr 2005 22:33:21 -0700
From: Richard Henderson <rth@twiddle.net>
To: Paul Mackerras <paulus@samba.org>
Cc: Benjamin LaHaise <bcrl@kvack.org>, linux-arch@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] unify semaphore implementations
Message-ID: <20050429053321.GA29884@twiddle.net>
Mail-Followup-To: Paul Mackerras <paulus@samba.org>,
	Benjamin LaHaise <bcrl@kvack.org>, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20050428182926.GC16545@kvack.org> <17009.33633.378204.859486@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17009.33633.378204.859486@cargo.ozlabs.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2005 at 10:44:17AM +1000, Paul Mackerras wrote:
> You have made semaphores bigger and slower on the architectures that
> have load-linked/store-conditional instructions, which is at least
> ppc, ppc64, sparc64 and alpha.

And mips.

While sparc64 doesn't have ll/sc, it does have compare-and-swap and
it's trivial to use that exactly like we use ll/sc.  S390 also has
compare-and-swap as its atomic primitive.

Seems to me that the ppc semaphore implementation is superior to the
i386 implementation that seems to have been propagated here.  Indeed,
I might think it would help i486, ia64, and amd64 to use the ppc style
compare-and-swap instead of the existing implementation.  Care would
have to be taken such that i386 still works, but I suspect the vast
majority of folk don't configure for that.

I would support two or three common implementations, but definitely
not the one implementation presented.


r~

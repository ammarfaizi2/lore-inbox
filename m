Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751171AbVHQRJy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751171AbVHQRJy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 13:09:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751172AbVHQRJy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 13:09:54 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:24585 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S1751171AbVHQRJx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 13:09:53 -0400
Date: Wed, 17 Aug 2005 12:59:32 -0400
From: Jeff Dike <jdike@addtoit.com>
To: Zachary Amsden <zach@vmware.com>
Cc: linux-kernel@vger.kernel.org, Chris Wright <chrisw@osdl.org>,
       akpm@osdl.org, chrisl@vmware.com, pratap@vmware.com,
       virtualization@lists.osdl.org
Subject: Re: [RFC] [PATCH] Split host arch headers for UML's benefit
Message-ID: <20050817165932.GA6072@ccure.user-mode-linux.org>
References: <20050816154201.GA6733@ccure.user-mode-linux.org> <43022690.1090209@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43022690.1090209@vmware.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2005 at 10:46:56AM -0700, Zachary Amsden wrote:
> I like this approach.  In general, it seems beneficial to split these 
> into ABI and kernel implementation.  Also, this stuff eventually works 
> its way into userspace headers.  It is not really clear which asm-xxx 
> kernel headers are valid to include in userspace.  There are definitely 
> multiple classes of things in the kernel header files : ABI definitions, 
> user-useful macros and inlines, and things that are privately useful the 
> kernel.  The ptrace split seems quite well defined here; the system 
> split is a little less obvious, but I don't object to the way you have 
> done it.

Yeah, the ptrace split is nice and ABI-like - the system split is more
of a mess.

> I've always wondered why we didn't have memory barriers in either 
> asm/atomic.h or asm/barrier.h; system.h seems to just have a mixed bag 
> of goodies.

That may make sense.

> Two things about the system.h split - do you use
> arch_align_stack()?.  

Something does, UML doesn't build without one.


> Also, do you use the alternative instruction replacement functionality, 
> or do you just need the macro?  If you don't actually implement 
> instruction replacement, it seems you could more easily redefine these to be
> 
> #define alternative(oldinstr, newinstr, feature) \
>    asm volatile(oldinstr) ::: "memory")

Possibly, I don't knowingly use it, but given my borrowing of host
arch headers, and most asm works just as well in UML as on the host,
there could be some use in UML.

				Jeff

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266399AbRGLR3E>; Thu, 12 Jul 2001 13:29:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266416AbRGLR2q>; Thu, 12 Jul 2001 13:28:46 -0400
Received: from bacchus.veritas.com ([204.177.156.37]:28622 "EHLO
	bacchus-int.veritas.com") by vger.kernel.org with ESMTP
	id <S266399AbRGLR2i>; Thu, 12 Jul 2001 13:28:38 -0400
Date: Thu, 12 Jul 2001 18:29:50 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] show_trace() module_end = 0?
In-Reply-To: <Pine.LNX.4.33.0107120858380.6595-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0107121814120.2136-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Jul 2001, Linus Torvalds wrote:
> On Thu, 12 Jul 2001, Hugh Dickins wrote:
> > show_trace() contains an erroneous line, introduced in 2.4.6-pre4,
> > which disables trace on module text: appears to be from temporary
> > testing, since code and comments for tracing module text remain.
> 
> It as actually disabled on purpose.
> 
> It's there because without it the backtrace is sometimes so full of crud
> that it is almost impossible to read.
> 
> I chose to disable the module back-trace, because what we should _really_
> do is to walk the vmalloc space and verify whether it's a valid address or
> not. But as I don't use modules myself, I didn't have much incentive to do
> so, or to test that it worked.

Thanks for owning up to that line!  I see your point.

I fear that most values found on the stack and within the vmalloc address
range would actually turn out to be valid addresses.  We probably should
not re-enable show_trace() on module text without something (in vm_struct?)
to distinguish module text from data, bss, and from other uses of vmalloc.

Hugh


Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313419AbSFLUXC>; Wed, 12 Jun 2002 16:23:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316786AbSFLUWz>; Wed, 12 Jun 2002 16:22:55 -0400
Received: from mailout03.sul.t-online.com ([194.25.134.81]:59060 "EHLO
	mailout03.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S316585AbSFLUWs> convert rfc822-to-8bit; Wed, 12 Jun 2002 16:22:48 -0400
Content-Type: text/plain; charset=US-ASCII
From: Oliver Neukum <oliver@neukum.name>
To: David Brownell <david-b@pacbell.net>, Roland Dreier <roland@topspin.com>
Subject: Re: PCI DMA to small buffers on cache-incoherent arch
Date: Wed, 12 Jun 2002 21:58:55 +0200
User-Agent: KMail/1.4.1
Cc: "David S. Miller" <davem@redhat.com>, benh@kernel.crashing.org,
        linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
In-Reply-To: <20020611.202553.28822742.davem@redhat.com> <52zny049r7.fsf@topspin.com> <3D079D44.4000701@pacbell.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200206122158.55375.oliver@neukum.name>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Based on the discussion, I think the answer for now is to go with
> the (b) variant you had originally started with, using kmalloc for
> the buffers.  The __dma_buffer style macro didn't seem popular;
> though I agree that it's not clear kmalloc() really solves it
> today.  (Given DaveM's SPARC example, the minimum size value it
> returns would need to be 128 bytes ... which clearly isn't so.)

Perhaps I might point out that we need a solution for 2.4.
We certainly could go for kmalloc. But given the sparc64 example,
it won't work. If you do it with alignment in your own buffer, you can
control which fields are accessed.
We'd need to export a worst case minimum size for kmalloc.
Ugly, very ugly. Tons of kmalloc( size>MIN_DMA ? size : MIN_DMA,...

But it seems that this would mean quite a painful change in many drivers.
Which alignment macros wouldn't mean. In fact in the common case
there'd be no code change at all.
So if we take stability as a guideline, the alignment macros win without
question.

[..]
> That'd certainly be a better approach for supporting sglist in the
> usb-storage code than the alternatives I've heard so far.

Could you elaborate ? This sounds interesting.

> > I would like to see both dev_map_xxx etc. and something like
> > __dma_buffer go into the kernel.  I think they both have their uses.
>
> Got Patch?  Actually, I know you do, I shouldn't ask.  :)

So perhaps something could be done in time for 2.4.20 ?

	Regards
		Oliver


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263751AbTKFRQe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 12:16:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263752AbTKFRQe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 12:16:34 -0500
Received: from tolkor.SGI.COM ([198.149.18.6]:51114 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id S263751AbTKFRQc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 12:16:32 -0500
Date: Thu, 6 Nov 2003 11:15:17 -0600
From: Jack Steiner <steiner@sgi.com>
To: Christoph Hellwig <hch@infradead.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, davidm@hpl.hp.com, jbarnes@sgi.com
Subject: Re: [PATCH] - Allow architectures to increase size of MAX_NR_MEMBLKS
Message-ID: <20031106171517.GA11600@sgi.com>
References: <20031105181911.GA22082@sgi.com> <20031106085735.A14360@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031106085735.A14360@infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 06, 2003 at 08:57:35AM +0000, Christoph Hellwig wrote:
> On Wed, Nov 05, 2003 at 12:19:11PM -0600, Jack Steiner wrote:
> > This fixes a problem that occurs on system with >64 nodes. 
> > 
> > Previously, MAX_NR_MEMBLKS was defined as BITS_PER_LONG. This
> > patch allows an architecture to override this definition by
> > defining a value in the arch-specific asm-xxx/mmzone.h file.
> 
> IMHO this is too much clutter.  Just make it mandatory for the
> architectures to define their own MAX_NR_MEMBLKS in the numa case.
> 
> Or actually even better just have a 
> 
> #ifndef MAX_NR_MEMBLKS
> #define MAX_NR_MEMBLKS	1
> #endif
> 
> in the generic code and let every architecture that wants to override
> it do so.


I like this idea but wanted to minimize risk to other architectures 
at this point in 2.6.

AFAICT, the only other achitecture that would require change would 
be i386. I'm not familar with the i386 numa architecture. It
looks like the change would be to add the definition of
MAX_NR_MEMBLKS to include/asm-i386/numaq.h.

What is the value of MAX_NR_MEMBLKS for NUMAQ? 

Are any architectures affected that I am overlooking???

I'm ok with either approach. What do other think??


-- 
Thanks

Jack Steiner (steiner@sgi.com)          651-683-5302
Principal Engineer                      SGI - Silicon Graphics, Inc.



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752098AbWFLP6J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752098AbWFLP6J (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 11:58:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752097AbWFLP6J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 11:58:09 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:20866 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1752098AbWFLP6H
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 11:58:07 -0400
Date: Mon, 12 Jun 2006 08:58:34 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Another couple of alterations to the memory barrier doc
Message-ID: <20060612155834.GC1293@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <10587.1150108931@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10587.1150108931@warthog.cambridge.redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2006 at 11:42:11AM +0100, David Howells wrote:
> 
> The attached patch makes another couple of alterations to the memory barrier
> document following suggestions by Alan Stern and in co-operation with Paul
> McKenney:
> 
>  (*) Rework the point of introduction of memory barriers and the description
>      of what they are to reiterate why they're needed.
> 
>  (*) Modify a statement about the use of data dependency barriers to note that
>      other barriers can be used instead (as they imply DD-barriers).

Good stuff!

							Thanx, Paul

Acked-By: Paul E. McKenney <paulmck@us.ibm.com>
> Signed-Off-By: David Howells <dhowells@redhat.com>
> ---
> warthog>diffstat -p1 /tmp/mb.diff 
>  Documentation/memory-barriers.txt |   15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
> index 4710845..cc53f47 100644
> --- a/Documentation/memory-barriers.txt
> +++ b/Documentation/memory-barriers.txt
> @@ -262,9 +262,14 @@ What is required is some way of interven
>  CPU to restrict the order.
>  
>  Memory barriers are such interventions.  They impose a perceived partial
> -ordering between the memory operations specified on either side of the barrier.
> -They request that the sequence of memory events generated appears to other
> -parts of the system as if the barrier is effective on that CPU.
> +ordering over the memory operations on either side of the barrier.
> +
> +Such enforcement is important because the CPUs and other devices in a system
> +can use a variety of tricks to improve performance - including reordering,
> +deferral and combination of memory operations; speculative loads; speculative
> +branch prediction and various types of caching.  Memory barriers are used to
> +override or suppress these tricks, allowing the code to sanely control the
> +interaction of multiple CPUs and/or devices.
>  
>  
>  VARIETIES OF MEMORY BARRIER
> @@ -461,8 +466,8 @@ Whilst this may seem like a failure of c
>  isn't, and this behaviour can be observed on certain real CPUs (such as the DEC
>  Alpha).
>  
> -To deal with this, a data dependency barrier must be inserted between the
> -address load and the data load:
> +To deal with this, a data dependency barrier or better must be inserted
> +between the address load and the data load:
>  
>  	CPU 1		CPU 2
>  	===============	===============

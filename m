Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751752AbWCOLKn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751752AbWCOLKn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 06:10:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751740AbWCOLKn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 06:10:43 -0500
Received: from mx1.redhat.com ([66.187.233.31]:16595 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751379AbWCOLKm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 06:10:42 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <44110E93.8060504@yahoo.com.au> 
References: <44110E93.8060504@yahoo.com.au>  <16835.1141936162@warthog.cambridge.redhat.com> 
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, akpm@osdl.org,
       mingo@redhat.com, alan@redhat.com, linux-arch@vger.kernel.org,
       linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Document Linux's memory barriers [try #4] 
X-Mailer: MH-E 7.92+cvs; nmh 1.1; GNU Emacs 22.0.50.4
Date: Wed, 15 Mar 2006 11:10:18 +0000
Message-ID: <14886.1142421018@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> Isn't the Alpha's split caches a counter-example of your model,
> because the coherency itself is out of order?

I'd forgotten I need to adjust my documentation to deal with this. It seems
this is the reason for read_barrier_depends(), and that read_barrier_depends()
is also a partial cache sync.

Do you know of any docs on Alpha's split caches? The Alpha Arch Handbook
doesn't say very much about cache operation on the Alpha.

I've looked around for what exactly is meant by "split cache" in conjunction
with Alpha CPUs, and I've found three different opinions of what it means:

 (1) Separate Data and Instruction caches.

 (2) Serial data caches (CPU -> L1 Cache -> L2 Cache -> L3 Cache -> Memory).

 (3) Parallel linked data caches, where a CPU's request can be satisfied by
     either data cache, in which whilst one data cache is being interrogated by
     the CPU, the other one can use the memory bus (at least, that's what I
     understand).

> Why do you need to include caches and queues in your model? Do
> programmers care? Isn't the following sufficient...

I don't think it is sufficient, given the number of times the way the cache
interacts with everything has come up in this discussion.

>          :    | m |
>    CPU -----> | e |
>          :    | m |
>          :    | o |
>    CPU -----> | r |
>          :    | y |
> 
> ... and bugger the implementation details?

Ah, but if the cache is on the CPU side of the dotted line, does that then mean
that a write memory barrier guarantees the CPU's cache to have updated memory?

David

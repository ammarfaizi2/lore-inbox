Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261909AbUKJPgT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261909AbUKJPgT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 10:36:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261918AbUKJPgS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 10:36:18 -0500
Received: from 212-28-208-94.customer.telia.com ([212.28.208.94]:39951 "EHLO
	www.dewire.com") by vger.kernel.org with ESMTP id S261909AbUKJPgO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 10:36:14 -0500
From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
To: Emmanuel Fleury <fleury@cs.aau.dk>
Subject: Re: Changes Pthreads, Mutexes and Co. ?
Date: Wed, 10 Nov 2004 16:36:09 +0100
User-Agent: KMail/1.7.1
Cc: Linux Kernel Mailing-list <linux-kernel@vger.kernel.org>
References: <1100096653.3305.9.camel@rade7.e.cs.auc.dk>
In-Reply-To: <1100096653.3305.9.camel@rade7.e.cs.auc.dk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411101636.10443.robin.rosenberg.lists@dewire.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 10 November 2004 15.24, you wrote:
> Hi all,
>
> I am using the software Cinelerra and I noticed that it was
> systematically crashing (segfaults) under 2.6.9 where using a 2.6.7 was
> ok. After looking more in depth at the problem it seems that the main
> issue comes from the fact that several objects (it's C++) are tested in
> one thread while they are freed in another. Changing from 2.6.7 to 2.6.9
> seems to make it possible to have the free(object) occurring before the
> test which leads to a segfault.
>
> So, my little question is: "Did something changed recently in the kernel
> about mutexes, phtreads, and so on ???"

A slight change in how the kernel schedules thread can cause failures in 
already broken programs. Such changes can come from any source. A 
consequence of preemptive scheduling is that you never when code in different 
threads run relative to each other except when you explicitly synchronize 
them.

It's very easy to create multithreaded programs that work fine by pure luck, 
until one day they stop working. Testing alone is not likely to find bugs 
caused by broken or missing synchronization, although multiprocessor machines
triggers such bugs more easily.

This doesn't rule out kernel bugs, but that's not where I'd start looking. 
First check that access to the objects in question is synchronized properly.

-- robin

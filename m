Return-Path: <linux-kernel-owner+w=401wt.eu-S932107AbXAQJM0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932107AbXAQJM0 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 04:12:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932119AbXAQJM0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 04:12:26 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:40177 "EHLO amd.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932107AbXAQJMY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 04:12:24 -0500
Date: Wed, 17 Jan 2007 10:12:06 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, linux-mm@kvack.org,
       David Miller <davem@davemloft.net>
Subject: Re: [PATCH 0/9] VM deadlock avoidance -v10
Message-ID: <20070117091206.GA9845@elf.ucw.cz>
References: <20070116094557.494892000@taijtu.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070116094557.494892000@taijtu.programming.kicks-ass.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> These patches implement the basic infrastructure to allow swap over networked
> storage.
> 
> The basic idea is to reserve some memory up front to use when regular memory
> runs out.
> 
> To bound network behaviour we accept only a limited number of concurrent 
> packets and drop those packets that are not aimed at the connection(s) servicing
> the VM. Also all network paths that interact with userspace are to be avoided - 
> e.g. taps and NF_QUEUE.
> 
> PF_MEMALLOC is set when processing emergency skbs. This makes sense in that we
> are indeed working on behalf of the swapper/VM. This allows us to use the 
> regular memory allocators for processing but requires that said processing have
> bounded memory usage and has that accounted in the reserve.

How does it work with ARP, for example? You still need to reply to ARP
if you want to keep your ethernet connections.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

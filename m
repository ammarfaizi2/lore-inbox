Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263319AbTHCCk2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 22:40:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264067AbTHCCk2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 22:40:28 -0400
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:18017 "EHLO
	chimarrao.boston.redhat.com") by vger.kernel.org with ESMTP
	id S263319AbTHCCk1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 22:40:27 -0400
Date: Sat, 2 Aug 2003 22:40:23 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: "Scott L. Burson" <gyro@zeta-soft.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <Mathieu.Malaterre@creatis.insa-lyon.fr>, <Kanoj@sgi.com>
Subject: Re: SMP performance problem in 2.4 (was: Athlon spinlock performance)
In-Reply-To: <16171.31418.271319.316382@kali.zeta-soft.com>
Message-ID: <Pine.LNX.4.44.0308022238560.26284-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 Aug 2003, Scott L. Burson wrote:

> In one approximately 60-second period with the problematic workload running, 
> `try_to_free_pages' was called 511 times.  It made 2597 calls to
> `shrink_caches', which made 2592 calls to `shrink_cache' (i.e. it was very
> rare for `kmem_cache_reap' to release enough pages itself).  The main loop
> of `shrink_cache' was executed -- brace yourselves -- 189 million times!
> During that time it called `page_cache_release' on only 31265 pages.

Can you reproduce this problem with the -rmap patch for the 2.4 VM?

Arjan, wli, myself and others have done quite a bit of work to make
sure the VM doesn't run around in circles madly when faced with a
large memory configuration.


-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan


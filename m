Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751023AbWBFGS7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751023AbWBFGS7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 01:18:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751024AbWBFGS7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 01:18:59 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:27043 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751021AbWBFGS6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 01:18:58 -0500
Date: Mon, 6 Feb 2006 07:17:43 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Paul Jackson <pj@sgi.com>, dgc@sgi.com, steiner@sgi.com,
       Simon.Derr@bull.net, ak@suse.de, linux-kernel@vger.kernel.org,
       clameter@sgi.com
Subject: Re: [PATCH 1/5] cpuset memory spread basic implementation
Message-ID: <20060206061743.GA14679@elte.hu>
References: <20060204071910.10021.8437.sendpatchset@jackhammer.engr.sgi.com> <20060204154944.36387a86.akpm@osdl.org> <20060205203358.1fdcea43.akpm@osdl.org> <20060205215052.c5ab1651.pj@sgi.com> <20060205220204.194ba477.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060205220204.194ba477.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> I think the bottom line here is that the kernel just cannot predict 
> the future and it will need help from the applications and/or 
> administrators to be able to do optimal things.  For that, 
> finer-grained one-knob-per-concept controls would be better.

yep. The cleanest would be to let tasks identify the fundamental access 
pattern with different granularity. I'm wondering whether it would be 
enough to simply extend madvise and fadvise to 'task' scope as well, and 
change the pagecache allocation pattern to 'spread out' pages on NUMA, 
if POSIX_FADV_RANDOM / MADV_RANDOM is specified.

hence 'global' workloads could set the per-task [and perhaps per-cpuset] 
access-pattern default to POSIX_FADV_RANDOM, while 'local' workloads 
could set it to POSIX_FADV_SEQUENTIAL [or leave it at the default].

another API solution: perhaps there should be a per-mountpoint 
fadvise/madvise hint? Thus the database in question could set the access 
pattern for the object itself. (or an ACL tag could achieve the same) 
That approach would have the advantage of being quite finegrained, and 
would limit the 'interleaving' strategy to the affected objects alone.

	Ingo

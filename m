Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262816AbTEGEKc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 00:10:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262817AbTEGEKc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 00:10:32 -0400
Received: from holomorphy.com ([66.224.33.161]:56204 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262816AbTEGEKb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 00:10:31 -0400
Date: Tue, 6 May 2003 21:22:50 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Paul Mackerras <paulus@samba.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Andrew Morton <akpm@digeo.com>,
       dipankar@in.ibm.com, linux-kernel@vger.kernel.org,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: [PATCH] kmalloc_percpu
Message-ID: <20030507042250.GX8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Paul Mackerras <paulus@samba.org>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Andrew Morton <akpm@digeo.com>, dipankar@in.ibm.com,
	linux-kernel@vger.kernel.org,
	Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
References: <20030506014745.02508f0d.akpm@digeo.com> <20030507023126.12F702C019@lists.samba.org> <20030507024135.GW8978@holomorphy.com> <16056.34210.319959.255815@argo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16056.34210.319959.255815@argo.ozlabs.ibm.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III writes:
>> This is somewhat painful to do (though possible) on i386. The cost of
>> task migration would increase at the very least.

On Wed, May 07, 2003 at 02:03:46PM +1000, Paul Mackerras wrote:
> Explain?  We're not talking about having the same address mapped
> differently on different CPUs, we're just talking about something
> which is the equivalent of a sparsely-instantiated vmalloc.

Same address mapped differently on different cpus is what I thought
you meant. It does make sense, and besides, it only really matters
when the thing is being switched in, so I think it's not such a big
deal. e.g. mark per-thread mm context with the cpu it was prepped for,
if they don't match at load-time then reset the kernel pmd's pgd entry
in the per-thread pgd at the top level. x86 blows away the TLB at the
drop of a hat anyway, and it wouldn't even introduce an extra whole-TLB
flush. That said, I'm not terribly interested in hacking all that up
even though the proper hooks to make it pure arch code appear to exist.

The vmallocspace bit is easier, though the virtualspace reservation
could get uncomfortably large depending on how much is crammed in there.
That can go node-local also. I guess it has some runtime arithmetic
overhead vs. the per-cpu TLB entries in exchange for less complex code.

-- wli

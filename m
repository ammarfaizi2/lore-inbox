Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262271AbVBXMQV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262271AbVBXMQV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 07:16:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262299AbVBXMQV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 07:16:21 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:20102 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S262271AbVBXMQM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 07:16:12 -0500
Date: Thu, 24 Feb 2005 12:15:29 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Nick Warne <nick@linicks.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at mm/rmap.c:483!
In-Reply-To: <200502232205.18610.nick@linicks.net>
Message-ID: <Pine.LNX.4.61.0502241159060.6630@goblin.wat.veritas.com>
References: <200502232205.18610.nick@linicks.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Feb 2005, Nick Warne wrote:
> 
> I upgraded memory - all 4 sticks - over Christmas, and after a few weeks 
> uptime, tried 2.4.10 again.
> 
> I have had no problems since - so perhaps I did have bad memory (it was old).
> But all tests never showed anything untoward.
> 
> I was always suspicious why my 2.6.4 build ran OK, but newer builds always 
> failed.  Could it be a subtle fault in memory whilst building kernels that 
> does it?

Perhaps, though I don't remember hearing of any example of that.

I think what typically happens, on a build the size of the kernel,
is that one of the compilations collapses with a SIGSEGV because some
pointer within gcc gets corrupted by the bad memory, so the build
fails to complete; rather than completing with a bad vmlinux output.

A more likely cause for what you saw, if the bad memory is low down
or high up (and what I mean by high may change: wli made an important
change to memory allocation ordering in 2.6.8 which would affect it),
is that one kernel's image or system initialization will happen to
allocate the bad memory to something scarcely used, where another
may allocate it to something vital.

But please don't place too much weight on my idle speculations,
others have a better appreciation of these issues.

Hugh

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269420AbUIYNBX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269420AbUIYNBX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 09:01:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269419AbUIYNBX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 09:01:23 -0400
Received: from holomorphy.com ([207.189.100.168]:51176 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S269322AbUIYM6L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 08:58:11 -0400
Date: Sat, 25 Sep 2004 05:56:06 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: ncunningham@linuxmail.org, Kevin Fenzi <kevin@scrye.com>,
       Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9-rc2-mm1 swsusp bug report.
Message-ID: <20040925125606.GN9106@holomorphy.com>
References: <20040924021956.98FB5A315A@voldemort.scrye.com> <20040924143714.GA826@openzaurus.ucw.cz> <20040924210958.A3C5AA2073@voldemort.scrye.com> <1096069216.3591.16.camel@desktop.cunninghams> <20040925014546.200828E71E@voldemort.scrye.com> <1096113235.5937.3.camel@desktop.cunninghams> <415562FE.3080709@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <415562FE.3080709@yahoo.com.au>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nigel Cunningham wrote:
>> Normal usage; the pattern of pages being freed and allocated inevitably
>> leads to fragmentation. The buddy allocator does a good job of
>> minimising it, but what is really needed is a run-time defragmenter. I
>> saw mention of this recently, but it's probably not that practical to
>> implement IMHO.
> 
On Sat, Sep 25, 2004 at 10:22:22PM +1000, Nick Piggin wrote:
> Well, by this stage it looks like memory is already pretty well shrunk
> as much as it is going to be, which means that even a pretty capable
> defragmenter won't be able to do anything.

For however useful defragmentation may be to make speculative use of
physically or virtually contiguous memory more probable to succeed, it
can never be made deterministic or even reliable, not even in pageable
kernels (which Linux is not). Fallback to allocations no larger than
the kernel's internal allocation unit, potentially in tandem with
scatter/gather capabilities, is essential.


-- wli

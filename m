Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264531AbUFNVqu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264531AbUFNVqu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 17:46:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264500AbUFNVpe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 17:45:34 -0400
Received: from ozlabs.org ([203.10.76.45]:8905 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S264519AbUFNVnM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 17:43:12 -0400
Date: Tue, 15 Jun 2004 07:40:04 +1000
From: Anton Blanchard <anton@samba.org>
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org, lse-tech@lse.sourceforge.net
Subject: Re: NUMA API observations
Message-ID: <20040614214003.GE25389@krispykreme>
References: <20040614153638.GB25389@krispykreme> <20040614161749.GA62265@colin2.muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040614161749.GA62265@colin2.muc.de>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> interleave should always fall back to other nodes. Very weird.
> Needs to be investigated. What were the actual arguments passed
> to the syscalls? 

This one looks like a bug in my code. I wasnt setting numnodes high
enough, so the node fallback lists werent being initialised for some
nodes.

> > My kernel is compiled with NR_CPUS=128, the setaffinity syscall must be
> > called with a bitmap at least as big as the kernels cpumask_t. I will
> > submit a patch for this shortly.
> 
> Umm, what a misfeature. We size the buffer up to the biggest
> running CPU. That should be enough. 
> 
> IMHO that's just a kernel bug. How should a user space
> application sanely discover the cpumask_t size needed by the kernel?
> Whoever designed that was on crack.

glibc now uses a select style interface. Unfortunately the interface has
changed about three times by now.

> I will probably make it loop and double the buffer until EINVAL ends or it 
> passes a page and add a nasty comment.

Perhaps we could use the new glibc interface and fall back to the loop
on older glibcs.

Anton

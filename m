Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269111AbUIBV2m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269111AbUIBV2m (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 17:28:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269050AbUIBV0K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 17:26:10 -0400
Received: from cantor.suse.de ([195.135.220.2]:25257 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S269107AbUIBVUW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 17:20:22 -0400
Date: Thu, 2 Sep 2004 23:19:50 +0200
From: Andi Kleen <ak@suse.de>
To: Srivatsa Vaddagiri <vatsa@in.ibm.com>
Cc: Andi Kleen <ak@suse.de>, davem@redhat.com, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org, Dipankar <dipankar@in.ibm.com>,
       paulmck@us.ibm.com
Subject: Re: [RFC] Use RCU for tcp_ehash lookup
Message-ID: <20040902211950.GH16175@wotan.suse.de>
References: <20040831125941.GA5534@in.ibm.com> <20040831135419.GA17642@wotan.suse.de> <20040901113641.GA3918@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040901113641.GA3918@in.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 01, 2004 at 05:06:41PM +0530, Srivatsa Vaddagiri wrote:
> 			     |	2.6.8.1		      |	2.6.8.1 + my patch
> -------------------------------------------------------------------------------
> Average cycles 		     |			      |
> spent in 		     |			      |
> __tcp_v4_lookup_established  |	2970.65               |	668.227
> 			     | (~3.3 micro-seconds)   | (~0.74 microseconds)
> -------------------------------------------------------------------------------
> 
> This repesents improvement by a factor of 77.5%!

Nice.

> 
> 
> > 
> > And it should also fix the performance problems with
> > cat /proc/net/tcp on ppc64/ia64 for large hash tables because the rw locks 
> > are gone.
> 
> But spinlocks are in! Would that still improve the performance compared to rw 
> locks?  (See me earlier note where I have explained that lookup done for 
> /proc/net/tcp is _not_ lock-free yet).

Yes, spinlocks are much faster than rwlocks.

-Andi


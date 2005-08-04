Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262602AbVHDQik@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262602AbVHDQik (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 12:38:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262608AbVHDQfV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 12:35:21 -0400
Received: from fmr22.intel.com ([143.183.121.14]:19619 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S262604AbVHDQeA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 12:34:00 -0400
Date: Thu, 4 Aug 2005 09:33:06 -0700
From: Ashok Raj <ashok.raj@intel.com>
To: Andi Kleen <ak@muc.de>
Cc: Ashok Raj <ashok.raj@intel.com>, Andrew Morton <akpm@osdl.org>,
       zwane@arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [patch 4/8] x86_64:Fix cluster mode send_IPI_allbutself to use get_cpu()/put_cpu()
Message-ID: <20050804093306.B15274@unix-os.sc.intel.com>
References: <20050801202017.043754000@araj-em64t> <20050801203011.290911000@araj-em64t> <20050804104302.GC97893@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050804104302.GC97893@muc.de>; from ak@muc.de on Thu, Aug 04, 2005 at 12:43:02PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 04, 2005 at 12:43:02PM +0200, Andi Kleen wrote:
> On Mon, Aug 01, 2005 at 01:20:21PM -0700, Ashok Raj wrote:
> > Need to ensure we dont get prempted when we clear ourself from mask when using
> > clustered mode genapic code.
> 
> It's not needed I think. If the caller wants to execute code
> on the current CPU then it has to have disabled preemption
> itself already to avoid races. And if not it doesn't care.
> 
> One could argue that this function should be always called
> with preemption disabled though. Perhaps better a WARN_ON().
> 

This is only required for smp_call_function(), since we do allbutself
by exclusing self, its the internal function that needs to do this.

allbutself shortcut takes care of it, since it doesnt matter which cpu
we write the shortcut, in the mask version and for cluster i think its required
to ensure in the low level function. Otherwise we would need each 
implementation of smp_call_function() and send_IPI_allbutself() callers would
need to do this, which would be lots of changes.
> -Andi

-- 
Cheers,
Ashok Raj
- Open Source Technology Center

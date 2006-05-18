Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751215AbWERFsS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751215AbWERFsS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 01:48:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750998AbWERFsS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 01:48:18 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:41660 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750798AbWERFsS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 01:48:18 -0400
Date: Thu, 18 May 2006 15:47:50 +1000
From: David Chinner <dgc@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Paul Jackson <pj@sgi.com>, dgc@sgi.com, Simon.Derr@bull.net,
       linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au, clameter@sgi.com
Subject: Re: [PATCH 01/03] Cpuset: might sleep checking zones allowed fix
Message-ID: <20060518054750.GN1390195@melbourne.sgi.com>
References: <20060518043556.15898.73616.sendpatchset@jackhammer.engr.sgi.com> <20060517222543.600cb20a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060517222543.600cb20a.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2006 at 10:25:43PM -0700, Andrew Morton wrote:
> Paul Jackson <pj@sgi.com> wrote:
> >
> > Fix a couple of infrequently encountered 'sleeping function
> >  called from invalid context' in the cpuset hooks in
> >  __alloc_pages.  Could sleep while interrupts disabled.
> 
> I'd have thought that if all the callers get their __GFP_HARDWALLS correct
> then that fishy-looking in_interrupt() test in __cpuset_zone_allowed()
> could be removed?

I suggested to Paul that __cpuset_zone_allowed() should check for
__GFP_WAIT and allow the allocation if it is not set. Any allocation
from interrupt context has to be GFP_ATOMIC so that would kill
the need for the in_interrupt() check as well. I'm probably missing
something, but that seemed like the obvious fix to me...

Cheers,

Dave.
-- 
Dave Chinner
R&D Software Enginner
SGI Australian Software Group

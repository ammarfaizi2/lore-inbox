Return-Path: <linux-kernel-owner+w=401wt.eu-S1751779AbXAQICW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751779AbXAQICW (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 03:02:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751792AbXAQICV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 03:02:21 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:35745 "EHLO omx2.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751779AbXAQICV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 03:02:21 -0500
Date: Wed, 17 Jan 2007 00:01:58 -0800
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: clameter@sgi.com, menage@google.com, linux-kernel@vger.kernel.org,
       nickpiggin@yahoo.com.au, linux-mm@kvack.org, ak@suse.de, dgc@sgi.com
Subject: Re: [RFC 0/8] Cpuset aware writeback
Message-Id: <20070117000158.a2e7016e.pj@sgi.com>
In-Reply-To: <20070116230034.b8cb4263.akpm@osdl.org>
References: <20070116054743.15358.77287.sendpatchset@schroedinger.engr.sgi.com>
	<20070116135325.3441f62b.akpm@osdl.org>
	<Pine.LNX.4.64.0701161407530.3545@schroedinger.engr.sgi.com>
	<20070116154054.e655f75c.akpm@osdl.org>
	<Pine.LNX.4.64.0701161602480.4263@schroedinger.engr.sgi.com>
	<20070116170734.947264f2.akpm@osdl.org>
	<Pine.LNX.4.64.0701161709490.4455@schroedinger.engr.sgi.com>
	<20070116183406.ed777440.akpm@osdl.org>
	<Pine.LNX.4.64.0701161920480.4677@schroedinger.engr.sgi.com>
	<20070116200506.d19eacf5.akpm@osdl.org>
	<Pine.LNX.4.64.0701162219180.5215@schroedinger.engr.sgi.com>
	<20070116230034.b8cb4263.akpm@osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew wrote:
> - consider going off-cpuset for critical allocations. 

We do ... in mm/page_alloc.c:

         * This is the last chance, in general, before the goto nopage.
         * Ignore cpuset if GFP_ATOMIC (!wait) rather than fail alloc.
         * See also cpuset_zone_allowed() comment in kernel/cpuset.c.
         */
        page = get_page_from_freelist(gfp_mask, order, zonelist, alloc_flags);

We also allow GFP_KERNEL requests to escape the current cpuset, to the nearest
enclosing mem_exclusive cpuset, which is typically a big cpuset covering most
of the system.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401

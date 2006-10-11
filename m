Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965213AbWJKWgq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965213AbWJKWgq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 18:36:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965226AbWJKWgp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 18:36:45 -0400
Received: from kanga.kvack.org ([66.96.29.28]:52973 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S965213AbWJKWgo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 18:36:44 -0400
Date: Wed, 11 Oct 2006 18:36:34 -0400
From: Benjamin LaHaise <bcrl@kvack.org>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: "'Arjan van de Ven'" <arjan@infradead.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       Nick Piggin <npiggin@suse.de>
Subject: Re: RSS accounting (was: Re: 2.6.19-rc1-mm1)
Message-ID: <20061011223634.GB18665@kvack.org>
References: <1160574913.3000.378.camel@laptopd505.fenrus.org> <000101c6ed58$e01d2830$1680030a@amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000101c6ed58$e01d2830$1680030a@amr.corp.intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2006 at 10:15:39AM -0700, Chen, Kenneth W wrote:
> I'm more inclined to define RSS as "how much ram does my application
> cause to be used".  To monitor process's working set size, We already
> have /proc/<pid>/smaps.  Whether we can use working set size in an
> intelligent way in mm is an interesting question. Though, so far such
> accounting is not utilized at all.

If that is the case, it would make sense to account such things as page 
tables and other kernel allocations against the RSS, which would be useful.  
That said, it's possible to keep semantics fairly close to those currently 
implemented by tracking RSS differently for shared vs private areas -- 
those vmas which are shared could be placed on a list and then summed when 
RSS is read.  That said, I'm not sure it is a good idea, as the cost of 
obtaining RSS for tools like top is exactly why we have the current 
counters maintained to provide O(1) semantics.

All of the old semantics are covered by smaps, though, so I'd agree with 
any changes to make RSS reflect allocations incurred by this process.

		-ben
-- 
"Time is of no importance, Mr. President, only life is important."
Don't Email: <dont@kvack.org>.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932135AbWBXMdc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932135AbWBXMdc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 07:33:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932157AbWBXMdb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 07:33:31 -0500
Received: from mx2.suse.de ([195.135.220.15]:54169 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932135AbWBXMdb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 07:33:31 -0500
From: Andi Kleen <ak@suse.de>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [Patch 3/3] prepopulate/cache cleared pages
Date: Fri, 24 Feb 2006 13:27:26 +0100
User-Agent: KMail/1.9.1
Cc: Arjan van de Ven <arjan@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       Arjan van de Ven <arjan@intel.linux.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, andrea@suse.de
References: <1140686238.2972.30.camel@laptopd505.fenrus.org> <1140772543.2874.20.camel@laptopd505.fenrus.org> <43FED128.1030500@yahoo.com.au>
In-Reply-To: <43FED128.1030500@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602241327.27390.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 24 February 2006 10:26, Nick Piggin wrote:

> [aside]
> Actually I have a scalability improvement for rwsems, that moves the
> actual task wakeups out from underneath the rwsem spinlock in the up()
> paths. This was useful exactly on a mixed read+write workload on mmap_sem.
> 
> The difference was quite large for the "generic rwsem" algorithm because
> it uses the spinlock in fastpaths a lot more than the xadd algorithm. I
> think x86-64 uses the former, which is what I presume you're testing with?

I used the generic algorithm because Andrea originally expressed some doubts 
on the correctness of the xadd algorithms and after trying to understand them 
myself I wasn't sure myself. Generic was the safer choice.

But if someone can show convincing numbers that XADD rwsems are faster
for some workload we can switch. I guess they are tested well enough now
on i386.

Or would your scalability improvement remove that difference (if it really exists)?


-Andi

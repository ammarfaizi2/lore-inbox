Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161039AbVKDEwf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161039AbVKDEwf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 23:52:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161049AbVKDEwf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 23:52:35 -0500
Received: from smtp.osdl.org ([65.172.181.4]:51881 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161039AbVKDEwe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 23:52:34 -0500
Date: Thu, 3 Nov 2005 20:52:02 -0800
From: Andrew Morton <akpm@osdl.org>
To: Badari Pulavarty <pbadari@gmail.com>
Cc: jdike@addtoit.com, rob@landley.net, nickpiggin@yahoo.com.au, gh@us.ibm.com,
       mingo@elte.hu, kamezawa.hiroyu@jp.fujitsu.com, haveblue@us.ibm.com,
       mel@csn.ul.ie, mbligh@mbligh.org, kravetz@us.ibm.com,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       lhms-devel@lists.sourceforge.net
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
Message-Id: <20051103205202.4417acf4.akpm@osdl.org>
In-Reply-To: <1131035000.24503.135.camel@localhost.localdomain>
References: <E1EXEfW-0005ON-00@w-gerrit.beaverton.ibm.com>
	<200511021747.45599.rob@landley.net>
	<43699573.4070301@yahoo.com.au>
	<200511030007.34285.rob@landley.net>
	<20051103163555.GA4174@ccure.user-mode-linux.org>
	<1131035000.24503.135.camel@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty <pbadari@gmail.com> wrote:
>
>  > With Badari's patch and UML memory hotplug, the infrastructure is
>  > there to make this work.  The one thing I'm puzzling over right now is
>  > how to measure memory pressure.
> 
>  Yep. This is the exactly the issue other product groups normally raise
>  on Linux. How do we measure memory pressure in linux ? Some of our
>  software products want to grow or shrink their memory usage depending
>  on the memory pressure in the system. Since most memory is used for
>  cache, "free" really doesn't indicate anything -they are monitoring
>  info in /proc/meminfo and swapping rates to "guess" on the memory
>  pressure. They want a clear way of finding out "how badly" system
>  is under memory pressure. (As a starting point, they want to find out
>  out of "cached" memory - how much is really easily "reclaimable" 
>  under memory pressure - without swapping). I know this is kind of 
>  crazy, but interesting to think about :)

Similarly, that SGI patch which was rejected 6-12 months ago to kill off
processes once they started swapping.  We thought that it could be done
from userspace, but we need a way for userspace to detect when a task is
being swapped on a per-task basis.

I'm thinking a few numbers in the mm_struct, incremented in the pageout
code, reported via /proc/stat.

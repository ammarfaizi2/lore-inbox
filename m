Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751508AbVKDPT5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751508AbVKDPT5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 10:19:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751504AbVKDPT4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 10:19:56 -0500
Received: from dvhart.com ([64.146.134.43]:33202 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S1161143AbVKDPTz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 10:19:55 -0500
Date: Fri, 04 Nov 2005 07:19:56 -0800
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Andrew Morton <akpm@osdl.org>, Paul Jackson <pj@sgi.com>
Cc: bron@bronze.corp.sgi.com, pbadari@gmail.com, jdike@addtoit.com,
       rob@landley.net, nickpiggin@yahoo.com.au, gh@us.ibm.com, mingo@elte.hu,
       kamezawa.hiroyu@jp.fujitsu.com, haveblue@us.ibm.com, mel@csn.ul.ie,
       kravetz@us.ibm.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       lhms-devel@lists.sourceforge.net
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
Message-ID: <325200000.1131117596@[10.10.2.4]>
In-Reply-To: <20051103231019.488127a6.akpm@osdl.org>
References: <E1EXEfW-0005ON-00@w-gerrit.beaverton.ibm.com><200511021747.45599.rob@landley.net><43699573.4070301@yahoo.com.au><200511030007.34285.rob@landley.net><20051103163555.GA4174@ccure.user-mode-linux.org><1131035000.24503.135.camel@localhost.localdomain><20051103205202.4417acf4.akpm@osdl.org><20051103213538.7f037b3a.pj@sgi.com><20051103214807.68a3063c.akpm@osdl.org><20051103224239.7a9aee29.pj@sgi.com> <20051103231019.488127a6.akpm@osdl.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Seriously, it does appear that doing it per-task is adequate for your
> needs, and it is certainly more general.
> 
> 
> 
> I cannot understand why you decided to count only the number of
> direct-reclaim events, via a "digitally filtered, constant time based,
> event frequency meter".
> 
> a) It loses information.  If we were to export the number of pages
>    reclaimed from the mm, filtering can be done in userspace.
> 
> b) It omits reclaim performed by kswapd and by other tasks (ok, it's
>    very cpuset-specific).
> 
> c) It only counts synchronous try_to_free_pages() attempts.  What if an
>    attempt only freed pagecache, or didbn't manage to free anything?
> 
> d) It doesn't notice if kswapd is swapping the heck out of your
>    not-allocating-any-memory-now process.
> 
> 
> I think all the above can be addressed by exporting per-task (actually
> per-mm) reclaim info.  (I haven't put much though into what info that
> should be - page reclaim attempts, mmapped reclaims, swapcache reclaims,
> etc)

I've been looking at similar things. When we page out / free something from 
a shared library that 10 tasks have mapped, who does that count against
for pressure?

M.


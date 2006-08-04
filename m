Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932124AbWHDAIa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932124AbWHDAIa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 20:08:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932289AbWHDAIa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 20:08:30 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:63683 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S932124AbWHDAI2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 20:08:28 -0400
Subject: Re: [PATCH] memory hotadd fixes [3/5] find_next_system_ram catch
	range fix
From: keith mannthey <kmannth@us.ibm.com>
Reply-To: kmannth@us.ibm.com
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
       lhms-devel <lhms-devel@lists.sourceforge.net>,
       "y-goto@jp.fujitsu.com" <y-goto@jp.fujitsu.com>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20060803123441.92e4ddfb.kamezawa.hiroyu@jp.fujitsu.com>
References: <20060803123441.92e4ddfb.kamezawa.hiroyu@jp.fujitsu.com>
Content-Type: text/plain
Organization: Linux Technology Center IBM
Date: Thu, 03 Aug 2006 17:08:12 -0700
Message-Id: <1154650093.5925.42.camel@keithlap>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-03 at 12:34 +0900, KAMEZAWA Hiroyuki wrote:
>  find_next_system_ram() is used to find available memory resource
> at onlining newly added memory.
> This patch fixes following problem.
> 
> find_next_system_ram() cannot catch this case.
> 
> Resource:      (start)-------------(end)
> Section :                (start)-------------(end)
> 
> 
> Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
> 
>  kernel/resource.c   |    3 ++-
>  mm/memory_hotplug.c |    2 +-
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> Index: linux-2.6.18-rc3/kernel/resource.c
> ===================================================================
> --- linux-2.6.18-rc3.orig/kernel/resource.c	2006-08-01 16:38:45.000000000 +0900
> +++ linux-2.6.18-rc3/kernel/resource.c	2006-08-01 16:38:56.000000000 +0900
> @@ -244,6 +244,7 @@
>  
>  	start = res->start;
>  	end = res->end;
> +	BUG_ON(start >= end);

BUG_ON seems a little strong for bad arguments to the function but I am
ok with it. 

Thanks,
 Keith 


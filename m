Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262501AbUKDXtC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262501AbUKDXtC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 18:49:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262503AbUKDXtC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 18:49:02 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:15748 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262501AbUKDXsq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 18:48:46 -0500
Message-ID: <418ABFB2.6050800@engr.sgi.com>
Date: Thu, 04 Nov 2004 15:48:02 -0800
From: Jay Lan <jlan@engr.sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       guillaume.thouvenin@bull.net
Subject: Re: [Lse-tech] [PATCH 2.6.9 1/2] enhanced accounting data collection
References: <41785FE3.806@engr.sgi.com>	<41786344.9070504@engr.sgi.com> <20041021191608.06b74417.akpm@osdl.org>
In-Reply-To: <20041021191608.06b74417.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Jay Lan <jlan@engr.sgi.com> wrote:
> 
>>1/2: acct_io
>>
>>Enahanced I/O accounting data collection.
>>
> 
> 
> It's nice to use `diff -p' so people can see what functions you're hitting.

Will be done that way next time.

> 
> 
>>+			current->syscr++;
> 
> 
> Should these metrics be per-thread or per-heavyweight process?

Our customers found it useful per process.

> 
> 
>>+	if (ret > 0) {
>>+		current->rchar += ret;
>>+	}
> 
> 
> It's conventional to omit the braces if there is only one statement in the
> block.

Fixed. Also a few other places in the same siutation.

> 
> 
>>===================================================================
>>--- linux.orig/include/linux/sched.h	2004-10-01 17:01:21.412848229 -0700
>>+++ linux/include/linux/sched.h	2004-10-01 17:09:42.723482260 -0700
>>@@ -591,6 +591,9 @@
>> 	struct rw_semaphore pagg_sem;
> 
> 
> There is no `pagg_sem' in the kernel, so this will spit a reject.

Fixed. That was from pagg, but i should not assume that.

> 
> 
>> #endif
>> 
>>+/* i/o counters(bytes read/written, #syscalls */
>>+	unsigned long rchar, wchar, syscr, syscw;
>>+
> 
> 
> These will overflow super-quick.  Shouldn't they be 64-bit?

You are correct. Thanks!

> 
> 
>>--- linux.orig/kernel/fork.c	2004-10-01 17:01:21.432379595 -0700
>>+++ linux/kernel/fork.c	2004-10-01 17:09:42.732271376 -0700
>>@@ -995,6 +995,7 @@
>> 	p->real_timer.data = (unsigned long) p;
>> 
>> 	p->utime = p->stime = 0;
>>+	p->rchar = p->wchar = p->syscr = p->syscw = 0;
> 
> 
> We generally prefer
> 
> 	p->rchar = 0;
> 	p->wchar = 0;
> 	etc.
> 
> yes, the code which is there has already sinned - feel free to clean it up
> while you're there ;)

Will be corrected.

Thanks,
  - jay

> 
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
> Use IT products in your business? Tell us what you think of them. Give us
> Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
> http://productguide.itmanagersjournal.com/guidepromo.tmpl
> _______________________________________________
> Lse-tech mailing list
> Lse-tech@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/lse-tech


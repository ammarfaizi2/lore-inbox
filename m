Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030495AbVKPUgR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030495AbVKPUgR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 15:36:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030494AbVKPUgR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 15:36:17 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:20610 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1030479AbVKPUgQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 15:36:16 -0500
Date: Wed, 16 Nov 2005 21:36:03 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, Paul Jackson <pj@sgi.com>,
       linux-kernel@vger.kernel.org, frankeh@watson.ibm.com,
       haveblue@us.ibm.com
Subject: Re: [RFC] [PATCH 00/13] Introduce task_pid api
Message-ID: <20051116203603.GA12505@elf.ucw.cz>
References: <20051114212341.724084000@sergelap> <20051114153649.75e265e7.pj@sgi.com> <20051115055107.GB3252@IBM-BWN8ZTBWAO1> <20051113152214.GC2193@spitz.ucw.cz> <9901B851-17B2-4AEB-813F-A92560DFE289@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9901B851-17B2-4AEB-813F-A92560DFE289@mac.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >>@@ -2925,7 +2925,7 @@ void submit_bio(int rw, struct bio *bio)
> >> 	if (unlikely(block_dump)) {
> >> 		char b[BDEVNAME_SIZE];
> >> 		printk(KERN_DEBUG "%s(%d): %s block %Lu on %s\n",
> >>-			current->comm, current->pid,
> >>+			current->comm, task_pid(current),
> >> 			(rw & WRITE) ? "WRITE" : "READ",
> >> 			(unsigned long long)bio->bi_sector,
> >> 			bdevname(bio->bi_bdev,b));
> >
> >...and now printk is close to useless, because uer can't know to  
> >which pidspace that pid belongs. Oops.
> 
> Uhh, this patch doesn't introduce any kind of virtualization yet.    
> When that happens, _this_ code will remain the same (it wants the  
> real pid), but *other* code will switch to use task_vpid(current)  
> instead.  This is an extremely literal translation of current->pid to  
> task_pid(current), both of which do exactly the same thing.

Hmm... it is hard to judge a patch without context. Anyway, can't we
get process snasphot/resume without virtualizing pids? Could we switch
to 128-bits so that pids are never reused or something like that?

								Pavel
-- 
Thanks, Sharp!

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030455AbVKPThE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030455AbVKPThE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 14:37:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030456AbVKPThE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 14:37:04 -0500
Received: from smtpout.mac.com ([17.250.248.88]:50626 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1030455AbVKPThB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 14:37:01 -0500
In-Reply-To: <20051113152214.GC2193@spitz.ucw.cz>
References: <20051114212341.724084000@sergelap> <20051114153649.75e265e7.pj@sgi.com> <20051115055107.GB3252@IBM-BWN8ZTBWAO1> <20051113152214.GC2193@spitz.ucw.cz>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <9901B851-17B2-4AEB-813F-A92560DFE289@mac.com>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, Paul Jackson <pj@sgi.com>,
       linux-kernel@vger.kernel.org, frankeh@watson.ibm.com,
       haveblue@us.ibm.com
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [RFC] [PATCH 00/13] Introduce task_pid api
Date: Wed, 16 Nov 2005 14:36:38 -0500
To: Pavel Machek <pavel@suse.cz>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 13, 2005, at 10:22, Pavel Machek wrote:
>> @@ -2925,7 +2925,7 @@ void submit_bio(int rw, struct bio *bio)
>>  	if (unlikely(block_dump)) {
>>  		char b[BDEVNAME_SIZE];
>>  		printk(KERN_DEBUG "%s(%d): %s block %Lu on %s\n",
>> -			current->comm, current->pid,
>> +			current->comm, task_pid(current),
>>  			(rw & WRITE) ? "WRITE" : "READ",
>>  			(unsigned long long)bio->bi_sector,
>>  			bdevname(bio->bi_bdev,b));
>
> ...and now printk is close to useless, because uer can't know to  
> which pidspace that pid belongs. Oops.

Uhh, this patch doesn't introduce any kind of virtualization yet.    
When that happens, _this_ code will remain the same (it wants the  
real pid), but *other* code will switch to use task_vpid(current)  
instead.  This is an extremely literal translation of current->pid to  
task_pid(current), both of which do exactly the same thing.

Cheers,
Kyle Moffett

--
There is no way to make Linux robust with unreliable memory  
subsystems, sorry.  It would be like trying to make a human more  
robust with an unreliable O2 supply. Memory just has to work.
   -- Andi Kleen



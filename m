Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264129AbTDWQ41 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 12:56:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264132AbTDWQ41
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 12:56:27 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:49600 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S264129AbTDWQ4Z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 12:56:25 -0400
Date: Wed, 23 Apr 2003 09:57:29 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Robert Love <rml@tech9.net>, William Lee Irwin III <wli@holomorphy.com>
cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.5.68-mm2
Message-ID: <1509100000.1051117049@flay>
In-Reply-To: <1051116646.2756.2.camel@localhost>
References: <20030423012046.0535e4fd.akpm@digeo.com> <20030423095926.GJ8931@holomorphy.com> <1051116646.2756.2.camel@localhost>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> rml and I coordinated to put together a small patch (combining both
>> our own) for properly locking the static variables in out_of_memory().
>> There's not any evidence things are going wrong here now, but it at
>> least addresses the visible lack of locking in out_of_memory().
> 
> Thank you for posting this, wli.
> 
>> -	first = now;
>> +	/*
>> +	 * We dropped the lock above, so check to be sure the variable
>> +	 * first only ever increases to prevent false OOM's.
>> +	 */
>> +	if (time_after(now, first))
>> +		first = now;
> 
> Just thinking... this little bit is actually a bug even on UP sans
> kernel preemption, too, since oom_kill() can sleep.  If it sleeps, and
> another process enters out_of_memory(), 'now' and 'first' will be out of
> sync.
> 
> So I think this patch is a Good Thing in more ways than the obvious SMP
> or kernel preemption issue.

Is this the bug that akpm was seeing, or a different one? The only 
information I've seen (indirectly) is that fsx triggers the oops.

M.


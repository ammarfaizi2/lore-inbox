Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261451AbUJFAvI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261451AbUJFAvI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 20:51:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266560AbUJFAvI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 20:51:08 -0400
Received: from smtp201.mail.sc5.yahoo.com ([216.136.129.91]:32656 "HELO
	smtp201.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261451AbUJFAvF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 20:51:05 -0400
Message-ID: <41634174.80409@yahoo.com.au>
Date: Wed, 06 Oct 2004 10:51:00 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Roland McGrath <roland@redhat.com>
CC: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ulrich Drepper <drepper@redhat.com>,
       Christoph Lameter <clameter@sgi.com>
Subject: Re: [PATCH] CPU time clock support in clock_* syscalls
References: <200410060033.i960XZ0S007852@magilla.sf.frob.com>
In-Reply-To: <200410060033.i960XZ0S007852@magilla.sf.frob.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland McGrath wrote:
>>It seemed like a syscall could read the values from a task currently
>>running on another CPU. If not, great.
> 
> 
> Indeed it can.  And yes, there is no locking against updates for this.  For
> sched_time on 32-bit platforms, there is the possibility it could be read
> during an update and give a bogus value if the high half is updated before
> the low half.  Since there are no guarantees about accuracy, period, I
> decided not to worry about such an anomaly.  Perhaps it would be better to
> do something about this, but AFAIK nothing perfect can be done without
> adding more words to task_struct (e.g. seqcount).  I don't know if the
> nature of SMP cache behavior makes something like:
> 
> 	do {
> 		sample = p->sched_time;
> 	} while (p->sched_time != sample);
> 
> sufficient.  That would certainly be easy to do.
> 

I don't think that will be quite sufficient.

A seqcount would probably be the way to go.

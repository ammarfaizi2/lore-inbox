Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282664AbRK0TZ5>; Tue, 27 Nov 2001 14:25:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282749AbRK0TZr>; Tue, 27 Nov 2001 14:25:47 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:2460 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S282664AbRK0TZj>;
	Tue, 27 Nov 2001 14:25:39 -0500
Date: Wed, 28 Nov 2001 01:00:40 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: mingo@elte.hu
Cc: Rusty Russell <rusty@rustcorp.com.au>, Maneesh Soni <maneesh@in.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: smp_call_function & BH handlers
Message-ID: <20011128010040.A26349@in.ibm.com>
Reply-To: dipankar@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In article <Pine.LNX.4.33.0111271935520.23151-100000@localhost.localdomain> Ingo Molnar wrote:

> On Tue, 27 Nov 2001, Maneesh Soni wrote:

>> I am working with Dipankar on Read-Copy Update, and experimenting with
>> smp_call_function(). We believed the comments for this routine and
>> faced this problem. That's why this question came. I have not yet
>> searched kernel sources for such places hence not sure whether there
>> are really such places or not.

> we had similar lockup problems before, eg. TLB flushes initiated from
> IRQ/BH contexts - which is illegal now. Generally it's not safe to assume
> that every CPU is responsive to synchronous events triggered from IRQ/BH
> contexts. Every read_lock user is prone to this problem.

Thanks for the clarification. Should we update the 
function header for smp_call_function() to say that it is illegal
to use it from both IRQ and BH contexts ?

Along the same lines, I am wondering if nowait broadcast IPI sender
waiting for IPI handlers to start in all other CPUs is a by-product
of the implementation. I can see the need for two types of
such IPIs - 1. send the broadcast IPI and forget about it and
2. send the broadcast IPI and wait for completion of the handlers.

Is there a need for the linux kernel to have a broadcast IPI
mechanism that waits for the start of the IPI handler elsewhere but
not till the end ?

Thanks
Dipankar
-- 
Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.

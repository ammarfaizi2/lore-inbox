Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273299AbSISVPV>; Thu, 19 Sep 2002 17:15:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273305AbSISVPV>; Thu, 19 Sep 2002 17:15:21 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:48026 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S273299AbSISVPU>; Thu, 19 Sep 2002 17:15:20 -0400
From: Badari Pulavarty <pbadari@us.ibm.com>
Message-Id: <200209192119.g8JLJwl17424@eng2.beaverton.ibm.com>
Subject: Re: [RFC] [PATCH] 2.5.35 patch for making DIO async--performance numbers
To: akpm@digeo.com (Andrew Morton)
Date: Thu, 19 Sep 2002 14:19:58 -0700 (PDT)
Cc: mcao@us.ibm.com (Mingming Cao), bcrl@redhat.com (Benjamin LaHaise),
       suparna@linux.ibm.com, pbadari@us.ibm.com, linux-kernel@vger.kernel.org,
       linux-aio@kvack.org, lse-tech@lists.sourceforge.net
In-Reply-To: <3D8A3D8E.4A93AD12@digeo.com> from "Andrew Morton" at Sep 19, 2002 01:11:42 PM PST
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

> 
> Thanks.  Note that the old code (which seems to be a tiny bit faster,
> and used less CPU as well) has a significantly higher context switch
> rate.  At a guess I'd say that it is more efficient at getting userspace
> up and running in response to IO completion.
> 

I my patch, I removed bio_list. So, I do all the processing of "bio"
in end_io() function, instead of postpone it to waiter. Do you think
this matters ? 


> I'd say it's only likely to affect these huge linear IOs.  Once you get
> into real workloads which are seeking and merging then a bit of latency
> here or there would just be soaked up by other system activity.
> 
> Ah.  The current direct-io.c uses wake_up_process(), not waitqueues.
> So the aio version has to wear the waitqueue cost.  If you're using the
> -mm patch I'd suggest that you convert aio.c to prepare_to_wait/finish_wait.
> The waitqueue/wakeup costs on your 8-ways seem to be very high.

Ok !! I still use wake_up_process() for the sync case.
I will try to use waitqueues and see.

Thanks,
Badari

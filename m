Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030250AbWGMRCe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030250AbWGMRCe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 13:02:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030251AbWGMRCd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 13:02:33 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:425 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1030250AbWGMRCd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 13:02:33 -0400
Message-ID: <44B67C99.8000002@vmware.com>
Date: Thu, 13 Jul 2006 10:02:17 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       schwidefsky@de.ibm.com
Subject: Re: [PATCH] next_timer_interrupt: simpler overflow handling
References: <722c432be3ba8eca595fb03cb78b2815@cl.cam.ac.uk>
In-Reply-To: <722c432be3ba8eca595fb03cb78b2815@cl.cam.ac.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keir Fraser wrote:
> Having seen the patch applied to 2.6.17 to fix the overflowing 
> comparison in next_timer_interrupt() it occurred to me that a much 
> simpler fix is to not set hr_expires to MAX_JIFFY_OFFSET. It's way 
> further out from jiffies than necessary, which is why it's caused 
> problems. I instead propose that we initialise it to LONG_MAX>>1, just 
> as we already do for the non-hr expires variable. This will allow safe 
> comparison with any timer value in the range jiffies+/-(LONG_MAX>>1) 
> which is plenty of range around jiffies (+/- 12 days if HZ=1000 and 
> long is 32 bits).
>
> The advantages are simpler code, and uniform initialisation of expires 
> and hr_expires variables.

Even simpler would be to just make MAX_JIFFY_OFFSET be (LONG_MAX >> 1) 
and use this for both.  In fact, it appears it used to be, judging by 
the comment in jiffies.h:

 * The maximum jiffie value is (MAX_INT >> 1).  Here we translate that

But seeing as this could have unanticipated side effects, I like this 
fix better.

Acked-By: Zachary Amsden <zach@vmware.com>

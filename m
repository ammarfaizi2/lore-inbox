Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311499AbSCNENk>; Wed, 13 Mar 2002 23:13:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311500AbSCNENa>; Wed, 13 Mar 2002 23:13:30 -0500
Received: from [202.135.142.196] ([202.135.142.196]:48135 "EHLO
	wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S311499AbSCNENR>; Wed, 13 Mar 2002 23:13:17 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: frankeh@watson.ibm.com
Subject: Re: futex and timeouts 
Cc: matthew@hairy.beasts.org, linux-kernel@vger.kernel.org,
        lse-tech@lists.sourceforge.net
In-Reply-To: Your message of "Wed, 13 Mar 2002 13:26:53 CDT."
             <20020313182552.945523FE06@smtp.linux.ibm.com> 
Date: Thu, 14 Mar 2002 15:15:52 +1100
Message-Id: <E16lMef-00022r-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20020313182552.945523FE06@smtp.linux.ibm.com> you write:
> 
> Ulrich, it seems to me that absolute timeouts are the easiest to do.
> 
> (a) expand by additional parameter (0) means no timeout desired
> (b) differentiate the schedule call in futex_down..
> 
> Question is whether the granularity of jiffies (10ms) is sufficiently small 
> for timeouts.....

1) You must not export jiffies to userspace.

2) They are not a time, they are a counter, and they do wrap.

3) This does not handle the settimeofday case: you need to check in
   userspace for that anyway.

So, since you need to check if you're trying to sleep for longer than
(say) 49 days, AND you need to check if you are after the given
abstime in userspace anyway (settimeofday backwards), you might as
well convert to relative in userspace.

Sorry,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

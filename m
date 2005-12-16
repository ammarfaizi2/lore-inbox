Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932137AbVLPFkF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932137AbVLPFkF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 00:40:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932138AbVLPFkF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 00:40:05 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:46733 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S932137AbVLPFkE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 00:40:04 -0500
Message-ID: <43A25331.8000306@comcast.net>
Date: Fri, 16 Dec 2005 00:40:01 -0500
From: Gautam Thaker <gthaker@comcast.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050922 Fedora/1.7.12-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Steven Rostedt <rostedt@goodmis.org>
CC: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>, john stultz <johnstul@us.ibm.com>
Subject: Re: severe jitter experienced with "select()" in linux 2.6.14-rt22
References: <43A21324.2050905@comcast.net> <1134702598.13138.113.camel@localhost.localdomain>
In-Reply-To: <1134702598.13138.113.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt wrote:

>Please always CC Ingo Molnar on all -rt related issues.  And Thomas
>Gleixner and John Stultz on timer issues with -rt. (CC John on timer
>issues in mainline too).
>  
>
Will do so in future, did not know anyone else well enough.

>
>Is there any requirement that select must sleep the full time? At least
>have you checked the value of the timeout to see if there was reported
>time left?  The return value wont be zero.  I believe that the select my
>return early with reported time left.
> 
>  
>

Yes, select is permitted to return before full timeout value, but on an 
idle, fast machine one hopes this does not happen too too often. And one 
also hopes that overruns are not too frequent. However, the results I 
get were, as can be seen from the select histogram, rather all over. 

>The simple answer is that the select system call uses the non high
>resolution timers.  There's really no reason to use select for timing.
>That's really just a side effect of the system call.  If you need
>accurate timing, that's what nanosleep is for.  IIRC, others on LKML
>have stated that it is considered bad programming to use select as a
>timer when nanosleep is available.
>  
>
well, there are a large number of applications that we have that use 
select(). These include CORBA ORBs etc and we would like to run them and 
get the benefits of excellent RT properties of -rt kernel.  It would be 
too too difficult for us, at least for now, to rewrite an ORB in such a 
way that it does not use any select() but instead uses nanosleep().  I 
assume high resolution timers must be more expensive - that is why they 
do not get used by select(). But there are cases where I don't mind 
paying the extra overhead, if any, to obtain good behaviour out of 
select().

>So, what you show is what I would expect.
>  
>
Sigh, but thanks for the comments.

>-- Steve
>  
>

Gautam



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751749AbWFWQ3U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751749AbWFWQ3U (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 12:29:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751750AbWFWQ3U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 12:29:20 -0400
Received: from terminus.zytor.com ([192.83.249.54]:65502 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751748AbWFWQ3T
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 12:29:19 -0400
Message-ID: <449C168F.30708@zytor.com>
Date: Fri, 23 Jun 2006 09:27:59 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Steven Rostedt <rostedt@goodmis.org>
CC: Chuck Ebbert <76306.1226@compuserve.com>, linux-kernel@vger.kernel.org,
       mbligh@mbligh.org, Mattia Dongili <malattia@linux.it>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: fs/binfmt_aout.o, Error: suffix or operands invalid for  `cmp'
 [was Re: 2.6.1
References: <200606220238_MC3-1-C321-1AC2@compuserve.com> <449AB908.30002@zytor.com> <Pine.LNX.4.58.0606230456220.1145@gandalf.stny.rr.com>
In-Reply-To: <Pine.LNX.4.58.0606230456220.1145@gandalf.stny.rr.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt wrote:
>>>
>> It's not (it's #APP, i.e. inline assembly); rather, it's an illegal
>> constraint.
> 
> It's GCC optimizing a little too much.
> 

No, it's not... it's the author of the inline assembly who told gcc a 
lie at what it was allowed to optimize.  The constraint is "g" 
(equivalent to "rmi"), but "rm" is the correct constraint.

There is already a patch in Andrew's repo for this.

 >
> #define __range_ok(addr,size) ({ \
> 	unsigned long flag,sum; \
> 	__chk_user_ptr(addr); \
> 	asm("addl %3,%1 ; sbbl %0,%0; cmpl %1,%4; sbbl $0,%0" \
> 		:"=&r" (flag), "=r" (sum) \
> 		:"1" (addr),"g" ((int)(size)),"g" (current_thread_info()->addr_limit.seg)); \
> 	flag; })
> 
> What happened was that gcc optimized the
> (current_thread_info()->addre_limit.seg to be a constant. Thus cmpl
> failed.
> 

... perfectly legally so, given the "g" constraint.

	-hpa

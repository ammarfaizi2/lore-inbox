Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031789AbWLBUyB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031789AbWLBUyB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 15:54:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162465AbWLBUyA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 15:54:00 -0500
Received: from smtpout.mac.com ([17.250.248.174]:22993 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1031789AbWLBUyA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 15:54:00 -0500
In-Reply-To: <20061202124251.GI3078@ftp.linux.org.uk>
References: <20061201172149.GC3078@ftp.linux.org.uk> <6911A3DA-83C4-4BE9-8553-3E960026BF51@mac.com> <20061202124251.GI3078@ftp.linux.org.uk>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <59A7652D-BB6A-47BF-B916-4A79459DC226@mac.com>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-arch@vger.kernel.org,
       LKML Kernel <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [RFC] timers, pointers to functions and type safety
Date: Sat, 2 Dec 2006 15:53:48 -0500
To: Al Viro <viro@ftp.linux.org.uk>
X-Mailer: Apple Mail (2.752.2)
X-Brightmail-Tracker: AAAAAA==
X-Brightmail-scanned: yes
X-Proofpoint-Virus-Version: vendor=fsecure engine=4.65.5446:2.3.11,1.2.37,4.0.164 definitions=2006-12-01_07:2006-12-01,2006-12-01,2006-12-01 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 ipscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx engine=3.1.0-0610180000 definitions=main-0612020014
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec 02, 2006, at 07:42:51, Al Viro wrote:
> On Sat, Dec 02, 2006 at 04:23:32AM -0500, Kyle Moffett wrote:
>> On Dec 01, 2006, at 12:21:49, Al Viro wrote:
>>> And that's where it gets interesting.  It would be very nice to  
>>> get to
>>> the following situation:
>>>  * callbacks are void (*)(void *)
>>>  * data is void *
>>>  * instances can take void * or pointer to object type
>>>  * a macro SETUP_TIMER(timer, func, data) sets callback and data  
>>> and checks if func(data) would be valid.
>>
>> This is where a very limited form of C++ templates would do  
>> nicely; you could define something like the following:
>>
>> template <typename T>
>> static inline void setup_timer(struct timer_list *timer,
>> 		void (*function)(T *), T *data)
>> {
>> 	timer->function = (void (*)(void *))function;
>> 	timer->data = (void *)data;
>> 	init_timer(timer);
>> }
>>
>> Any attempts to call it with mismatched "function" and "data"  
>> arguments would display an "Unable to find matching template"  
>> error from the compiler.
>>
>> Unfortunately you can't get simple templated functions without  
>> opening the whole barrel of monkeys involved with C++ support;
>
> Fortunately, you can get all checks done by gcc without involving C+ 
> + (or related flamewars).  See original post for a way to do it in  
> a macro and for fsck sake, leave gcc@gcc.gnu.org out of it

Oh, I'm sorry I totally missed the CC of gcc@gcc.gnu.org.  My point  
was just that while it _could_ be done with GCC and some ugly macros,  
a basic form of C++ templates usually produces much nicer and more  
descriptive error messages (leaving out all the reasons C++ isn't  
usable in the kernel for the sake of academic discussion).  The  
template syntax is also a bit more descriptive than is the macro  
syntax for achieving the same thing.

Cheers,
Kyle Moffett


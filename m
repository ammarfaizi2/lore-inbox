Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750733AbVKKNRm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750733AbVKKNRm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 08:17:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750734AbVKKNRm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 08:17:42 -0500
Received: from mx1.redhat.com ([66.187.233.31]:56513 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750733AbVKKNRl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 08:17:41 -0500
Message-ID: <437499F2.1040708@redhat.com>
Date: Fri, 11 Nov 2005 08:17:38 -0500
From: Peter Staubach <staubach@redhat.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.4.1 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Ulrich Drepper <drepper@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] poll(2) timeout values
References: <437375DE.1070603@redhat.com>	 <1131642956.20099.39.camel@localhost.localdomain>	 <a36005b50511101049vf20cde5m9385c433e18dcd2d@mail.gmail.com>	 <1131662022.20099.44.camel@localhost.localdomain>	 <a36005b50511101649l744f78c1i76133434be7304e8@mail.gmail.com> <1131714967.3174.9.camel@localhost.localdomain>
In-Reply-To: <1131714967.3174.9.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>On Iau, 2005-11-10 at 16:49 -0800, Ulrich Drepper wrote:
>  
>
>>On 11/10/05, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>>    
>>
>>>No. The poll POSIX libc call takes an int. What the kernel ones does
>>>with the top bits is irrelevant to applications.
>>>      
>>>
>>The issue is that if the high bits are not handled special then
>>somebody might cause problems.  E.g., overflowing the division or so. 
>>Therefore the kernel has to sanitize the argument and then why not use
>>the easiest way to do this?
>>    
>>
>
>Why does the kernel have to sanitize the input. Last time I checked
>undefined inputs gave undefined outputs in the standards. fopen(NULL,
>NULL) seems to crash glibc for example.
>
>The kernel has to behave correctly given valid sensible inputs. Masking
>the top bits is not behaving correctly
>
>	"sleep ages"
>	"no I'll sleep a short time"
>
>Surely it would be far better to do
>
>	if((timeout >> 31) >> 1) 
>		return -EINVAL;
>
>for 64bit systems
>

Given that the current, sole purpose of sys_poll() is to implement the 
poll(2)
system call, and that currently, that system call takes a 32 bit signed 
integer
third argument, then it seems safe to me to just ignore the top 32 
bits.  They
can be either masked off explicitly or implicitly via the use of a 32 bit
signed integer.

Is there a problem with making this change other than it is a change?  Is
there a risk of something breaking?

    Thanx...

       ps

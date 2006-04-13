Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751168AbWDMK2U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751168AbWDMK2U (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 06:28:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751219AbWDMK2U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 06:28:20 -0400
Received: from smtpout.mac.com ([17.250.248.83]:50384 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1751168AbWDMK2T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 06:28:19 -0400
In-Reply-To: <20060413025608.3edbf603.akpm@osdl.org>
References: <6.2.5.6.2.20060412173852.033dbb90@cs.berkeley.edu> <20060412214613.404cf49f.akpm@osdl.org> <6.2.5.6.2.20060413015645.033d3fc8@comcast.net> <20060413025608.3edbf603.akpm@osdl.org>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <806A7BCF-C5FF-4B38-9F85-1D6FE8D47D6A@mac.com>
Cc: Dan Bonachea <bonachead@comcast.net>, linux-kernel@vger.kernel.org,
       nickpiggin@yahoo.com.au, torvalds@osdl.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: PROBLEM: pthread-safety bug in write(2) on Linux 2.6.x
Date: Thu, 13 Apr 2006 06:28:12 -0400
To: Andrew Morton <akpm@osdl.org>
X-Mailer: Apple Mail (2.746.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 13, 2006, at 05:56:08, Andrew Morton wrote:
> Dan Bonachea <bonachead@comcast.net> wrote:
>>
>> This problem arose in the parallel runtime system for a scientific  
>> language compiler (nearly a million lines of code total -  
>> definitely a "real-world" program) - the example code is merely a  
>> pared-down demonstration of the problem. In parallel scientific  
>> computing, it's very common for many threads to be writing to  
>> stdout (usually for monitoring purposes) and it's expected and  
>> normal for output from separate threads to be arbitrarily  
>> interleaved, but it's *not* ok for output to be lost entirely.  
>> This is essentially equivalent to the real-world example you gave  
>> of many threads logging to a file.
>
> Interesting - afaik that's the first time this has been hit in a  
> real application.

I would guess that it could also be a problem with a wide variety of  
Perl CGIs running under Apache2+mod_perl with the worker threading  
model.  In fact this may actually explain some odd behavior I got  
from one such module that I "fixed" by switching to logging via  
syslog.  I don't remember which module it was or what the exact  
problem was, but I think it seemed similar in nature.  That is  
somewhat of a surprising and nonintuitive failure mode for logging,  
IMHO it would be nice to get fixed.  I would imagine that this has  
probably been hit a number of times before, mysteriously fixed by  
changed userspace locking or subtle thread ordering, and written off  
as the mysterious effects of cosmic rays on RAM.

Cheers,
Kyle Moffett


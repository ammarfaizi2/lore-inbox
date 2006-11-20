Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966674AbWKTUs2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966674AbWKTUs2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 15:48:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966676AbWKTUs2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 15:48:28 -0500
Received: from smtpout.mac.com ([17.250.248.171]:57848 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S966674AbWKTUs1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 15:48:27 -0500
In-Reply-To: <4561E923.3080305@hogyros.de>
References: <4561ABB4.6090700@hogyros.de> <33832325-EF32-4C6D-B566-8B7CE179FF1C@mac.com> <4561E923.3080305@hogyros.de>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <3057D4CA-C9DD-400F-B339-01BE9D99D59E@mac.com>
Cc: Linux-Kernel mailing-list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: Mark Rustad <mrustad@mac.com>
Subject: Re: RFC: implement daemon() in the kernel
Date: Mon, 20 Nov 2006 14:48:17 -0600
To: Simon Richter <Simon.Richter@hogyros.de>
X-Mailer: Apple Mail (2.752.2)
X-Brightmail-Tracker: AAAAAA==
X-Brightmail-scanned: yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 20, 2006, at 11:42 AM, Simon Richter wrote:

> Mark Rustad schrieb:
>
>> There is a better way. Simply implement fork(). It can be done  
>> even without an MMU. People think it is impossible, but that is  
>> only because they don't consider the possibility of copying memory  
>> back and forth on task switch. It sounds horrible, but in the vast  
>> majority of cases, either the parent or child either exits or does  
>> an exec pretty quickly, so in reality it doesn't cost much. The  
>> benefits are many: being able to use real shells such as bash and  
>> thereby being able to use real shell scripts.
>
> This imposes quite a significant overhead for the common case (in  
> which the application has specifically requested that the parent  
> process be terminated after the child process is fork()ed off).  
> Even if the cost of transferring memory contents was cheap (which  
> it isn't), you'd annoy the memory management subsystem unless you  
> did a lot of weird tricks to avoid allocating from a large block.

Yes. I did not mean to suggest that vfork() should go away or that  
shells that make use of it go away. It is just that making fork()  
work has a lot of value. vfork() would always be the optimal thing to  
use, but sometimes you need the power of a real fork(). Greater  
compatibility with normal Linux is of greater value than adding more  
funky special-purpose system calls.

>> You do have to look out for any applications that fork and do not  
>> either exit or exec, but that is so much better than having to  
>> modify so many things just to get them to run.
>
> Well, in fact just having a libc that does not define a symbol for  
> "fork" and then going to the places the linker mentions as having  
> undefined references is a pretty easy way. Mind you, in 90% of  
> cases you can replace them by a vfork() and be done.

Yes, but some of those 10% cases can be a real pain. Also if you are  
supporting users that just want some app to run, having fewer porting  
barriers is a real help. Often the expense of fork() is only a  
startup thing anyway and not a factor in the normal steady-state  
operation of a system.

-- 
Mark Rustad, MRustad@mac.com


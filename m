Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262805AbUBZP7n (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 10:59:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262803AbUBZP7n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 10:59:43 -0500
Received: from kinesis.swishmail.com ([209.10.110.86]:61964 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S262805AbUBZP6f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 10:58:35 -0500
Message-ID: <403E1A11.5050704@techsource.com>
Date: Thu, 26 Feb 2004 11:08:49 -0500
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Peter Williams <peterw@aurema.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] O(1) Entitlement Based Scheduler
References: <Pine.GSO.4.03.10402260834530.27582-100000@swag.sw.oz.au> <403D3E47.4080501@techsource.com> <403D576A.6030900@aurema.com>
In-Reply-To: <403D576A.6030900@aurema.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Peter Williams wrote:
> Timothy Miller wrote:
>  > <snip>
> 
>> In fact, that may be the only "flaw" in your design.  It sounds like 
>> your scheduler does an excellent job at fairness with very low 
>> overhead.  The only problem with it is that it doesn't determine 
>> priority dynamically.
> 
> 
> This (i.e. automatic renicing of specified programs) is a good idea but 
> is not really a function that should be undertaken by the scheduler 
> itself.  Two possible solutions spring to mind:
> 
> 1. modify the do_execve() in fs/exec.c to renice tasks when they execute 
> specified binaries

We don't want user-space programs to have control over priority.  This 
is DoS waiting to happen.

> 2. have a user space daemon poll running tasks periodically and renice 
> them if they are running specified binaries

This is much too specific.  Again, if the USER has control over this 
list, then it's potential DoS.  And if the user adds a program which 
should qualify but which is not in the list, the program will not get 
its deserved boost.

And a sysadmin is not going to want to update 200 lab computers just so 
one user can get their program to run properly.

> 
> Both of these solutions have their advantages and disadvantages, are 
> (obviously) complicated than I've made them sound and would require a 
> great deal of care to be taken during their implementation.  However, I 
> think that they are both doable.  My personal preference would be for 
> the in kernel solution on the grounds of efficiency.

They are doable, but they are not a general solution.


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262978AbUBZUT4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 15:19:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262838AbUBZUSp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 15:18:45 -0500
Received: from alt.aurema.com ([203.217.18.57]:65212 "EHLO smtp.sw.oz.au")
	by vger.kernel.org with ESMTP id S262978AbUBZUPo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 15:15:44 -0500
Message-ID: <403E53EA.2010001@aurema.com>
Date: Fri, 27 Feb 2004 07:15:38 +1100
From: Peter Williams <peterw@aurema.com>
Organization: Aurema Pty Ltd
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Timothy Miller <miller@techsource.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] O(1) Entitlement Based Scheduler
References: <Pine.GSO.4.03.10402260834530.27582-100000@swag.sw.oz.au> <403D3E47.4080501@techsource.com> <403D576A.6030900@aurema.com> <403E1A11.5050704@techsource.com>
In-Reply-To: <403E1A11.5050704@techsource.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timothy Miller wrote:
> 
> 
> Peter Williams wrote:
> 
>> Timothy Miller wrote:
>>  > <snip>
>>
>>> In fact, that may be the only "flaw" in your design.  It sounds like 
>>> your scheduler does an excellent job at fairness with very low 
>>> overhead.  The only problem with it is that it doesn't determine 
>>> priority dynamically.
>>
>>
>>
>> This (i.e. automatic renicing of specified programs) is a good idea 
>> but is not really a function that should be undertaken by the 
>> scheduler itself.  Two possible solutions spring to mind:
>>
>> 1. modify the do_execve() in fs/exec.c to renice tasks when they 
>> execute specified binaries
> 
> 
> We don't want user-space programs to have control over priority. 

They already do e.g. renice is such a program.

> This 
> is DoS waiting to happen.
> 
>> 2. have a user space daemon poll running tasks periodically and renice 
>> them if they are running specified binaries
> 
> 
> This is much too specific.  Again, if the USER has control over this
> list,

It would obviously be under root control.

> then it's potential DoS.  And if the user adds a program which 
> should qualify but which is not in the list, the program will not get 
> its deserved boost.
> 
> And a sysadmin is not going to want to update 200 lab computers just so 
> one user can get their program to run properly.
> 
>>
>> Both of these solutions have their advantages and disadvantages, are 
>> (obviously) complicated than I've made them sound and would require a 
>> great deal of care to be taken during their implementation.  However, 
>> I think that they are both doable.  My personal preference would be 
>> for the in kernel solution on the grounds of efficiency.
> 
> 
> They are doable, but they are not a general solution.
> 

Peter
-- 
Dr Peter Williams, Chief Scientist                peterw@aurema.com
Aurema Pty Limited                                Tel:+61 2 9698 2322
PO Box 305, Strawberry Hills NSW 2012, Australia  Fax:+61 2 9699 9174
79 Myrtle Street, Chippendale NSW 2008, Australia http://www.aurema.com


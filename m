Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932131AbVHHR2D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932131AbVHHR2D (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 13:28:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932132AbVHHR2C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 13:28:02 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:63728 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S932130AbVHHR2B
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 13:28:01 -0400
Message-ID: <42F79615.3000108@mvista.com>
Date: Mon, 08 Aug 2005 10:27:49 -0700
From: Dave Jiang <djiang@mvista.com>
Organization: MontaVista Software, Inc.
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
CC: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: x86_64 frame pointer via thread context
References: <42F3EC97.2060906@mvista.com.suse.lists.linux.kernel> <p73slxn1dry.fsf@bragg.suse.de> <Pine.LNX.4.61.0508080912380.18088@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0508080912380.18088@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:
>>>Am I doing something wrong, or is this intended to be this way on
>>>x86_64, or is something incorrect in the kernel? This method works
>>>fine on i386. Thanks for any help!
>>
>>I just tested your program on SLES9 with updated kernel and RBP
>>looks correct to me. Probably something is wrong with your user space
>>includes or your compiler.
> 
> 
> Note that there is -fomit-frame-pointer which might give different results 
> than without the option (or explicitly -fno-omit-frame-pointer).
> 
> 
> Jan Engelhardt

I had somebody else test it on FC4 and he observed the same issue. It 
may be timing sensitive? Both platforms tested are em64t based so I'm 
not sure if on amd64 platforms it varies or not.....

And you definitely have to include the -fno-omit-frame-pointer. x86_64 
gcc by default has -fomit-frame-pointer on and without explicitly 
stating that you want frame pointer you won't get it in rBP.

It is possible that userspace or toolchain may be suspect, However, why 
is the value bad in kernel space when rBP from pt_regs is dumped?


-- 
Dave

------------------------------------------------------
Dave Jiang
Software Engineer          Phone: (480) 517-0372
MontaVista Software, Inc.    Fax: (480) 517-0262
2141 E Broadway Rd, St 108   Web: www.mvista.com
Tempe, AZ  85282          mailto:djiang@mvista.com
------------------------------------------------------


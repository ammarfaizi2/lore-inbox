Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932251AbVHHUGH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932251AbVHHUGH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 16:06:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932247AbVHHUGG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 16:06:06 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:4277 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S932251AbVHHUGF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 16:06:05 -0400
Message-ID: <42F7BB2C.6070004@vc.cvut.cz>
Date: Mon, 08 Aug 2005 22:06:04 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Debian/1.7.8-1
X-Accept-Language: en
MIME-Version: 1.0
To: Dave Jiang <djiang@mvista.com>
CC: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: x86_64 frame pointer via thread context
References: <42F3EC97.2060906@mvista.com.suse.lists.linux.kernel> <p73slxn1dry.fsf@bragg.suse.de> <42F7A609.5030502@mvista.com>
In-Reply-To: <42F7A609.5030502@mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jiang wrote:
> Andi Kleen wrote:
> 
>> Dave Jiang <djiang@mvista.com> writes:
>>
>>> Am I doing something wrong, or is this intended to be this way on
>>> x86_64, or is something incorrect in the kernel? This method works
>>> fine on i386. Thanks for any help!
>>
>>
>>
>> I just tested your program on SLES9 with updated kernel and RBP
>> looks correct to me. Probably something is wrong with your user space
>> includes or your compiler.
>>
>> -Andi
> 
> 
> I revised the app a little so that it would allow the threads to start, 
> thus should prevent rBP w/ all 0's showing up. Below are some of results 
> that I've gotten from various different distros and platforms. As you 
> can see, the f's shows up on most of them, including Suse 9.2. The only 
> one showed up looking ok is the Mandrake/Mandriva distro. I'm not sure 
> how different SLES9 is from Suse9.2....

Replace call to sleep() with busy loop.  Glibc's sleep() uses %ebp for
its own data, so when you interrupt sleep(), you get rbp=(unsigned int)-1,
as rbp really contains 0x0000.0000.ffff.ffff when nanosleep() syscall
is issued.
								Petr


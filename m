Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316836AbSGIRCR>; Tue, 9 Jul 2002 13:02:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316897AbSGIRCQ>; Tue, 9 Jul 2002 13:02:16 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:18049 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S316836AbSGIRCN>;
	Tue, 9 Jul 2002 13:02:13 -0400
Message-ID: <3D2B178B.1070903@us.ibm.com>
Date: Tue, 09 Jul 2002 10:04:11 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@linuxpower.ca>
CC: dan carpenter <error27@email.com>,
       kernel-janitor-discuss@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: lock_kernel check...
References: <Pine.LNX.4.44.0207091228250.4869-100000@linux-box.realnet.co.sz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo wrote:
> On Tue, 9 Jul 2002, Dave Hansen wrote:
> 
> 
>>It isn't absoulutely a bad thing to return while you have a lock held. 
>>    It might be hard to understand, or even crazy, but not immediately 
>>wrong :)
>>
>>// BKL protects both "a", and io port 0xF00D
>>bar()
>>{
>>	lock_kernel();
>>	return inb(0xF00D);
>>}
>>
>>int a;
>>foo()
>>{
>>	a = bar();
>>	a--;
>>	unlock_kernel();
>>}
> 
> But broken nonetheless, that kinda thing just looks ugly. Especially when 
> someone tries to call bar multiple times or consecutively or with the lock 
> already held or...

Yes, it is horribly ugly, but it is not broken.  As a function, if you 
document what you require your caller to do, there shouldn't be a 
problem.

Also, it is valid to have nested holds of the BKL.  You can never 
deadlock with another lock_kernel() which was done in the same process.

-- 
Dave Hansen
haveblue@us.ibm.com


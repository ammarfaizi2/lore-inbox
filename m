Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932082AbVIDRfF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932082AbVIDRfF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 13:35:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932083AbVIDRfF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 13:35:05 -0400
Received: from smeagol.dreamhost.com ([66.33.209.5]:19601 "EHLO
	smeagol.dreamhost.com") by vger.kernel.org with ESMTP
	id S932082AbVIDRfB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 13:35:01 -0400
Message-ID: <431B303A.8030707@jstenback.com>
Date: Sun, 04 Sep 2005 10:34:50 -0700
From: Johnny Stenback <jst@jstenback.com>
User-Agent: Mail/News 1.6a1 (X11/20050826)
MIME-Version: 1.0
To: Alexander Nyberg <alexn@telia.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: gcc coredump with 2.6.12+ kernels
References: <4319DC91.4020406@jstenback.com> <20050903174030.GA5406@localhost.localdomain> <431A7115.7070101@jstenback.com>
In-Reply-To: <431A7115.7070101@jstenback.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello again,

Got some more info that may be of value here. After I saw gcc coredump 
on me with 2.6.13 I tried halting my system and I saw a kernel panic 
while shutting down. The stack trace it showed me was:

   flush_tlb_mm+201
   exit_mmap+249
   mmput+49
   do_exit+434
   sys_reboot+264
   __group_send_sig_info+184
   group_send_info+118
   thread_return
   thread_return+82
   filp_close+110
   system_call+126

All typed down by hand since it never made it into a log, so there can 
be omissions and typos in there (and I didn't feel like typing down all 
those 64-bit hex numbers, sorry).

Johnny Stenback wrote:
> Alexander Nyberg wrote:
>> On Sat, Sep 03, 2005 at 10:25:37AM -0700 Johnny Stenback wrote:
>>
>>> Hey all,
>>>
>>> I just attempted to upgrade my kernel to 2.6.13. The kernel appears 
>>> to boot and run just fine, but when I try to build any larger 
>>> projects like Mozilla or the Linux kernel I constantly get segfaults 
>>> from gcc. All other apps *seem* to work fine. I remember seeing this 
>>> with 2.6.12 too when I tried to upgrade to it too but I didn't have 
>>> the time to investigate at all then, but now I see the same problem 
>>> with 2.6.13. The last version I've used that didn't show this problem 
>>> is 2.6.11.3, and that's running with no problems here.
>>>
>>> When gcc segfaults I get the following messages in the messages log:
>>>
>>> cc1[16775]: segfault at 0000000000000000 rip 00000036f2b0119e rsp 
>>> 00007fffffaaf0a0 error 4
>>> cc1[17086]: segfault at 0000000000000000 rip 00000036f2b0119e rsp 
>>> 00007fffffc4dfc0 error 4
>>> cc1[17788]: segfault at 0000000000000000 rip 00000036f2b0119e rsp 
>>> 00007fffffd777e0 error 4
>>> cc1[17823]: segfault at 0000000000000000 rip 00000036f2b0119e rsp 
>>> 00007fffffc4d630 error 4
>>> cc1[17895]: segfault at 0000000000000000 rip 00000036f2b0119e rsp 
>>> 00007ffffffd2330 error 4
>>>
>>> I'm on a dual AMD Opteron system, running x86_64 code. Using Fedora 
>>> Core 2 (yeah, old, I know...) and gcc 3.3.3 20040412.
>>
>> Does it still happen if you run:
>>
>> echo 0 > /proc/sys/kernel/randomize_va_space
> 
> Just tried that, and I still get the same error, and the same error in 
> the log too (just a different address):
> 
> cc1plus[2961]: segfault at 0000000000000000 rip
> 00000036f2b0119e rsp 00007fffffffdbb0 error 4
> 
> Anything else I can try?
> 
>> -
>> To unsubscribe from this list: send the line "unsubscribe 
>> linux-kernel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
>>
> 

-- 
jst

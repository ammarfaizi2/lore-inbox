Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261503AbVGYUoN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261503AbVGYUoN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 16:44:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261560AbVGYUoM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 16:44:12 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:26118 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261503AbVGYUoL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 16:44:11 -0400
Message-ID: <42E55012.5040307@tmr.com>
Date: Mon, 25 Jul 2005 16:48:18 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050511
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andreas Baer <lnx1@gmx.net>
CC: linux-kernel@vger.kernel.org, pmarques@grupopie.com
Subject: Re: Problem with Asus P4C800-DX and P4 -Northwood-
References: <42E4373D.1070607@gmx.net> <20050725051236.GS8907@alpha.home.local> <42E4E4B0.6050904@gmx.net> <20050725152425.GA24568@alpha.home.local> <42E542D5.3080905@gmx.net>
In-Reply-To: <42E542D5.3080905@gmx.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


One other oddment about this motherboard, Forgive if I have over-snipped 
this trying to make it relevant...

Andreas Baer wrote:
> 
> Willy Tarreau wrote:
> 
>> On Mon, Jul 25, 2005 at 03:10:08PM +0200, Andreas Baer wrote:

>> There clearly is a problem on the system installed on this machine. 
>> You should
>> use strace to see what this machine does all the time, it is 
>> absolutely not
>> expected that the user/system ratios change so much between two nearly
>> identical systems. So there are system calls which eat all CPU. You 
>> may want
>> to try strace -Tttt on the running process during a few tens of 
>> seconds. I
>> guess you'll immediately find the culprit amongst the syscalls, and it 
>> might
>> give you a clue.
> 
> 
> I hope you are talking about a hardware/kernel problem and not a software
> problem, because I tried it also with LiveCD's and they showed the same 
> results
> on this machine.
> I'm not a linux expert, that means I've never done anything like that 
> before,
> so it would be nice if you give me a hint what you see in this results. :)
> 

Am I misreading this, or is your program doing a bunch of seeks not 
followed by an i/o operation? I would doubt that's important, but your 
vmstat showed a lot of system time, and I just wonder if llseek() is 
more expensive in Linux than Windows. Or if your code is such that these 
calls are not optimized away by gcc.

> strace output for desktop:
> <--snip-->

> [pid  1431] 1122318636.262578 _llseek(3, 1761280, [1761280], SEEK_SET) = 0 <0.000017>
> [pid  1431] 1122318636.262654 _llseek(3, 1761280, [1761280], SEEK_SET) = 0 <0.000017>
> [pid  1431] 1122318636.262732 _llseek(3, 1761280, [1761280], SEEK_SET) = 0 <0.000017>
> [pid  1431] 1122318636.262809 _llseek(3, 1761280, [1761280], SEEK_SET) = 0 <0.000015>
> [pid  1431] 1122318636.262881 _llseek(3, 1761280, [1761280], SEEK_SET) = 0 <0.000015>
> [pid  1431] 1122318636.262952 _llseek(3, 1761280, [1761280], SEEK_SET) = 0 <0.000015>
> [pid  1431] 1122318636.263023 _llseek(3, 1761280, [1761280], SEEK_SET) = 0 <0.000015>
> [pid  1431] 1122318636.263094 _llseek(3, 1761280, [1761280], SEEK_SET) = 0 <0.000016>
> [pid  1431] 1122318636.263165 _llseek(3, 1761280, [1761280], SEEK_SET) = 0 <0.000015>
> [pid  1431] 1122318636.263237 _llseek(3, 1761280, [1761280], SEEK_SET) = 0 <0.000016>
> [pid  1431] 1122318636.263310 _llseek(3, 1761280, [1761280], SEEK_SET) = 0 <0.000015>
> [pid  1431] 1122318636.263381 _llseek(3, 1761280, [1761280], SEEK_SET) = 0 <0.000015>
> [pid  1431] 1122318636.263452 _llseek(3, 1761280, [1761280], SEEK_SET) = 0 <0.000015>
> [pid  1431] 1122318636.263523 _llseek(3, 1761280, [1761280], SEEK_SET) = 0 <0.000016>
> [pid  1431] 1122318636.263594 _llseek(3, 1761280, [1761280], SEEK_SET) = 0 <0.000015>
> [pid  1431] 1122318636.263666 _llseek(3, 1761280, [1761280], SEEK_SET) = 0 <0.000017>
> [pid  1431] 1122318636.263740 _llseek(3, 1761280, [1761280], SEEK_SET) = 0 <0.000024>
> [pid  1431] 1122318636.263841 _llseek(3, 1761280, [1761280], SEEK_SET) = 0 <0.000015>
> [pid  1431] 1122318636.263913 _llseek(3, 1761280, [1761280], SEEK_SET) = 0 <0.000015>
> [pid  1431] 1122318636.263984 _llseek(3, 1761280, [1761280], SEEK_SET) = 0 <0.000014>
> [pid  1431] 1122318636.264055 _llseek(3, 1761280, [1761280], SEEK_SET) = 0 <0.000015>
> [pid  1431] 1122318636.264127 _llseek(3, 1761280, [1761280], SEEK_SET) = 0 <0.000015>
> [pid  1431] 1122318636.264199 _llseek(3, 1761280, [1761280], SEEK_SET) = 0 <0.000015>
> [pid  1431] 1122318636.264271 _llseek(3, 1761280, [1761280], SEEK_SET) = 0 <0.000015>
> [pid  1431] 1122318636.264342 _llseek(3, 1761280, [1761280], SEEK_SET) = 0 <0.000016>
> [pid  1431] 1122318636.264414 _llseek(3, 1761280, [1761280], SEEK_SET) = 0 <0.000016>
> [pid  1431] 1122318636.264487 _llseek(3, 1761280, [1761280], SEEK_SET) = 0 <0.000015>
> [pid  1431] 1122318636.264558 _llseek(3, 1761280, [1761280], SEEK_SET) = 0 <0.000016>
> [pid  1431] 1122318636.264630 _llseek(3, 1761280, [1761280], SEEK_SET) = 0 <0.000015>
> [pid  1431] 1122318636.264710 _llseek(3, 1761280, [1761280], SEEK_SET) = 0 <0.000015>
> [pid  1431] 1122318636.264788 _llseek(3, 1761280, [1761280], SEEK_SET) = 0 <0.000016>
> [pid  1431] 1122318636.264861 _llseek(3, 1761280, [1761280], SEEK_SET) = 0 <0.000015>
> [pid  1431] 1122318636.264934 _llseek(3, 1761280, [1761280], SEEK_SET) = 0 <0.000016>
> [pid  1431] 1122318636.265006 _llseek(3, 1761280, [1761280], SEEK_SET) = 0 <0.000015>
> [pid  1431] 1122318636.265077 _llseek(3, 1761280, [1761280], SEEK_SET) = 0 <0.000015>
> [pid  1431] 1122318636.265149 _llseek(3, 1761280, [1761280], SEEK_SET) = 0 <0.000014>
> [pid  1431] 1122318636.265220 _llseek(3, 1761280, [1761280], SEEK_SET) = 0 <0.000015>
> [pid  1431] 1122318636.265292 _llseek(3, 1761280, [1761280], SEEK_SET) = 0 <0.000016>
> [pid  1431] 1122318636.265363 _llseek(3, 1761280, [1761280], SEEK_SET) = 0 <0.000016>
> [pid  1431] 1122318636.265436 _llseek(3, 1761280, [1761280], SEEK_SET) = 0 <0.000015>
> [pid  1431] 1122318636.265509 _llseek(3, 1761280, [1761280], SEEK_SET) = 0 <0.000015>
> [pid  1431] 1122318636.265580 _llseek(3, 1761280, [1761280], SEEK_SET) = 0 <0.000015>
> [pid  1431] 1122318636.265652 _llseek(3, 1761280, [1761280], SEEK_SET) = 0 <0.000016>
> [pid  1431] 1122318636.265726 _llseek(3, 1761280, [1761280], SEEK_SET) = 0 <0.000017>
> [pid  1431] 1122318636.265818 _llseek(3, 1761280, [1761280], SEEK_SET) = 0 <0.000015>
> [pid  1431] 1122318636.265891 _llseek(3, 1761280, [1761280], SEEK_SET) = 0 <0.000015>
> [pid  1431] 1122318636.265963 _llseek(3, 1761280, [1761280], SEEK_SET) = 0 <0.000015>
> [pid  1431] 1122318636.266034 _llseek(3, 1761280, [1761280], SEEK_SET) = 0 <0.000015>
> [pid  1431] 1122318636.266106 _llseek(3, 1761280, [1761280], SEEK_SET) = 0 <0.000015>
> [pid  1431] 1122318636.266177 _llseek(3, 1761280, [1761280], SEEK_SET) = 0 <0.000016>
> [pid  1431] 1122318636.266250 _llseek(3, 1761280, [1761280], SEEK_SET) = 0 <0.000016>
> [pid  1431] 1122318636.266322 _llseek(3, 1761280, [1761280], SEEK_SET) = 0 <0.000015>
> [pid  1431] 1122318636.266394 _llseek(3, 1761280, [1761280], SEEK_SET) = 0 <0.000015>
> [pid  1431] 1122318636.266466 _llseek(3, 1761280, [1761280], SEEK_SET) = 0 <0.000016>

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me

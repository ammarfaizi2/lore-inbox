Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268483AbUHLSPK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268483AbUHLSPK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 14:15:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268489AbUHLSPK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 14:15:10 -0400
Received: from mail.tmr.com ([216.238.38.203]:59409 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S268483AbUHLSPC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 14:15:02 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: Scheduler fairness problem on 2.6 series
Date: Thu, 12 Aug 2004 14:18:44 -0400
Organization: TMR Associates, Inc
Message-ID: <cfgbnu$fmf$1@gatekeeper.tmr.com>
References: <411A71F1.3090504@gmx.de><411A71F1.3090504@gmx.de> <411AAEDA.9070601@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1092334143 16079 192.168.12.100 (12 Aug 2004 18:09:03 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
In-Reply-To: <411AAEDA.9070601@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> Prakash K. Cheemplavam wrote:
> 
>> |
>> | I don't think it is the overhead. I rather think the way the kernel
>> | schedulers gives mpich and the cpu bound program  resources is unfair.
>>
>> Well, I don't know whether it helps, but I ran a profiler and these are
>> the functions which cause so much wasted CPU cycles when running 16
>> processes of my example with mpich:
>>
>> 124910    9.8170  vmlinux                  tcp_poll
>> 123356    9.6949  vmlinux                  sys_select
>> 85634     6.7302  vmlinux                  do_select
>> 71858     5.6475  vmlinux                  sysenter_past_esp
>> 62093     4.8801  vmlinux                  kfree
>> 51658     4.0600  vmlinux                  __copy_to_user_ll
>> 37495     2.9468  vmlinux                  max_select_fd
>> 36949     2.9039  vmlinux                  __kmalloc
>> 22700     1.7841  vmlinux                  __copy_from_user_ll
>> 14587     1.1464  vmlinux                  do_gettimeofday
>>
>> Is anything scheduler related?
> 
> 
> No
> 
> It looks like your select timeouts are too short and when the cpu load 
> goes up they repeatedly timeout wasting cpu cycles.
> I quote from `man select_tut` under the section SELECT LAW:
> 
> 1. You should always try use select without a timeout. Your program
>  should have nothing to do if there is no  data  available.  Code
>  that  depends  on timeouts is not usually portable and difficult
>  to debug.

There's a generalization which should confuse novice users... correctly 
used a timeout IS a debugging technique. Useful to detect when a peer 
has gone walkabout, as a common example.

Sounds as if the timeout is way too low here, however. Perhaps they are 
using it as poorly-done polling? In any case, not kernel misbehaviour.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me

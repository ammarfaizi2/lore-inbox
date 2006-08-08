Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965026AbWHHSkF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965026AbWHHSkF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 14:40:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965028AbWHHSkF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 14:40:05 -0400
Received: from mail.tmr.com ([64.65.253.246]:62857 "EHLO gaimboi.tmr.com")
	by vger.kernel.org with ESMTP id S965026AbWHHSkD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 14:40:03 -0400
Message-ID: <44D8DA8F.4040804@tmr.com>
Date: Tue, 08 Aug 2006 14:40:15 -0400
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates Inc, Schenectady NY
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tejun Heo <htejun@gmail.com>
CC: Harald Dunkel <harald.dunkel@t-online.de>, Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.18-rc2, problem to wake up spinned down drive?
References: <44CC9F7E.8040807@t-online.de> <44CF7E5A.2010903@gmail.com> <20060805212346.GE5417@ucw.cz> <44D6AE59.6070709@gmail.com> <44D789BA.4010206@t-online.de> <44D793E6.8010500@gmail.com>
In-Reply-To: <44D793E6.8010500@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tejun Heo wrote:

> Harald Dunkel wrote:
>
>> Tejun Heo wrote:
>>
>>> Pavel Machek wrote:
>>>
>>>>> echo 1 > /sys/bus/scsi/devices/1:0:0:0/power/state
>>>>
>>>> Really? I thought power/state takes 0/3 (for D0 and D3)
>>>
>>> Yes, of course.  My mistake.  Sorry about the confusion.  The correct
>>> command is 'echo -n 3 > /sys/bus/scsi/devices/x:y:z:w/power/state'.
>>>
>>
>> (Sure?  :-)
>
>
> The sleeping part is correct.  That will make libata put the disk to 
> sleep.
>
>> Now this did not work at all. The '-n 3' was probably
>> correct, but when I tried to access the disk, then it
>> did not spin up again (I waited for 5 minutes). There
>> was no message on the console, either.
>>
>> But I could not reproduce this problem.
>>
>> How do I monitor that the disk spins down and up?
>
>
> But the waking up part isn't.  You need to issue wake up explicitly by 
> doing 'echo -n 0 > /sys/...'  I've been a complete idiot in this 
> thread.  Please excuse me.  :-(
>
> I think the solution to your problem is adjusting command timeout to 
> more reasonable values which should make the problem more bearable. 
> It'll take some time to figure out how to make timeouts more 
> intelligent without breaking support for slow devices.  I'll work on 
> that. 

Tejun, would it be possible and sensible to either let the user tune 
this per-drive, or to have the kernel note how long {something} takes 
and auto-tune to that? As you said, the issue is not breaking slow devices.

-- 
bill davidsen <davidsen@tmr.com>
  CTO TMR Associates, Inc
  Doing interesting things with small computers since 1979


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287141AbSAHJCw>; Tue, 8 Jan 2002 04:02:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287145AbSAHJCo>; Tue, 8 Jan 2002 04:02:44 -0500
Received: from lacrosse.corp.redhat.com ([12.107.208.154]:44998 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S287141AbSAHJCh>; Tue, 8 Jan 2002 04:02:37 -0500
Message-ID: <3C3AB5AB.2080102@redhat.com>
Date: Tue, 08 Jan 2002 04:02:35 -0500
From: Doug Ledford <dledford@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7+) Gecko/20020103
X-Accept-Language: en-us
MIME-Version: 1.0
To: Doug Ledford <dledford@redhat.com>
CC: Thomas Gschwind <tom@infosys.tuwien.ac.at>,
        Nathan Bryant <nbryant@allegientsystems.com>,
        linux-kernel@vger.kernel.org
Subject: Re: i810_audio
In-Reply-To: <20020105031329.B6158@infosys.tuwien.ac.at> <3C3A2B5D.8070707@allegientsystems.com> <3C3A301A.2050501@redhat.com> <3C3AA6F9.5090407@redhat.com> <3C3AA9AD.6070203@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doug Ledford wrote:

> Doug Ledford wrote:
> 
> 
>>> Fixes it applies except for the SiS integration:
>>> * drain_dac
>>>   Use interruptible_sleep_on_timeout instead of schedule_timeout.
>>>   I think this is cleaner. 
>>
>>
>>
>>
>> This is fine.
> 
> 
> 
> Oops, this is one of the mistakes Ben pointed out to me. 
> interruptible_sleep_on_timeout(wait_queue head, timeout) overwrites the 
> wait queue that we've already added ourselves to.  schedule_timeout() 
> does the right thing here.  (interruptible_sleep_on_timeout doesn't 
> really buy us much of anything we care about either, so it's find to 
> stay with schedule_timeout)
> 
> 
> 
> 

OK, various clean ups made, and enough of the SiS code included that I think 
it should work, plus one change to the i810 interrupt handler that will 
(hopefully) render the other change you made to get_dma_addr and drain_dac 
unnecessary.  If people could please download and test the new 0.14 version 
of the driver on my site, I would appreciate it.

http://people.redhat.com/dledford/i810_audio.c.gz

-- 

  Doug Ledford <dledford@redhat.com>  http://people.redhat.com/dledford
       Please check my web site for aic7xxx updates/answers before
                       e-mailing me about problems


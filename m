Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262905AbUEQWKg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262905AbUEQWKg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 18:10:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262625AbUEQWKg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 18:10:36 -0400
Received: from mail.tmr.com ([216.238.38.203]:58884 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S262905AbUEQWKS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 18:10:18 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: dma ripping
Date: Mon, 17 May 2004 18:12:33 -0400
Organization: TMR Associates, Inc
Message-ID: <c8bd20$lgb$1@gatekeeper.tmr.com>
References: <20040515145800.GE24600@suse.de> <1084629809.4612.51.camel@linux.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1084831617 22027 192.168.12.100 (17 May 2004 22:06:57 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
In-Reply-To: <1084629809.4612.51.camel@linux.site>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniele Bernardini wrote:
> On Sat, 2004-05-15 at 16:58, Jens Axboe wrote:
> 
>>On Sat, May 15 2004, Daniele Bernardini wrote:
>>
>>>On Sat, 2004-05-15 at 12:14, Jens Axboe wrote:
>>>
>>>>On Fri, May 14 2004, Daniele Bernardini wrote:
>>>>
>>>>>Hi Folks, 
>>>>>
>>>>>I am trying to get cd ripping to work on a freshly installed SuSE 9.1 on
>>>>>IBM thinkpad R50 with dvdram drive. 
>>>>>
>>>>>It works for a while and then hangs. At this point nothing short of a
>>>>>reboot works. Ripping stop working when the message 
>>>>>	cdrom: dropping to single frame dma
>>>>>comes up. The system feels slow for a couple of seconds and then is back
>>>>>to normal, but no ripping until next reboot
>>>>>
>>>>>I am running the 2.6.4 compiled by SuSE.
>>>>
>>>>Can you retest with this small debug patch applied.
>>>>
>>>>--- drivers/cdrom/cdrom.c~	2004-05-15 12:12:24.770228291 +0200
>>>>+++ drivers/cdrom/cdrom.c	2004-05-15 12:13:25.101720866 +0200
>>>>@@ -1987,6 +1987,7 @@
>>>> 			struct request_sense *s = rq->sense;
>>>> 			ret = -EIO;
>>>> 			cdi->last_sense = s->sense_key;
>>>>+			printk("rip failed, sense %x/%x/%x\n", s->sense_key, s->asc, s->ascq);
>>>> 		}
>>>> 
>>>> 		if (blk_rq_unmap_user(rq, ubuf, bio, len))
>>>
>>>I did it and started ripping a cd it froze after 9 tracks, though did
>>>not see your message. I was looking at /var/log/messages (see below).
>>>BTW the system got instable and then froze had to power down. It
>>>happened before always after the ripping problem.
>>>
>>>Should I aswitch on debug for the cdrom?
>>
>>Just an idea - can you log vmstat 5 info while doing this burn? Maybe
>>there's still a little leak in there, so watch the ram usage
>>(used/free/swap/cache).
>>
>>Does your drive have dma enabled?
> 
> 
> dma was off. I turned it on and now everything is fine I am through the
> third cd without a glitch...
> 
> Thanks and sorry for being so stupid :)

It seems likely that this kernel was built to enable DMA on disk only, 
an option which is appropriate for a vendor kernel, I guess, but results 
in this behaviour.

In any case it appears that an unexpected feature of PIO mode is now 
behaving in a more useful way, so your report was of general benefit. I 
suspect many people may be unhappy with the CPU used to burn CDs with 
that kernel config, particularly on fast burners.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262367AbUKDTXy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262367AbUKDTXy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 14:23:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262327AbUKDTVO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 14:21:14 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:27912 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S262372AbUKDTTb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 14:19:31 -0500
Message-ID: <418A816C.3060705@tmr.com>
Date: Thu, 04 Nov 2004 14:22:20 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: DervishD <lkml@dervishd.net>
CC: Gene Heskett <gheskett@wdtv.com>, linux-kernel@vger.kernel.org,
       Valdis.Kletnieks@vt.edu,
       =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
Subject: Re: is killing zombies possible w/o a reboot?
References: <418965E0.8070508@tmr.com><418965E0.8070508@tmr.com> <20041104102655.GB23673@DervishD>
In-Reply-To: <20041104102655.GB23673@DervishD>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

DervishD wrote:
>     Hi Bill :)
> 
>  * Bill Davidsen <davidsen@tmr.com> dixit:
> 
>>>   I think that the parent (which is whatever process did the fork
>>>when you clicked your mouse) is still alive and forgetting to do the
>>>'wait()' for its children.
>>
>>It would be good to know what the PPID is, from ps or similar. Things 
>>from X are a pain, the parent is often something you don't want to kill. 
>>Sometimes you can reparent from command line, "bash -c foo&" or similar, 
>>so the parent can be killed without logging out.
> 
> 
>     Just use ps to reveal the family tree. Is not that hard ;)

That's what I just said, the original poster should tell us what the 
PPID is, which may help someone help the OP.
>  
> 
>>I would swear that the parent *is* init in some cases, which is puzzling 
>>since they should be reaped.
> 
> 
>     But that's OK :))) When a parent dies without waiting for its
> children, the zombies are reparented to init. That's correct. Then
> init will wait for them. The problem is that sometimes the signals
> doesn't arrive or the like. Then the zombies are laying around a bit,
> until a timer in 'init' reaps them. That's correct too: init can only
> wait for children when it receives SIGCHLD or periodically, using a
> timer. I've written a init program and that's the way I do it, just
> in case some signal gets lost.
> 
>     If init is the parent, all works ok, just wait a bit and all
> those zombies will really die ;)

Actually the ones in i/o probably won't, since the kernel either missed 
the completion or didn't time out if the hardware missed sending the 
int. And even plain non-i/o zombies, just how long "a bit" are you 
proposing?

Over Thanksgiving weekend I will try to look at the init code and see if 
a signal could be used to initiate a forced reap without waiting for the 
timer. By "look at" I mean not only "could I do that" but is it a good 
thing to do, before someone starts trying to explain that it's going to 
do something evil not to wait for the timer...

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me

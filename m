Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261772AbUKIX3k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261772AbUKIX3k (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 18:29:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261769AbUKIX3k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 18:29:40 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:36993 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261768AbUKIX2g
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 18:28:36 -0500
Message-ID: <41915353.1070507@tmr.com>
Date: Tue, 09 Nov 2004 18:31:31 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: DervishD <lkml@dervishd.net>
CC: =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>,
       linux-kernel@vger.kernel.org
Subject: Re: is killing zombies possible w/o a reboot?
References: <418A83EA.9090106@tmr.com><418A83EA.9090106@tmr.com> <20041104211138.GB25290@DervishD>
In-Reply-To: <20041104211138.GB25290@DervishD>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

DervishD wrote:
>     Hi Bill :)
> 
>  * Bill Davidsen <davidsen@tmr.com> dixit:
> 
>>>   If you are talking about others' children, then your call to
>>>waitpid() (or wait()) failed with ECHILD: not your child.
>>
>>That's what happened when I tried it a few months ago. I suppose one 
>>could try sending a SIGCHLD to the parent and see if it does something 
>>helpful.
> 
> 
>     Probably it won't do. If the zombies are there due to a signal
> delivery problem, sending a SIGCHLD to the parent will (probably)
> solve the problem. But the common case is that the parent is screwed
> up or simply so badly programmed that the only way of getting rid of
> the zombies is to kill the parent...

Wait a minute, in another message you just suggested that a SIGCHLD to 
init would cause the status to be reaped.
> 
>     Anyway I suppose that sending the SIGCHLD won't do any harm so it
> may be worth trying.

It won't hurt init, but some processes do use the SIGCHLD to trigger a 
wait(), which might hang the parent.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me

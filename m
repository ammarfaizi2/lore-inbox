Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261974AbUKCXO6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261974AbUKCXO6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 18:14:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261982AbUKCXGm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 18:06:42 -0500
Received: from mail.tmr.com ([216.238.38.203]:19207 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S261979AbUKCXEO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 18:04:14 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: is killing zombies possible w/o a reboot?
Date: Wed, 03 Nov 2004 18:07:15 -0500
Organization: TMR Associates, Inc
Message-ID: <418964A3.7030105@tmr.com>
References: <200411031353.39468.gene.heskett@verizon.net><200411031353.39468.gene.heskett@verizon.net> <20041103192648.GA23274@DervishD>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1099522550 5974 192.168.12.100 (3 Nov 2004 22:55:50 GMT)
X-Complaints-To: abuse@tmr.com
Cc: Gene Heskett <gene.heskett@verizon.net>, linux-kernel@vger.kernel.org,
       =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
To: DervishD <lkml@dervishd.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
In-Reply-To: <20041103192648.GA23274@DervishD>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

DervishD wrote:
>     Hi Gene :)
> 
>  * Gene Heskett <gene.heskett@verizon.net> dixit:
> 
>>>   Then the children are reparented to 'init' and 'init' gets rid
>>>of them. That's the way UNIX behaves.
>>
>>Unforch, I've *never* had it work that way.  Any dead process I've 
>>ever had while running linux has only been disposable by a reboot.
> 
> 
>     Well, you know, shit happens... Anyway, could you define 'dead'?
> Because if you're talking about zombies whose parent dies, they're
> killable easily: just wait until init reaps them (usually in less
> than 5 minutes since they dead). If you are talking about zombies who
> has their parent alive, then it's a bug in the application, not the
> kernel. In fact I wouldn't like if the kernel reaps my children
> before I do, just in case I want to do something.
> 
>     If you're talking about unkillable processes (those stuck in
> disk-sleep state), you're right: only rebooting can kill them
> (although sometimes they go out of D state and die normally). Bad
> luck for you if any dead process you've ever had while running linux
> has been of this kind :(

That often seems to be the case, the kernel thinks there's an i/o going 
on which isn't, and doesn't time it out. It would be nice if there were 
a way to get the kernel to abort all outstanding i/o on kill -9, but I'm 
sure if it were easy it would have happened. Timeouts in the application 
are useful, but in some cases I believe the process dies because it 
detects a long i/o time but has nothing to do but terminate, which 
creates the zombie.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266538AbUIMLk5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266538AbUIMLk5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 07:40:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266543AbUIMLk5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 07:40:57 -0400
Received: from colossus.systems.pipex.net ([62.241.160.73]:5532 "EHLO
	colossus.systems.pipex.net") by vger.kernel.org with ESMTP
	id S266538AbUIMLkz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 07:40:55 -0400
Message-ID: <4145873B.8070805@tungstengraphics.com>
Date: Mon, 13 Sep 2004 12:40:43 +0100
From: Keith Whitwell <keith@tungstengraphics.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a3) Gecko/20040817
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Airlie <airlied@linux.ie>,
       =?ISO-8859-1?Q?Michel_D=E4nzer?= <michel@daenzer.net>,
       =?ISO-8859-1?Q?Felix_K=FChling?= <fxkuehl@gmx.de>,
       DRI Devel <dri-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: radeon-pre-2
References: <E3389AF2-0272-11D9-A8D1-000A95F07A7A@fs.ei.tum.de>	 <9e47339104091011402e8341d0@mail.gmail.com>	 <Pine.LNX.4.58.0409102254250.13921@skynet>	 <1094853588.18235.12.camel@localhost.localdomain>	 <Pine.LNX.4.58.0409110137590.26651@skynet>	 <1094873412.4838.49.camel@admin.tel.thor.asgaard.local>	 <Pine.LNX.4.58.0409110600120.26651@skynet>	 <1094913222.21157.61.camel@localhost.localdomain>	 <9e47339104091109463694ffd3@mail.gmail.com>	 <1094919681.21157.119.camel@localhost.localdomain> <9e47339104091110272101ecfb@mail.gmail.com>
In-Reply-To: <9e47339104091110272101ecfb@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Smirl wrote:
> On Sat, 11 Sep 2004 17:21:22 +0100, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> 
>>On Sad, 2004-09-11 at 17:46, Jon Smirl wrote:
>>
>>>User 1's game queues up 20ms of 3D drawing commands.
>>>Process swap to user 2.  ->quiesce() is going to take 20ms.
>>>User 2's timeslice expires and we go back to user 1.
>>>User 1 queues up another 20ms.
>>>
>>>User 2's editor is never going to function.
>>
>>If you implement it wrongly sure. If you implemented it right then
>>this occurs.
>>
>>User 1 queues 20 ms of 3D commands
>>User 1 is pre-empted
>>User 2 wants the 2D engine
>>User 2 beings wait for 2D
>>User 2 sleeps
>>User 1 wakes
>>User 1 beings wait for 3D but discovers a claim is in progress
>>User 1 sleeps
>>User 2 wakes, runs commands
> 
> 
> This model destroys the parallel processing between the main CPU and the GPU.

And this is the reason that cards tend to do 2d and 3d through the same 
command queue, and often the same hardware at the backend - there's no need on 
such hardware to quiesce between acclerated 2d and 3d commands.

Of course, if either user ends up wanting to touch the framebuffer directly, 
they will have to flush the queue & wait for quiescence.  There's nothing 
particularly 2D or 3D about this - they both have fallbacks, and they're both 
faster if fallbacks can be avoided.

Keith (who has lost track of who's arguing about what or why)

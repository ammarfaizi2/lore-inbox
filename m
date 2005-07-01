Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263297AbVGAJqS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263297AbVGAJqS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 05:46:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263298AbVGAJqS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 05:46:18 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:63215 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S263297AbVGAJqP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 05:46:15 -0400
Message-ID: <42C51082.6090603@mvista.com>
Date: Fri, 01 Jul 2005 02:44:34 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Marcelo Tosatti <marcelo.tosatti@cyclades.com>, ocroquette@free.fr,
       torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: setitimer expire too early (Kernel 2.4)
References: <42C444AA.2070508@free.fr>	<20050630165053.GA8220@logos.cnet> <20050630160537.7d05d467.akpm@osdl.org>
In-Reply-To: <20050630160537.7d05d467.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Marcelo Tosatti <marcelo.tosatti@cyclades.com> wrote:
> 
>>On Thu, Jun 30, 2005 at 09:14:50PM +0200, Olivier Croquette wrote:
>>
>>>I am refering to this bug:
>>>
>>>http://bugzilla.kernel.org/show_bug.cgi?id=4569
>>>
>>>A thread led to a patch from Paulo:
>>>
>>>http://kerneltrap.org/mailarchive/1/message/59454/flat
>>>
>>>This patch has been included in the kernel 2.6.12.
>>>
>>>1. How can I easily check if the patch is planned for include in the 2.4?
>>>
>>>2. I downloaded the full 2.4.31 source code. The patch appears not to be 
>>>included. Where/Who should I signal that?
>>
>>And what about the side effects:
>>This however will produce pathological cases, like having a idle system
>>being requested 1 ms timeouts will give systematically 2 ms timeouts,
>>whereas currently it simply gives a few usecs less than 1 ms. 

I don't see why an idle system would align such request in this way any more 
than a busy one.  In both cases the range would be ~0 to 1ms (which is what the 
standard says it should be) with an average of .5ms.  Any other result is caused 
by syncing, in some way with the tick clock.
> 
> 
> (20ms rather than 10ms)
> 
> 
>>Linus, Andrew, do you consider this critical enough to be merged to 
>>the v2.4 tree?
> 
> 
> No.  I'd expect this would hurt more people than it would benefit.

Still, it is the "correct" thing to do (standard wise, etc...).

It is rather amazing that this has been in the system this long.  Should have 
been fixed long ago...

-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/

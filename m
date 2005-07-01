Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261576AbVGAVd0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261576AbVGAVd0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 17:33:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261565AbVGAVdZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 17:33:25 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:62451 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262901AbVGAVQD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 17:16:03 -0400
Message-ID: <42C5B242.5010002@mvista.com>
Date: Fri, 01 Jul 2005 14:14:42 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
CC: Olivier Croquette <ocroquette@free.fr>, Andrew Morton <akpm@osdl.org>,
       torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: setitimer expire too early (Kernel 2.4)
References: <42C444AA.2070508@free.fr> <20050630165053.GA8220@logos.cnet> <20050630160537.7d05d467.akpm@osdl.org> <42C582CC.5050907@free.fr> <20050701144901.GC11975@logos.cnet>
In-Reply-To: <20050701144901.GC11975@logos.cnet>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:
> Hi Olivier,
> 
> On Fri, Jul 01, 2005 at 07:52:12PM +0200, Olivier Croquette wrote:
> 
>>Andrew Morton wrote:
>>
>>>>Linus, Andrew, do you consider this critical enough to be merged to 
>>>>the v2.4 tree?
>>>
>>>
>>>No.  I'd expect this would hurt more people than it would benefit.
>>
>>
>>Probably.
>>Does that mean that the kernel 2.4 will keep this bug for ever?
> 
> 
> Probably, yes. I've never heard such complaints before your message.
> 
> The right way to do it seems something else BTW:
> 
> quoting Nish Aravamudan (http://lkml.org/lkml/2005/4/29/240):
> 
> Your patch is the only way to guarantee no early timeouts, as far as I know.
> 
> Really, what you want is:
> 
> on adding timers, take the ceiling of the interval into which it could be added
> on expiring timers, take the floor
> 
> This combination guarantees no timers go off early (and takes away
> many of these corner cases). I do exactly this in my patch, btw.

IMNSHO that is just another way of saying "add 1 to the jiffie count" which is 
what the proposed patch does.


-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/

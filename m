Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261973AbVFJBhN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261973AbVFJBhN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 21:37:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262375AbVFJBhN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 21:37:13 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:27640 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261973AbVFJBhH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 21:37:07 -0400
Message-ID: <42A8EE8C.1010406@mvista.com>
Date: Thu, 09 Jun 2005 18:36:12 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Daniel Walker <dwalker@mvista.com>
CC: linux-kernel@vger.kernel.org, tglx@linutronix.de
Subject: Re: RT and timers
References: <Pine.LNX.4.44.0506091639380.11001-100000@dhcp153.mvista.com>
In-Reply-To: <Pine.LNX.4.44.0506091639380.11001-100000@dhcp153.mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Walker wrote:
> On Thu, 9 Jun 2005, George Anzinger wrote:
> 
> 
>>So, in short, I don't see the point to the suggested change.  If the kernel is 
>>late, it is best to let it catch up as fast as it can by looping here.  The only 
>>counter argument that makes sense to me it that in this case we are starving 
>>other softirqd driven tasks, but that should, if any thing, lighten the timer 
>>load and let this complete faster.
> 
> 
> I'm mainly concerned because that loop never breaks . It seems like there 
> could be a condition when the loop never stops. For instance , a very 
> accurate timer interrupt, and timers that continually reset themselves.

As I recall, it is not possible to put a timer in the list for the current time. 
  It will be put in the next tick slot or, with HRT, be passed to the hrt code. 
  The only case this might fail is if a kernel hrt user restarts his timer for 
"now" or prior to "now".  This is bad and hard to correct.  The posix-timers 
code does not restart timers until the signal is delivered and then from the 
user thread, not the softirq context.

Did I miss something here?

-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261295AbVEXA5K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261295AbVEXA5K (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 20:57:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261297AbVEXA46
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 20:56:58 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:37109 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261270AbVEXAx0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 20:53:26 -0400
Message-ID: <42927AE7.1070103@mvista.com>
Date: Mon, 23 May 2005 17:52:55 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: oleg@tv-sign.ru, linux-kernel@vger.kernel.org
Subject: Re: [PATCH rc4-mm2 2/2] posix-timers: use try_to_del_timer_sync()
References: <42909DC2.7922E05D@tv-sign.ru>	<42926F83.9050608@mvista.com> <20050523172923.26068053.akpm@osdl.org>
In-Reply-To: <20050523172923.26068053.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> George Anzinger <george@mvista.com> wrote:
> 
>>Oleg Nesterov wrote:
>>
>>>sys_timer_settime/sys_timer_delete needs to delete k_itimer->real.timer
>>>synchronously while holding ->it_lock, which is also locked in posix_timer_fn.
>>>
>>>This patch removes timer_active/set_timer_inactive which plays with
>>>timer_list's internals in favour of using try_to_del_timer_sync(),
>>>which was introduced in the previous patch.
>>
>>Is there a particular reason for this, like it does not work, for example, or 
>>are you just trying to clean up code?
> 
> 
> The posix-timers code is poking about in the internals of the timer_list
> implementation.  It shouldn't, and finding some way to fix that up is
> desirable.

I see, and agree.  Could you give me a bit to work on this.  I would like to 
come up with something that is compatable with the HRT patch.  At this time I am 
waiting for John Stultz's time keeping changes to get in before pushing HRT, but 
I would still like it to get it into the kernel.



-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/

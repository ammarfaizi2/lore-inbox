Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261870AbVEKBTP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261870AbVEKBTP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 21:19:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261871AbVEKBTP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 21:19:15 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:59385 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261870AbVEKBTH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 21:19:07 -0400
Message-ID: <42812C49.7060501@mvista.com>
Date: Tue, 10 May 2005 14:48:57 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Lameter <christoph@lameter.com>
CC: Oleg Nesterov <oleg@tv-sign.ru>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, mingo@elte.hu, kenneth.w.chen@intel.com
Subject: Re: [RFC][PATCH] timers fixes/improvements
References: <424D373F.1BCBF2AC@tv-sign.ru> <424E6441.12A6BC03@tv-sign.ru>  <Pine.LNX.4.58.0505091312490.27740@graphe.net> <20050509144255.17d3b9aa.akpm@osdl.org> <Pine.LNX.4.58.0505091449580.29090@graphe.net> <42808B84.BCC00574@tv-sign.ru> <Pine.LNX.4.58.0505101212350.20718@graphe.net>
In-Reply-To: <Pine.LNX.4.58.0505101212350.20718@graphe.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wonder if this problem might benifit from the "breakpoint on write" capability 
in kgdb.  If you are using the kgdb in the mm patch, look in 
Documentation/i386/kgdb/gdbinit.hw at the hwwbrk macro.  You will, of course, 
have to source this file from gdb to load the macro.  Then you can use the gdb 
command: help hwwbrk to get info on how to use it.

If the location is not written to too often this should help find the offender.

George
-- 

Christoph Lameter wrote:
> On Tue, 10 May 2005, Oleg Nesterov wrote:
> 
> 
>>>There is no corruption around ptype_all as you can see from the log. There
>>>is a list of hex numbers which are from ptype_all -8 to ptype_all +8.
>>>Looks okay to me.
>>
>>Still ptype_all could be accessed (and corrupted) as ptype_base[16].
>>
>>Christoph, could you please reboot with this patch?
> 
> 
> Ok. I added padding before and after ptype_all.
> With padding the problem no longer occurs.
> 
> However, if the padding is put before ptype_base and after ptype_all
> then the problem occurs.
> 
> So it looks like this is due to writes intended for ptype_base going
> out of bounds. However, there nothing in the code in net/core/dev.c
> that would allow this to happen. Also why is the list head set
> to 0x10:0x10?
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/

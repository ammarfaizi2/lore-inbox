Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964943AbVI0UhH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964943AbVI0UhH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 16:37:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965019AbVI0UhH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 16:37:07 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:24567 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S964943AbVI0UhG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 16:37:06 -0400
Message-ID: <4339AD36.2060209@mvista.com>
Date: Tue, 27 Sep 2005 13:36:06 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tim Bird <tim.bird@am.sony.com>
CC: Roman Zippel <zippel@linux-m68k.org>, Thomas Gleixner <tglx@linutronix.de>,
       Ingo Molnar <mingo@elte.hu>, Christopher Friesen <cfriesen@nortel.com>,
       linux-kernel@vger.kernel.org, akpm@osdl.org, johnstul@us.ibm.com,
       paulmck@us.ibm.com
Subject: Re: [ANNOUNCE] ktimers subsystem
References: <Pine.LNX.4.61.0509271839140.3728@scrub.home> <4339918C.2040405@am.sony.com>
In-Reply-To: <4339918C.2040405@am.sony.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Bird wrote:
> Roman Zippel wrote:
> 
>>On Sun, 25 Sep 2005, Thomas Gleixner wrote:
>>
>>>Can you please point out which architectures do not have a 32x32->64
>>>instruction ?
> 
> 
> <snip>
> 
>>For the rest you might want to check <asm/div64.h>, if div64 has to be 
>>emulated, there are good chances this instruction has to be emulated as 
>>well (especially in smaller embedded archs).
> 
> 
> Hmmm.  In my experience, there are several embedded platforms
> with a 32x32->64 instruction, which are lacking a div64 instruction.
> I don't think checking for div64 is a very good metric here.

Also, even having a div64 instruction does not eliminate the asm/div64.h 
as it checks for results that are >32-bits and does the right thing. 
For example, letting the x86 do this divide with such a result, results 
in a trap.

This is why we need to be very careful where we use the div_ll_l_rem() 
which accesses just this instruction.

-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/

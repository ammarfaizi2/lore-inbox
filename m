Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262173AbVATXOF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262173AbVATXOF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 18:14:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262218AbVATXOE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 18:14:04 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:6396 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262173AbVATXMX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 18:12:23 -0500
Message-ID: <41F03AD2.4010803@mvista.com>
Date: Thu, 20 Jan 2005 15:12:18 -0800
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       matthias@corelatus.se,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: patch to fix set_itimer() behaviour in boundary cases
References: <16872.55357.771948.196757@antilipe.corelatus.se>	 <20050115013013.1b3af366.akpm@osdl.org>	 <1105830384.16028.11.camel@localhost.localdomain>	 <1105877497.8462.0.camel@laptopd505.fenrus.org>	 <41EEF284.2010600@mvista.com> <1106208433.4192.0.camel@laptopd505.fenrus.org>
In-Reply-To: <1106208433.4192.0.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> On Wed, 2005-01-19 at 15:51 -0800, George Anzinger wrote:
> 
>>Arjan van de Ven wrote:
>>
>>>On Sun, 2005-01-16 at 00:58 +0000, Alan Cox wrote:
>>>
>>>
>>>>On Sad, 2005-01-15 at 09:30, Andrew Morton wrote:
>>>>
>>>>
>>>>>Matthias Lang <matthias@corelatus.se> wrote:
>>>>>These are things we probably cannot change now.  All three are arguably
>>>>>sensible behaviour and do satisfy the principle of least surprise.  So
>>>>>there may be apps out there which will break if we "fix" these things.
>>>>>
>>>>>If the kernel version was 2.7.0 then well maybe...
>>>>
>>>>These are things we should fix. They are bugs. Since there is no 2.7
>>>>plan pick a date to fix it. We should certainly error the overflow case
>>>>*now* because the behaviour is undefined/broken. The other cases I'm not
>>>>clear about. setitimer() is a library interface and it can do the basic
>>>>checking and error if it wants to be strictly posixly compliant.
>>>
>>>
>>>why error?
>>>I'm pretty sure we can make a loop in the setitimer code that detects
>>>we're at the end of jiffies but haven't upsurped the entire interval the
>>>user requested yet, so that the code should just do another round of
>>>sleeping...
>>>
>>
>>That would work for sleep (but glibc uses nanosleep for that) but an itimer 
>>delivers a signal.  Rather hard to trap that in glibc.
>>
> 
> This one I meant to fix in the kernel fwiw; we can put that loop inside
> the kernel easily I'm sure

Yes, but it will increase the data size of the timer...


-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/


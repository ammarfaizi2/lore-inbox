Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932129AbWAESFE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932129AbWAESFE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 13:05:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932133AbWAESFD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 13:05:03 -0500
Received: from smtp-out.google.com ([216.239.45.12]:28408 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S932129AbWAESFA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 13:05:00 -0500
Message-ID: <43BD5E6F.1040000@mbligh.org>
Date: Thu, 05 Jan 2006 09:59:11 -0800
From: Martin Bligh <mbligh@mbligh.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matt Mackall <mpm@selenic.com>
CC: Arjan van de Ven <arjan@infradead.org>,
       Chuck Ebbert <76306.1226@compuserve.com>, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Linus Torvalds <torvalds@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Dave Jones <davej@redhat.com>,
       Tim Schmielau <tim@physik3.uni-rostock.de>
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer  compilers
References: <200601041959_MC3-1-B550-5EE2@compuserve.com> <43BC716A.5080204@mbligh.org> <1136463553.2920.22.camel@laptopd505.fenrus.org> <20060105170255.GK3356@waste.org>
In-Reply-To: <20060105170255.GK3356@waste.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall wrote:
> On Thu, Jan 05, 2006 at 01:19:12PM +0100, Arjan van de Ven wrote:
> 
>>>What would be nice to do is pack all the frequently used code together 
>>>in close proximity. Would probably have much larger effects with 
>>>userspace code, esp where we touch disk (which is more page-size 
>>>granularity), but is probably worth doing with kernel code too (where 
>>>AFAICS we'd only get cacheline granular).
>>
>>in the kernel we could make a .text.rare section for functions, which we
>>could annotate with __rare.
>>The other way around, __fastpath or whatever is a bad idea, everyone
>>will consider all of their own functions as such (just like inline ;)...
>>go-fast-stripes all the way :-(
> 
> 
> Gah, we don't want to do this by hand in either direction. It's the
> inline nightmare all over again.

Absolutely.

> It'd be better to take a tool like oprofile and run it against some
> test suite to generate a usage map, then re-sort based on the map.
> Then ship a "standard" map in the stock tarball. Note that the map
> need only list the popular functions.
> 
> The ideal sampling tool can collect second order information: which
> functions are executed near each other as well as which are executed
> most frequently.

There are tools already around to do this sort of thing as well - 
"profile directed optimization" or whatever they called it. Seems to be 
fairly commonly done with userspace, but not with the kernel. I'm not 
sure why not ... possibly because it's not available for gcc ?

M.

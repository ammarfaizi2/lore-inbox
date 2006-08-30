Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750759AbWH3JRn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750759AbWH3JRn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 05:17:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750768AbWH3JRn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 05:17:43 -0400
Received: from gw.goop.org ([64.81.55.164]:46501 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1750759AbWH3JRm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 05:17:42 -0400
Message-ID: <44F557A8.1030605@goop.org>
Date: Wed, 30 Aug 2006 02:17:28 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060803)
MIME-Version: 1.0
To: Chuck Ebbert <76306.1226@compuserve.com>
CC: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       Jan Beulich <jbeulich@novell.com>, Zachary Amsden <zach@vmware.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC 0/6] Implement per-processor data areas for i386.
References: <200608300503_MC3-1-C9C4-92F7@compuserve.com>
In-Reply-To: <200608300503_MC3-1-C9C4-92F7@compuserve.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck Ebbert wrote:
>> This patch implements per-processor data areas by using %gs as the
>> base segment of the per-processor memory.
>>     
> This changes the ABI for signals and ptrace() and that seems like
> a bad idea to me.
>   

I don't believe it does; it certainly shouldn't change the usermode 
ABI.  How do you see it changing?

> And the way things are done now is so ingrained into the i386
> kernel that I'm not sure it can be done.  E.g. I found two
> open-coded implementations of current, one in kernel_fpu_begin()
> and one in math_state_restore().
>   

That's OK.  The current task will still be available in thread_info; 
this is needed for very early CPU bringup anyway, before the PDA has 
been set up.  The vast majority of "get current task" operations can be 
swept up by changing "current" however.

> Can you describe what it is about the way things work now that
> prevents dynamic allocation?
>   

To be honest, I haven't looked at percpu.h in great detail.  I was 
making assumptions about how it works, but it looks like they were wrong.

    J

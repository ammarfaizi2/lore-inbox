Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751110AbWHGGXw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751110AbWHGGXw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 02:23:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751115AbWHGGXv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 02:23:51 -0400
Received: from gw.goop.org ([64.81.55.164]:42423 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1751110AbWHGGXu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 02:23:50 -0400
Message-ID: <44D6DC75.90203@goop.org>
Date: Sun, 06 Aug 2006 23:23:49 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060613)
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
CC: virtualization@lists.osdl.org, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@sous-sol.org>
Subject: Re: [PATCH 1/4] x86 paravirt_ops: create no_paravirt.h for native
 ops
References: <1154925835.21647.29.camel@localhost.localdomain> <200608070730.17813.ak@muc.de> <44D6D315.2030907@goop.org> <200608070802.40614.ak@muc.de>
In-Reply-To: <200608070802.40614.ak@muc.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
>> so it would be  
>> nice to use one of the other serializing instructions in this case.
>>     
>
> You would first need to find one that works in ring 3. On x86-64 it is 
> used in the gettimeoday vsyscall in ring 3 to synchronize the TSC and 
> afaik John was about to implement that for i386 too.
>   

Well, that's really usermode code, so I don't think we'd necessarily 
touch it at all.  It's not the same problem as the (single, at the 
moment) ring 0 use.

> BTW another issue that I haven't checked but we will need to make
> this also an alternative() for another case - it is faily important
> to patch it out on Intel systems with a synchronized TSC where it is
> fairly expensive. That is also not done yet on i386, but will be 
> likely once vsyscall gettimeofday is implemented.
>
> So basically you would need double patching. Ugly.
>   

Yeah.  I guess the cleanest way to do that is do the paravirt 
substitution, and then nop it out later if it isn't needed in the vsyscall.

> I would recommend to keep it out of para ops.

It's hardly a big deal either way.  There's only one in-kernel use of it.

    J

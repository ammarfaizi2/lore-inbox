Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751243AbWIKINd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751243AbWIKINd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 04:13:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751247AbWIKINc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 04:13:32 -0400
Received: from gw.goop.org ([64.81.55.164]:53199 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1751243AbWIKINc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 04:13:32 -0400
Message-ID: <45051AA5.6090102@goop.org>
Date: Mon, 11 Sep 2006 01:13:25 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060907)
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       Laurent Riffard <laurent.riffard@free.fr>,
       Arjan van de Ven <arjan@infradead.org>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       Jeremy Fitzhardinge <jeremy@xensource.com>
Subject: Re: 2.6.18-rc6-mm1: GPF loop on early boot
References: <200609101334.34867.ak@suse.de> <20060910132614.GA29423@elte.hu> <20060910093307.a011b16f.akpm@osdl.org> <450499D3.5010903@goop.org> <20060911051028.GA10084@elte.hu> <450510E0.8080906@goop.org> <20060911072959.GA2322@elte.hu> <45051330.5050205@goop.org> <20060911073649.GA3188@elte.hu> <4505176B.6030803@goop.org> <20060911080115.GB5328@elte.hu>
In-Reply-To: <20060911080115.GB5328@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> the ratio between the number of syscalls vs. the number of context 
> switches is 1-2 orders of magnitude. So a loss of 9 cycles in the 
> syscall path is roughly equal to a loss of 90-900 cycles in switch_to() 
> costs ...
>   

I agree.

> the TLS ABI is just a gcc stupidity. Why did they pick the _second_ 
> extra selector, instead of the first one ...?

Well, it doesn't matter which they chose if its the same for user and 
kernel space. Why does x86-64 have swapgs rather than swapfs?

>  Anyway, perhaps this could 
> be solved by extending gcc with a switch to also generate __thread code 
> off %fs. Probably not worth the pain though ...

If there's gcc hacking to be done, it would be trying to get it make the 
TLS offsets from the PDA/TCB positive rather than negative...

    J

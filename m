Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268219AbUHQNFa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268219AbUHQNFa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 09:05:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268214AbUHQNFa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 09:05:30 -0400
Received: from mail.ocs.com.au ([202.147.117.210]:13767 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S268219AbUHQNFJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 09:05:09 -0400
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Paulo Marques <pmarques@grupopie.com>
Cc: Ingo Molnar <mingo@elte.hu>, Andi Kleen <ak@muc.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] Latency Tracer, voluntary-preempt-2.6.8-rc4-O6 
In-reply-to: Your message of "Tue, 17 Aug 2004 13:14:32 +0100."
             <4121F6A8.7030503@grupopie.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 17 Aug 2004 23:05:00 +1000
Message-ID: <6450.1092747900@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Aug 2004 13:14:32 +0100, 
Paulo Marques <pmarques@grupopie.com> wrote:
>Keith Owens wrote:
>> On Sat, 14 Aug 2004 05:50:50 +0100, 
>> Paulo Marques <pmarques@grupopie.com> wrote:
>> 
>>>Well, I found some time and decided to give it a go :)
>> 
>> 
>> This patch regresses some recent changes to kallsyms which handle
>> aliased symbols, IOW symbols with the same address.  The speed up is
>> very good, but it has two problems with repeated addresses.
>
>Hi,
>
>I've been messing with scripts/kallsyms.c to try to follow Andi Kleen's 
>suggestion of calculating the markers at compile time. This would make 
>the code in kernel/kallsyms.c much simpler.
>
>In the process I could get rid of the aliased symbols at compile time 
>also. There are only 2 places where they might matter:
>
>  - the kallsyms_lookup_name function. GREP'ing through the code shows 
>that this function is only used in arch/ppc64/xmon/xmon.c. Does xmon 
>need to know about aliased symbols?

kdb uses aliased symbols as well.  The user can enter any kernel symbol
name and have it converted to an address.


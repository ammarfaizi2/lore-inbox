Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030228AbWJCPxK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030228AbWJCPxK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 11:53:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030229AbWJCPxJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 11:53:09 -0400
Received: from gw.goop.org ([64.81.55.164]:1762 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1030228AbWJCPxI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 11:53:08 -0400
Message-ID: <45228762.7000005@goop.org>
Date: Tue, 03 Oct 2006 08:53:06 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060927)
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Hugh Dickens <hugh@veritas.com>,
       Michael Ellerman <michael@ellerman.id.au>,
       Paul Mackerras <paulus@samba.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 1/6] Generic implemenatation of BUG.
References: <20061003010842.438670755@goop.org>> <20061003010930.971200285@goop.org> <20061003103740.GB73786@muc.de>
In-Reply-To: <20061003103740.GB73786@muc.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
>> Because powerpc also records the function name, I added this to i386 and
>> x86-64 for consistency.  Strictly speaking the function name is redundant with
>> kallsyms, so perhaps it can be dropped from powerpc.
>>     
>
> It would be good to change it to use kallsyms() then.
>   

It does, in effect, when it prints the oops message and backtrace.

>>  
>>  #ifdef CONFIG_BUG
>> +
>> +#ifdef CONFIG_GENERIC_BUG
>> +struct bug_entry {
>> +	unsigned long	bug_addr;
>> +#ifdef CONFIG_DEBUG_BUGVERBOSE
>> +	const char	*file;
>> +	unsigned short	line;
>> +#endif
>> +	unsigned short	flags;
>>     
>
> Can't you put the flags into the high bits of the line? I don't think
> we have any 64kLOC files.

I thought about it, but it would still be padded out to 12 bytes on 
i386, and more on 64-bit platforms.  And it doesn't matter that much.


    J

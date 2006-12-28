Return-Path: <linux-kernel-owner+w=401wt.eu-S1753651AbWL1RPF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753651AbWL1RPF (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 12:15:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754888AbWL1RPF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 12:15:05 -0500
Received: from javad.com ([216.122.176.236]:1668 "EHLO javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753651AbWL1RPC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 12:15:02 -0500
From: Sergei Organov <osv@javad.com>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: Re: moxa serial driver testing
References: <45222E7E.3040904@gmail.com> <87wt7hw97c.fsf@javad.com>
	<4522ABC3.2000604@gmail.com> <878xjx6xtf.fsf@javad.com>
	<4522B5C2.3050004@gmail.com> <87mz8borl2.fsf@javad.com>
	<45251211.7010604@gmail.com> <87zmcaokys.fsf@javad.com>
	<45254F61.1080502@gmail.com> <87vemyo9ck.fsf@javad.com>
	<4af2d03a0610061355p5940a538pdcbd2cda249161e8@mail.gmail.com>
	<87vemtnbyg.fsf@javad.com> <452A1862.9030502@gmail.com>
	<87r6urket6.fsf@javad.com> <552766292581216610@wsc.cz>
	<552766292581216610@wsc.cz> <554564654653216610@wsc.cz>
Date: Thu, 28 Dec 2006 20:14:43 +0300
In-Reply-To: <554564654653216610@wsc.cz> (Jiri Slaby's message of "Wed, 27
 Dec
	2006 14:36:56 +0100 (CET)")
Message-ID: <87d564x7r0.fsf@javad.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Slaby <jirislaby@gmail.com> writes:

>> Jiri Slaby <jirislaby@gmail.com> writes:
>> 
>> > Could you test the patch below, if something changes?
>> 
>> Just tested with low_latency commented out. Still oopses:
>> 
>> BUG: unable to handle kernel NULL pointer dereference at virtual address 00000008
>>  printing eip:
>> f8f1730f
>> *pde = 00000000
>> Oops: 0000 [#1]
>> SMP 
>> Modules linked in: ...
>> CPU:    0
>> EIP:    0060:[<f8f1730f>]    Tainted: P      VLI
>> EFLAGS: 00010046   (2.6.18-3-686 #1) 
>> EIP is at mxser_receive_chars+0x21b/0x249 [mxser_new]
>
> Yes, port->tty still somewhere becomes NULL -- does this patch help?

Hi, Jiri!

I'm so sorry, I don't know what I smoked yesterday, but the latest
version you've sent me does not have this problem anymore! I think I
copied compiled module to modules directory for different kernel and
thus tested old code all the time. BTW, should you tell me that the
ports are now called /dev/ttyMIx instead of /dev/ttyMx, I think I'd
notice my mistake earlier. Yes, in fact I didn't test any version where
ports are called /dev/ttyMIx until now! In particular, it means that
maybe some of the recent changes you've made yesterday based on my wrong
reports are not in fact required.

Anyway, the only mxser-specific problem that currently remains for
me and that I didn't see before, is the following:

# rmmod mxser_new
Trying to free already-free IRQ 58
Trying to free nonexistent resource <0000000000009000-000000000000903f>
Trying to free nonexistent resource <0000000000008800-0000000000008800>
#

-- Sergei.

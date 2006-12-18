Return-Path: <linux-kernel-owner+w=401wt.eu-S1753982AbWLRNPS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753982AbWLRNPS (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 08:15:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753981AbWLRNPS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 08:15:18 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:60262 "EHLO
	ebiederm.dsl.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753982AbWLRNPQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 08:15:16 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Tobias Diedrich <ranma@tdiedrich.de>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Tobias Diedrich <ranma+kernel@tdiedrich.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Yinghai Lu <yinghai.lu@amd.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: IO-APIC + timer doesn't work (was: Linux 2.6.20-rc1)
References: <Pine.LNX.4.64.0612131744290.5718@woody.osdl.org>
	<20061216174536.GA2753@melchior.yamamaya.is-a-geek.org>
	<Pine.LNX.4.64.0612160955370.3557@woody.osdl.org>
	<20061216225338.GA2616@melchior.yamamaya.is-a-geek.org>
	<20061216230605.GA2789@melchior.yamamaya.is-a-geek.org>
	<Pine.LNX.4.64.0612161518080.3479@woody.osdl.org>
	<20061217145714.GA2987@melchior.yamamaya.is-a-geek.org>
Date: Mon, 18 Dec 2006 06:14:28 -0700
In-Reply-To: <20061217145714.GA2987@melchior.yamamaya.is-a-geek.org> (Tobias
	Diedrich's message of "Sun, 17 Dec 2006 15:57:14 +0100")
Message-ID: <m1bqm1s5vv.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tobias Diedrich <ranma@tdiedrich.de> writes:

> Linus Torvalds wrote:
>
>> Your dmesg is kind of interesting:
>> 
>> ..TIMER: trying IO-APIC=0 PIN=0 with 8259 IRQ0 enabled(7)APIC error on CPU0:
> 04(40)
>>  .. failed
>> 
>> where that APIC error on CPU0 seems to be a "Send accept error" and "Send 
>> illegal vector" thing. I think we actually got the interrupt there, but 
>> because we had some APIC setup bug, we didn't accept it properly, and it 
>> resulted in that "APIC error" thing. Maybe. 
>
> I just tried changing the code so the "8259 IRQ0 enabled" case is
> tested first and with that it boots fine.

Could you try removing the clear_IO_APIC_pin from try_io_apic_pin.

This isn't a complete fix but I believe for your hardware it will
fix the problem and it points at what the real fix is.  

Not properly programming the io_apic for the case we want to test.

Eric

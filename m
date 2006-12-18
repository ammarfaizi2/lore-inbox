Return-Path: <linux-kernel-owner+w=401wt.eu-S1754041AbWLRPoP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754041AbWLRPoP (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 10:44:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754096AbWLRPoP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 10:44:15 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:57039 "EHLO
	ebiederm.dsl.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754041AbWLRPoO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 10:44:14 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Tobias Diedrich <ranma+kernel@tdiedrich.de>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Yinghai Lu <yinghai.lu@amd.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: IO-APIC + timer doesn't work
References: <Pine.LNX.4.64.0612131744290.5718@woody.osdl.org>
	<20061216174536.GA2753@melchior.yamamaya.is-a-geek.org>
	<Pine.LNX.4.64.0612160955370.3557@woody.osdl.org>
	<20061216225338.GA2616@melchior.yamamaya.is-a-geek.org>
	<20061216230605.GA2789@melchior.yamamaya.is-a-geek.org>
	<Pine.LNX.4.64.0612161518080.3479@woody.osdl.org>
	<20061217145714.GA2987@melchior.yamamaya.is-a-geek.org>
	<m1bqm1s5vv.fsf@ebiederm.dsl.xmission.com>
	<20061218152333.GA2400@melchior.yamamaya.is-a-geek.org>
Date: Mon, 18 Dec 2006 08:43:36 -0700
In-Reply-To: <20061218152333.GA2400@melchior.yamamaya.is-a-geek.org> (Tobias
	Diedrich's message of "Mon, 18 Dec 2006 16:23:34 +0100")
Message-ID: <m1tzztqkev.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tobias Diedrich <ranma+kernel@tdiedrich.de> writes:
> Eric W. Biederman wrote:
>> Could you try removing the clear_IO_APIC_pin from try_io_apic_pin.
>> 
>> This isn't a complete fix but I believe for your hardware it will
>> fix the problem and it points at what the real fix is.  
>> 
>> Not properly programming the io_apic for the case we want to test.
>
> Yes, this works:

Thanks.  The bug is simply that the new code doesn't setup the
ioapic for the cases it intends to test.  But it does clear out
the original programming.  So if the normal good case doesn't work the
code is going to have problems.


> I can also report, that updating the BIOS to version 0609 (released
> last week or so, also adds the long-missing HPET support) also makes
> the problem go away since the first testcase then already works.
> I'm currently running with the BIOS downgraded to version 0402.

Nice to hear, so this is clearly a software setup problem in the BIOS.

Andi do you think you could address this problem?

Eric

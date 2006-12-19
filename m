Return-Path: <linux-kernel-owner+w=401wt.eu-S932791AbWLSL2a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932791AbWLSL2a (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 06:28:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932761AbWLSL2a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 06:28:30 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:50380 "EHLO
	ebiederm.dsl.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932779AbWLSL23 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 06:28:29 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: "Yinghai Lu" <yinghai.lu@amd.com>
Cc: "Tobias Diedrich" <ranma+kernel@tdiedrich.de>,
       "Linus Torvalds" <torvalds@osdl.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Andi Kleen" <ak@suse.de>, "Andrew Morton" <akpm@osdl.org>
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
	<m1tzztqkev.fsf@ebiederm.dsl.xmission.com>
	<86802c440612190000k7eb5e68et9c0a776ef85b5177@mail.gmail.com>
Date: Tue, 19 Dec 2006 04:27:24 -0700
In-Reply-To: <86802c440612190000k7eb5e68et9c0a776ef85b5177@mail.gmail.com>
	(Yinghai Lu's message of "Tue, 19 Dec 2006 00:00:27 -0800")
Message-ID: <m1ac1kqg6b.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Yinghai Lu" <yinghai.lu@amd.com> writes:

> On 12/18/06, Eric W. Biederman <ebiederm@xmission.com> wrote:
>> Thanks.  The bug is simply that the new code doesn't setup the
>> ioapic for the cases it intends to test.  But it does clear out
>> the original programming.  So if the normal good case doesn't work the
>> code is going to have problems.
>
> Please check the patch.

Getting there but I don't think we are quite there yet.

One of the issues that this does not address is that currently our probe
order in check_timer is wrong.  We should first check what the BIOS
has told us about.  And only if that fails should we start guessing,
common configurations.

So the pin2 case should be tested right after the pin1 case as we do
currently.  On most new boards that will be a complete noop.

But it is better than our current blind guess at using ExtINT mode.

I figure after we try what the BIOS has told us about and that
has failed we should first try the common irq 0 apic mappings,
and then try the common ExtINT mappings.

The current code causes me to want to scream, it is so silly.

Eric

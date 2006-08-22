Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751111AbWHVJ00@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751111AbWHVJ00 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 05:26:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751209AbWHVJ0Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 05:26:25 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:21658 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751111AbWHVJ0Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 05:26:25 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: "Magnus Damm" <magnus.damm@gmail.com>
Cc: "Andi Kleen" <ak@suse.de>, "Magnus Damm" <magnus@valinux.co.jp>,
       fastboot@lists.osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] [PATCH] x86_64: Reload CS when startup_64 is used.
References: <20060821095328.3132.40575.sendpatchset@cherry.local>
	<1156208306.21411.85.camel@localhost>
	<m1u045sagu.fsf@ebiederm.dsl.xmission.com>
	<200608221003.12608.ak@suse.de>
	<m1y7thqi7b.fsf_-_@ebiederm.dsl.xmission.com>
	<aec7e5c30608220153h4553d890v3a3740e7fdc6986@mail.gmail.com>
Date: Tue, 22 Aug 2006 03:25:55 -0600
In-Reply-To: <aec7e5c30608220153h4553d890v3a3740e7fdc6986@mail.gmail.com>
	(Magnus Damm's message of "Tue, 22 Aug 2006 17:53:26 +0900")
Message-ID: <m1lkphqfz0.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Magnus Damm" <magnus.damm@gmail.com> writes:

> Hi Eric,
>
> On 8/22/06, Eric W. Biederman <ebiederm@xmission.com> wrote:
>>
>> In long mode the %cs is largely a relic.  However there are a few cases
>> like lret where it matters that we have a valid value.  Without this
>> patch it is possible to enter the kernel in startup_64 without setting
>> %cs to a valid value.  With this patch we don't care what %cs value
>> we enter the kernel with, so long as the cs shadow register indicates
>> it is a privileged code segment.
>>
>> Thanks to Magnus Damm for finding this problem and posting the
>> first workable patch.  I have moved the jump to set %cs down a
>> few instructions so we don't need to take an extra jump.  Which
>> keeps the code simpler.
>>
>> Signed-of-by: Eric W. Biederman <ebiederm@xmission.com>
>
> While at it, could you please fix up the purgatory code in kexec-tools
> to include this fix so we can boot older versions of the kernel too?

I guess I'm not opposed to a patch but I have some serious reservations
about a solution that limits my address to 32bits in 64bit mode, and
appears to break the gdt used for entering the 32bit kernel.

I'm up way to late tonight.  I just wanted to resolve the situation
when it was clear what was going on.

Eric

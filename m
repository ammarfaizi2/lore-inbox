Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750779AbWDDRwG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750779AbWDDRwG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 13:52:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750777AbWDDRwF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 13:52:05 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:57742 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750779AbWDDRwC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 13:52:02 -0400
To: Zachary Amsden <zach@vmware.com>
Cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, rdunlap@xenotime.net, fastboot@osdl.org
Subject: Re: 2.6.17-rc1-mm1: KEXEC became SMP-only
References: <20060404014504.564bf45a.akpm@osdl.org>
	<20060404162921.GK6529@stusta.de> <4432AB57.1040006@vmware.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 04 Apr 2006 11:50:49 -0600
In-Reply-To: <4432AB57.1040006@vmware.com> (Zachary Amsden's message of
 "Tue, 04 Apr 2006 10:22:31 -0700")
Message-ID: <m1vetp44cm.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zachary Amsden <zach@vmware.com> writes:

> Adrian Bunk wrote:
>> On Tue, Apr 04, 2006 at 01:45:04AM -0700, Andrew Morton wrote:
>>
>>> ...
>>> Changes since 2.6.16-mm2:
>>> ...
>>> +x86-clean-up-subarch-definitions.patch
>>> ...
>>>  x86 updates.
>>> ...
>>>
>>
>> The following looks bogus:
>>
>>  config KEXEC
>>         bool "kexec system call (EXPERIMENTAL)"
>> -       depends on EXPERIMENTAL
>> +       depends on EXPERIMENTAL && (!X86_VOYAGER && SMP)
>>
>> The dependencies do now say that KEXEC is only offered for machines that are
>> _both_ non-Voyager and SMP.
>>
>> Is the problem you wanted to express that a non-SMP Voyager config didn't
>> compile?
>>
>
> Whoops, that should be
>
> depends on EXPERIMENTAL && !(X86_VOYAGER && SMP)
>
> Voyager SMP builds don't compile with kexec(), and it isn't clear how to
> shootdown CPUs using NMIs without an APIC.

Well unless you need the crash dump functionality you don't need to
shot down CPUs using NMIs.

So I expect machine_crash_shutdown or at least a part of it
should be a call into the subarchitecture code.  Having
it be a noop on voyager would be perfectly fine.  


Eric

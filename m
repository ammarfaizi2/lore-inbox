Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751167AbVJNENg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751167AbVJNENg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Oct 2005 00:13:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751166AbVJNENg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Oct 2005 00:13:36 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:49073 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751167AbVJNENf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Oct 2005 00:13:35 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, fastboot@osdl.org, Andi Kleen <ak@suse.de>
Subject: Re: i386 nmi_watchdog: Merge check_nmi_watchdog fixes from x86_64
References: <m1k6gt8gvt.fsf@ebiederm.dsl.xmission.com>
	<20051011182600.4a5ce224.akpm@osdl.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 13 Oct 2005 22:13:12 -0600
In-Reply-To: <20051011182600.4a5ce224.akpm@osdl.org> (Andrew Morton's
 message of "Tue, 11 Oct 2005 18:26:00 -0700")
Message-ID: <m1r7aoohwn.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> ebiederm@xmission.com (Eric W. Biederman) wrote:
>>
>> 
>> The per cpu nmi watchdog timer is based on an event counter.  
>> idle cpus don't generate events so the NMI watchdog doesn't fire
>> and the test to see if the watchdog is working fails.
>> 
>> - Add nmi_cpu_busy so idle cpus don't mess up the test.
>> - kmalloc prev_nmi_count to keep kernel stack usage bounded.
>> - Improve the error message on failure so there is enough
>>   information to debug problems.
>> 
>> ...
>>
>>  static int __init check_nmi_watchdog(void)
>>  {
>> -	unsigned int prev_nmi_count[NR_CPUS];
>> +	volatile int endflag = 0;
>
> I don't think this needs to be declared volatile?


Sorry for not replying sooner I just got back from a trip.

I haven't though it through extremely closely but I believe
the stores into that variable in check_nmi_watchdog could 
legitimately be optimized away by the compiler if it doesn't
have a hint.  As the variable is auto and is never used
after the store without volatile it seems a reasonable
assumption that no one else will see the value.

If the variable was static the volatile would clearly be unnecessary
as we have taken the address earlier so at some point the compiler
would be obligated to but with the variable being auto the rules are a
little murky.

Eric

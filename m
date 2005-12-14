Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751120AbVLNROk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751120AbVLNROk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 12:14:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751261AbVLNROk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 12:14:40 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:9145 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751120AbVLNROj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 12:14:39 -0500
To: Pavel Machek <pavel@suse.cz>
Cc: Andrew Morton <akpm@osdl.org>, Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Raj, Ashok" <ashok.raj@intel.com>, Andi Kleen <ak@suse.de>,
       Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Don't attempt to power off if power off is not
 implemented.
References: <Pine.LNX.4.61.0511270836120.20046@montezuma.fsmlabs.com>
	<m1psolfqvt.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.64.0512021221210.13220@montezuma.fsmlabs.com>
	<m1iru7dlww.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.64.0512050014000.6637@montezuma.fsmlabs.com>
	<m1zmncb0n5.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.64.0512072158500.2557@montezuma.fsmlabs.com>
	<m1vey0azeu.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.64.0512072249000.2557@montezuma.fsmlabs.com>
	<m1k6egavgq.fsf_-_@ebiederm.dsl.xmission.com>
	<19700102031329.GA2372@ucw.cz>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 14 Dec 2005 10:12:41 -0700
In-Reply-To: <19700102031329.GA2372@ucw.cz> (Pavel Machek's message of "Fri,
 2 Jan 1970 03:13:29 +0000")
Message-ID: <m164pra9h2.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@suse.cz> writes:

> Hi!
>
>> diff --git a/kernel/sys.c b/kernel/sys.c
>> index bce933e..bf5842f 100644
>> --- a/kernel/sys.c
>> +++ b/kernel/sys.c
>> @@ -488,6 +488,12 @@ asmlinkage long sys_reboot(int magic1, i
>>  	                magic2 != LINUX_REBOOT_MAGIC2C))
>>  		return -EINVAL;
>>  
>> +	/* Instead of trying to make the power_off code look like
>> +	 * halt when pm_power_off is not set do it the easy way.
>> +	 */
>> +	if ((cmd == LINUX_REBOOT_CMD_POWER_OFF) && !pm_power_off)
>> +		cmd = LINUX_REBOOT_CMD_HALT;
>> +
>>  	lock_kernel();
>>  	switch (cmd) {
>>  	case LINUX_REBOOT_CMD_RESTART:
>
> Would not it be better to return -EPERM here or something like that?
> That way userspace can decide that it really wants reboot or something
> else.

Because that would change the current semantics of what
LINUX_REBOOT_CMD_POWER_OFF.

It is painful enough getting the infrastructure change through without
the having to worry about breaking userspace as well.

Despite what it may look like this is purely to fix bugs in the
implementation.

If I was going to hack user space the quick fix is to remove the -p
flag passed to /sbin/halt in the reboot scripts.

Eric

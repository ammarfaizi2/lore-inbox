Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030227AbVLMVMz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030227AbVLMVMz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 16:12:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030232AbVLMVMz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 16:12:55 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:61201 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1030227AbVLMVMz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 16:12:55 -0500
Date: Fri, 2 Jan 1970 03:13:29 +0000
From: Pavel Machek <pavel@suse.cz>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>, Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Raj, Ashok" <ashok.raj@intel.com>, Andi Kleen <ak@suse.de>,
       Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Don't attempt to power off if power off is not implemented.
Message-ID: <19700102031329.GA2372@ucw.cz>
References: <Pine.LNX.4.61.0511270836120.20046@montezuma.fsmlabs.com> <m1psolfqvt.fsf@ebiederm.dsl.xmission.com> <Pine.LNX.4.64.0512021221210.13220@montezuma.fsmlabs.com> <m1iru7dlww.fsf@ebiederm.dsl.xmission.com> <Pine.LNX.4.64.0512050014000.6637@montezuma.fsmlabs.com> <m1zmncb0n5.fsf@ebiederm.dsl.xmission.com> <Pine.LNX.4.64.0512072158500.2557@montezuma.fsmlabs.com> <m1vey0azeu.fsf@ebiederm.dsl.xmission.com> <Pine.LNX.4.64.0512072249000.2557@montezuma.fsmlabs.com> <m1k6egavgq.fsf_-_@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1k6egavgq.fsf_-_@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> diff --git a/kernel/sys.c b/kernel/sys.c
> index bce933e..bf5842f 100644
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -488,6 +488,12 @@ asmlinkage long sys_reboot(int magic1, i
>  	                magic2 != LINUX_REBOOT_MAGIC2C))
>  		return -EINVAL;
>  
> +	/* Instead of trying to make the power_off code look like
> +	 * halt when pm_power_off is not set do it the easy way.
> +	 */
> +	if ((cmd == LINUX_REBOOT_CMD_POWER_OFF) && !pm_power_off)
> +		cmd = LINUX_REBOOT_CMD_HALT;
> +
>  	lock_kernel();
>  	switch (cmd) {
>  	case LINUX_REBOOT_CMD_RESTART:

Would not it be better to return -EPERM here or something like that?
That way userspace can decide that it really wants reboot or something
else.

								Pavel
-- 
Thanks, Sharp!

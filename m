Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261554AbVCCMqr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261554AbVCCMqr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 07:46:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261558AbVCCMqb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 07:46:31 -0500
Received: from smtp.nextra.cz ([195.70.130.2]:28687 "EHLO smtp.nextra.cz")
	by vger.kernel.org with ESMTP id S261554AbVCCMi0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 07:38:26 -0500
Message-ID: <4227053F.9050305@kmlinux.fjfi.cvut.cz>
Date: Thu, 03 Mar 2005 13:38:23 +0100
From: Jindrich Makovicka <makovick@kmlinux.fjfi.cvut.cz>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
Newsgroups: gmane.linux.kernel
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc4-mm1: something is wrong with swsusp powerdown
References: <20050228231721.GA1326@elf.ucw.cz>	<d05g45$pos$1@sea.gmane.org> <20050302163008.322031d3.akpm@osdl.org>
In-Reply-To: <20050302163008.322031d3.akpm@osdl.org>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> (Please do reply-to-all)
> 
> Jindrich Makovicka <makovick@kmlinux.fjfi.cvut.cz> wrote:
> 
>>Pavel Machek wrote:
>>
>>>Hi!
>>>
>>>In `subj` kernel, machine no longer powers down at the end of
>>>swsusp. 2.6.11-rc5-pavel works ok, as does 2.6.11-bk.
>>
>>For me, power down stopped working since the introduction of softlockup 
>>detection. After disabling CONFIG_DETECT_SOFTLOCKUP, powerdown works fine.
> 
> 
> Could you send the output which CONFIG_DETECT_SOFTLOCKUP generates?
> 
> I had one CONFIG_DETECT_SOFTLOCKUP failure with suspend, on SMP.  The
> machine was stuck somewhere under mce_work_fn().  Perhaps in the
> smp_call_function().  It only happened the once.

Strange enough, softlockup produces no additional output. Kernel just 
prints "acpi_power_off called" and freezes. Without softlockup detection 
compiled in it turns off normally.

First I was under impression that this is caused by 
acpi_power_off-bug-fix.patch mentioned above, but unfortunately removing 
it didn't actually solve the problem. Later I found I missed that 
softlockup detection sneaked in turned on by default, and disabling it 
made power off work again.

Power down via APM produced some softlockup output, but I am not sure if 
APM actually worked on my machine before - I just tried APM if it works 
when ACPI doesn't, and didn't bother taking a snapshot. I can recompile 
an APM kernel with softlockup enabled and disabled and test it, if it 
could help.

-- 
Jindrich Makovicka

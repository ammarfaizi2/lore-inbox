Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261495AbVFCSb2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261495AbVFCSb2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 14:31:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261496AbVFCSb2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 14:31:28 -0400
Received: from quark.didntduck.org ([69.55.226.66]:58333 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP id S261495AbVFCSbB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 14:31:01 -0400
Message-ID: <42A0A214.6070307@didntduck.org>
Date: Fri, 03 Jun 2005 14:31:48 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: davej@codemonkey.org.uk, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix warning in powernow-k8.c
References: <429F3A9E.504@didntduck.org> <20050603161132.GB5083@elf.ucw.cz>
In-Reply-To: <20050603161132.GB5083@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Hi!
> 
> 
>>Fix this warning:
>>powernow-k8.c: In function ?query_current_values_with_pending_wait?:
>>powernow-k8.c:110: warning: ?hi? may be used uninitialized in this
>>function
> 
> 
> Are you sure?
> 
> Original code is clearly buggy; I do not think you need that ugly do
> {} while loop.

I'm not sure why you think the loop is ugly.  It makes it more obvious 
(to us humans and the compiler) that the loop is executed at least one time.

> 
> 								Pavel
> 
>>Signed-off-by: Brian Gerst <bgerst@didntduck.org>
> 
> 
>>diff --git a/arch/i386/kernel/cpu/cpufreq/powernow-k8.c b/arch/i386/kernel/cpu/cpufreq/powernow-k8.c
>>--- a/arch/i386/kernel/cpu/cpufreq/powernow-k8.c
>>+++ b/arch/i386/kernel/cpu/cpufreq/powernow-k8.c
>>@@ -110,14 +110,13 @@ static int query_current_values_with_pen
>> 	u32 lo, hi;
>> 	u32 i = 0;
>> 
>>-	lo = MSR_S_LO_CHANGE_PENDING;
>>-	while (lo & MSR_S_LO_CHANGE_PENDING) {
>>+	do {
>> 		if (i++ > 0x1000000) {
>> 			printk(KERN_ERR PFX "detected change pending stuck\n");
>> 			return 1;
>> 		}
>> 		rdmsr(MSR_FIDVID_STATUS, lo, hi);
>>-	}
>>+	} while (lo & MSR_S_LO_CHANGE_PENDING);
>> 
>> 	data->currvid = hi & MSR_S_HI_CURRENT_VID;
>> 	data->currfid = lo & MSR_S_LO_CURRENT_FID;
> 
> 
> 


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261658AbVCRP5y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261658AbVCRP5y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 10:57:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261662AbVCRP5y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 10:57:54 -0500
Received: from everest.2mbit.com ([24.123.221.2]:29333 "EHLO mail.sosdg.org")
	by vger.kernel.org with ESMTP id S261658AbVCRP52 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 10:57:28 -0500
Message-ID: <423AFA35.8000401@lovecn.org>
Date: Fri, 18 Mar 2005 23:56:37 +0800
From: Coywolf Qi Hunt <coywolf@lovecn.org>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: coywolf@gmail.com, "Rafael J. Wysocki" <rjw@sisk.pl>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
References: <20050316202800.GA22750@everest.sosdg.org> <20050318113957.GC32253@elf.ucw.cz>
In-Reply-To: <20050318113957.GC32253@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Broken-Reverse-DNS: no host name for for IP address 218.24.168.26
X-Scan-Signature: e39eceae6eb4554774934c39b07fdc9c
X-SA-Exim-Connect-IP: 218.24.168.26
X-SA-Exim-Mail-From: coywolf@lovecn.org
Subject: Re: [patch] SUSPEND_PD_PAGES-fix
X-Spam-Report: * -4.9 BAYES_00 BODY: Bayesian spam probability is 0 to 1%
	*      [score: 0.0000]
	*  4.0 RCVD_IN_AHBL_CNKR RBL: AHBL: sender is listed in the AHBL China/Korea blocks
	*      [218.24.168.26 listed in cnkrbl.ahbl.org]
X-SA-Exim-Version: 4.2 (built Sun, 13 Feb 2005 18:23:43 -0500)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Hi!
> 
> 
> 
>>This fixes SUSPEND_PD_PAGES, which wastes one page under most cases.

-This fixes SUSPEND_PD_PAGES, which wastes one page under most cases.
+This fixes SUSPEND_PD_PAGES, which, in rare instances, would waste a signle page.


I see rafael is going to drop it. Anyway, my description was wrong.

	Coywolf

> 
> 
> Ok, applied to my tree, will eventually propagate it. (I hope it looks
> okay to you, rafael).
> 
> 
>>Signed-off-by: Coywolf Qi Hunt <coywolf@gmail.com>
>>diff -pruN 2.6.11-mm4/include/linux/suspend.h 2.6.11-mm4-cy/include/linux/suspend.h
>>--- 2.6.11-mm4/include/linux/suspend.h	2005-03-17 01:22:16.000000000 +0800
>>+++ 2.6.11-mm4-cy/include/linux/suspend.h	2005-03-17 04:14:16.000000000 +0800
>>@@ -34,7 +34,7 @@ typedef struct pbe {
>> #define SWAP_FILENAME_MAXLENGTH	32
>> 
>> 
>>-#define SUSPEND_PD_PAGES(x)     (((x)*sizeof(struct pbe))/PAGE_SIZE+1)
>>+#define SUSPEND_PD_PAGES(x)     (((x)*sizeof(struct pbe)+PAGE_SIZE-1)/PAGE_SIZE)
>> 
>> extern dev_t swsusp_resume_device;
>>    
> 
> 


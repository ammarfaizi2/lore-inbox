Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262368AbVC3SB1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262368AbVC3SB1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 13:01:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262369AbVC3SB1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 13:01:27 -0500
Received: from fire.osdl.org ([65.172.181.4]:40333 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262368AbVC3SBX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 13:01:23 -0500
Message-ID: <424AE960.8020906@osdl.org>
Date: Wed, 30 Mar 2005 10:01:04 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Yum Rayan <yum.rayan@gmail.com>
CC: linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
Subject: Re: [PATCH] Reduce stack usage in module.c
References: <df35dfeb05032823137a208b46@mail.gmail.com>	 <424993B0.9010306@osdl.org> <df35dfeb050329222132823897@mail.gmail.com>
In-Reply-To: <df35dfeb050329222132823897@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yum Rayan wrote:
> On Tue, 29 Mar 2005 09:43:12 -0800, Randy.Dunlap <rddunlap@osdl.org> wrote:
> 
>>Yum Rayan wrote:
>>
>>>Attempt to reduce stack usage in module.c (linux-2.6.12-rc1-mm3).
>>>Specifically from checkstack.pl
> 
>>>Also while at it, fix following in who_is_doing_it(...)
>>>- use only as much memory is needed
>>>- do not write past array index for the boundary case
>>
>>I don't see a boundary case problem with the current code,
>>hence I don't see why the kmalloc(len + 1, GFP_KERNEL) is
>>needed...
> 
> 
> Let's consider the original code and len = 513
> 
>    1399 static void who_is_doing_it(void)
>    1400 {
>    1401         /* Print out all the args. */
>    1402         char args[512];
>    1403         unsigned long i, len = current->mm->arg_end -
> current->mm->arg_start;
>    1404
>    1405         if (len > 512)
>    1406                 len = 512;
>    1407
>    1408         len -= copy_from_user(args, (void
> *)current->mm->arg_start, len);
>    1409
>    1410         for (i = 0; i < len; i++) {
>    1411                 if (args[i] == '\0')
>    1412                         args[i] = ' ';
>    1413         }
>    1414         args[i] = 0;
>    1415         printk("ARGS: %s\n", args);
>    1416 }
> 
> After lines 1410 thru 1413, "i" wil be 512. So line 1414 will be
> "args[512] = 0". But args is 512 byte array with last legally
> accessible element at 511?

Yes, it's so obvious (now).  :)

>>File names start one level deeper than wanted.  They should begin
>>with linux/ or a/ or ./ e.g.
>>There are plenty of docs on this, please let me know if you need
>>references to them.
> 
> 
> Point noted. Will post patch to linux/Documentation/SubmittingPatches,
> hopefully making it more clear. Reworked patch at end of email.

Good idea, thanks.

-- 
~Randy

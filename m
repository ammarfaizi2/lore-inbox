Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965072AbVKGSEY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965072AbVKGSEY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 13:04:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965084AbVKGSEX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 13:04:23 -0500
Received: from nproxy.gmail.com ([64.233.182.194]:10052 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965072AbVKGSEX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 13:04:23 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:organization:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=MFN04JRQ9QLKvoT3as8OS7VcyoeicHEJ5mxpHDjDAzcxsh5F3cb5bIoIKNeCDyqJV0XHVtVKjC3gX6n5eKzu2ahGwbXOZ4sotUSWYK7rSYILeKQRZoJxGoAVWfJc9sITabbtskvco04yMnbNaTVXCrrppy73hHfYpsjorfw0p6w=
Message-ID: <436F9720.8070008@gmail.com>
Date: Mon, 07 Nov 2005 19:04:16 +0100
From: Patrizio Bassi <patrizio.bassi@gmail.com>
Reply-To: patrizio.bassi@gmail.com
Organization: patrizio.bassi@gmail.com
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051027)
X-Accept-Language: it, it-it, en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: kernel list <linux-kernel@vger.kernel.org>, shaohua.li@intel.com
Subject: Re: 2.6.14-git4 suspend fails: kernel NULL pointer dereference
References: <20051006072749.GA2393@spitz.ucw.cz> <20051107164715.GA1534@elf.ucw.cz>
In-Reply-To: <20051107164715.GA1534@elf.ucw.cz>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek ha scritto:

>Hi!
>
>  
>
>>echo shutdown > /sys/power/disk
>>echo disk > /sys/power/state
>>
>>Unable to handle kernel NULL pointer dereference at virtual address 00000004
>> printing eip:
>>EIP:    0060:[<c0132a5e>]    Not tainted VLI
>>EFLAGS: 00010286   (2.6.14-git4)
>>EIP is at enter_state+0xe/0x90
>>    
>>
>
>It works for me, with pretty recent tree. But I see a potential
>problem there, you are not using ACPI, right?
>
>I think it is caused by this commit:
>
>commit eb9289eb20df6b54214c45ac7c6bf5179a149026
>tree dac51cecdd94e0c7273c990259ddd800057311b9
>parent 0245b3e787dc3267a915e1f56419e7e9c197e148
>author Shaohua Li <shaohua.li@intel.com> Sun, 30 Oct 2005 15:00:01
>-0800
>committer Linus Torvalds <torvalds@g5.osdl.org> Sun, 30 Oct 2005
>17:37:15 -0800
>
>    [PATCH] introduce .valid callback for pm_ops
>
>    Add pm_ops.valid callback, so only the available pm states show in
>    /sys/power/state.  And this also makes an earlier states error
>report at
>    enter_state before we do actual suspend/resume.
>
>Try this patch.
>
>							Pavel
>
>diff --git a/kernel/power/main.c b/kernel/power/main.c
>--- a/kernel/power/main.c
>+++ b/kernel/power/main.c
>@@ -167,7 +167,7 @@ static int enter_state(suspend_state_t s
> {
> 	int error;
> 
>-	if (pm_ops->valid && !pm_ops->valid(state))
>+	if (pm_ops && pm_ops->valid && !pm_ops->valid(state))
> 		return -ENODEV;
> 	if (down_trylock(&pm_sem))
> 		return -EBUSY;
>
>
>  
>


i'm using ACPI.
i'òll try the patch and report asap.

Patrizio

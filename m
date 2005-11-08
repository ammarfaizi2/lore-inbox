Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965127AbVKHHu1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965127AbVKHHu1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 02:50:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965133AbVKHHu1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 02:50:27 -0500
Received: from nproxy.gmail.com ([64.233.182.199]:8171 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965127AbVKHHuZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 02:50:25 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:organization:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=CbzMuciSpBTqnpJGToCkz9gzCKdJxecyMrKY18UJN/mFchSIvclanSyeySSQaf7YON82PQ9Y5xBRWXAG85oVAZRZYUmXi5fpMO1Tz4io7Hg7TCfRJ+CREmLig4zBrCAOCsunD7nolRsiKMd0F8bTyBAHffOxElb4290FWkpJ7JA=
Message-ID: <437058BC.7090300@gmail.com>
Date: Tue, 08 Nov 2005 08:50:20 +0100
From: Patrizio Bassi <patrizio.bassi@gmail.com>
Reply-To: patrizio.bassi@gmail.com
Organization: patrizio.bassi@gmail.com
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051027)
X-Accept-Language: it, it-it, en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: kernel list <linux-kernel@vger.kernel.org>, shaohua.li@intel.com
Subject: Re: 2.6.14-git4 suspend fails: kernel NULL pointer dereference
References: <20051006072749.GA2393@spitz.ucw.cz> <20051107164715.GA1534@elf.ucw.cz> <436F9720.8070008@gmail.com> <20051107180710.GD1710@elf.ucw.cz>
In-Reply-To: <20051107180710.GD1710@elf.ucw.cz>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek ha scritto:

>Hi!
>
>  
>
>>>diff --git a/kernel/power/main.c b/kernel/power/main.c
>>>--- a/kernel/power/main.c
>>>+++ b/kernel/power/main.c
>>>@@ -167,7 +167,7 @@ static int enter_state(suspend_state_t s
>>>{
>>>	int error;
>>>
>>>-	if (pm_ops->valid && !pm_ops->valid(state))
>>>+	if (pm_ops && pm_ops->valid && !pm_ops->valid(state))
>>>		return -ENODEV;
>>>	if (down_trylock(&pm_sem))
>>>		return -EBUSY;
>>>
>>>
>>> 
>>>
>>>      
>>>
>>i'm using ACPI.
>>i'?ll try the patch and report asap.
>>    
>>
>
>ok, not sure what is going on, then. Fill enter_state() with printks()
>so that we know where it fails... then kill klogd before attempting
>suspend.
>								Pavel
>  
>
that **seems** to be fixed, even if i run ACPI.

now i have

Stopping tasks:
===============================================================|
Freeing memory... done (42120 pages freed)
usbfs 2-2:1.0: no suspend?
Could not suspend device 2-2: error -16
Some devices failed to suspend
Restarting tasks... done

this was fixed by a patch Len Brown gave me privatly.
it's due to a pci-usb card.
it seems has not been applied yet.
can you notify him? he knows :)

good job.

Patrizio

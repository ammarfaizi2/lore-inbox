Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263770AbUIZVBI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263770AbUIZVBI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Sep 2004 17:01:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263778AbUIZVBI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Sep 2004 17:01:08 -0400
Received: from cantor.suse.de ([195.135.220.2]:27316 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263770AbUIZVBD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Sep 2004 17:01:03 -0400
Message-ID: <41572E05.9030406@suse.de>
Date: Sun, 26 Sep 2004 23:00:53 +0200
From: Stefan Seyfried <seife@suse.de>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Pavel Machek <pavel@suse.cz>
Subject: Re: 2.6.9-rc2-mm3: swsusp horribly slow on AMD64
References: <200409251214.28743.rjw@sisk.pl> <200409261208.02209.rjw@sisk.pl> <20040926100955.GI10435@elf.ucw.cz> <200409261337.53298.rjw@sisk.pl>
In-Reply-To: <200409261337.53298.rjw@sisk.pl>
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rafael J. Wysocki wrote:
> On Sunday 26 of September 2004 12:09, Pavel Machek wrote:

>>>>We have seen something similar after hdparm was used on specific
>>>>machines. Are you using hdparm?

Pavel, i am pretty sure the issue with hdparm and 32-bit disk access was
just a symptom, not the cause. Rafael, please try the patch i posted in
the other mail, i believe this is the right thing to do.

>>>Not explicitly, but it's used by SuSE initscripts to set IDE DMA, AFAICS.  
>>>However, the problem did not occur on 2.6.9-rc2-mm1 with the same 
>>>initscripts.
>>
>>Okay, so try what happens without the initscripts
> 
> I turned the stuff off but of course it didn't change anything. :-)

That's what i expected.

>>and try to locate change that breaks it...

> Well, I'm a bit confused:
> 
> --- linux-2.6.9-rc2-mm1/kernel/power/swsusp.c   2004-09-16 14:06:56.000000000 
> +0200
> +++ linux-2.6.9-rc2-mm3/kernel/power/swsusp.c   2004-09-24 11:35:18.000000000 
> +0200
> @@ -862,8 +862,8 @@
>         error = swsusp_arch_suspend();
>         /* Restore control flow magically appears here */
>         restore_processor_state();
> -       local_irq_enable();
>         restore_highmem();
> +       local_irq_enable();
>         return error;
>  }

without this one is needed or highmem will break "sometimes". Was really
nasty. You did have highmem-resume problems, didn't you?

    Stefan

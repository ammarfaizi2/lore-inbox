Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261318AbVCOP2D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261318AbVCOP2D (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 10:28:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261321AbVCOP2D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 10:28:03 -0500
Received: from sccrmhc14.comcast.net ([204.127.202.59]:10907 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261318AbVCOP14 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 10:27:56 -0500
Date: Tue, 15 Mar 2005 10:27:56 -0500
From: Jason Davis <jason@rightthere.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, natalie.protasevich@unisys.com,
       jason.davis@unisys.com
Subject: Re: [PATCH] ES7000 Legacy Mappings Update
Message-ID: <20050315152756.GA28799@righTThere.net>
References: <20050314183533.GA28889@righTThere.net> <20050314180554.10455185.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20050314180554.10455185.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

See below.

On Mon, 14 Mar 2005, Andrew Morton wrote:
>
>You triggered my trivia twitch.
>
>Jason Davis <jason@rightthere.net> wrote:
>>
>>  -	 * ES7000 has no legacy identity mappings
>>  +	 * Older generations of ES7000 have no legacy identity mappings
>>   	 */
>>  -	if (es7000_plat)
>>  +	if (es7000_plat && es7000_plat < 2) 
>>   		return;
>
>Why not
>
>	if (es7000_plat == 1)
>
>?
>

Looks like I never learned to apply the concept of reducing fractions :). Thanks for catching this.

>>   	/* 
>>  diff -Naurp linux-2.6.11.3/arch/i386/mach-es7000/es7000plat.c linux-2.6.11.3-legacy/arch/i386/mach-es7000/es7000plat.c
>>  --- linux-2.6.11.3/arch/i386/mach-es7000/es7000plat.c	2005-03-13 01:44:41.000000000 -0500
>>  +++ linux-2.6.11.3-legacy/arch/i386/mach-es7000/es7000plat.c	2005-03-14 11:52:44.000000000 -0500
>>  @@ -138,7 +138,14 @@ parse_unisys_oem (char *oemptr, int oem_
>>   		es7000_plat = 0;
>>   	} else {
>>   		printk("\nEnabling ES7000 specific features...\n");
>>  -		es7000_plat = 1;
>>  +		/*
>>  +		 * Check to see if this is a x86_64 ES7000 machine.
>>  +		 */
>>  +		if (!(boot_cpu_data.x86 <= 15 && boot_cpu_data.x86_model <= 2))
>>  +			es7000_plat = 2;
>>  +		else
>>  +			es7000_plat = 1;
>>  +
>
>Perhaps some nice enumerated identifiers here, rather than magic numbers?

Initially, I was going to take this approach but that would require some specific platform defines to be thrown into a global header file (mpparse.c would need to see them as well). I didn't think it would be appropriate to mix code like that. I'll be glad to revise the patch to include enumerated identifiers but would it be more acceptable to comment on the semantics of the es7000_plat var in the platform specific "es7000plat.c" file?

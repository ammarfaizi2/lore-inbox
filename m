Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261484AbUKFWUm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261484AbUKFWUm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 17:20:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261486AbUKFWUm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 17:20:42 -0500
Received: from orion.netbank.com.br ([200.203.199.90]:11531 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id S261484AbUKFWUf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 17:20:35 -0500
Message-ID: <418D403E.30608@conectiva.com.br>
Date: Sat, 06 Nov 2004 19:21:02 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Organization: Conectiva S.A.
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
Cc: Len Brown <len.brown@intel.com>,
       ACPI Developers <acpi-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/acpi: remove unused exported functions
References: <20041105215021.GF1295@stusta.de> <1099707007.13834.1969.camel@d845pe> <20041106114844.GK1295@stusta.de> <418CEE3A.40503@conectiva.com.br> <20041106212917.GP1295@stusta.de>
In-Reply-To: <20041106212917.GP1295@stusta.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> On Sat, Nov 06, 2004 at 01:31:06PM -0200, Arnaldo Carvalho de Melo wrote:
> 
>>Suggestion that satisfies both of you, I think:
>>
>>#undef ACPI_FUTURE_USAGE
>>#ifdef ACPI_FUTURE_USAGE
>>tons of unused exported functions
>>#endif /* ACPU_FUTURE_USAGE */
>>
>>This is what is being done in at least one case in the kernel network
>>subsystem, incremental patches adds new functions, to be used by
>>future patches, but sometimes Real Life (tm) gets in the way and the
>>programmer stalls development for some time, no problem, just ifdef it.
>>
>>When, in the future, some functions start being used, hey, very easy
>>to remove the #ifdef.
>>
>>Even for people trying to debug such subsystems eventually to get
>>something working its _nice_ to know at first glance what is really
>>being used, speeding up the process for the benefit or everybody.
> 
> 
> That's a good idea.
> 
> To make it easier, I could send a patc to move all the ACPI 
> EXPORT_SYMBOL's away from acpi_ksyms.c or you have to touch two files 
> for every function.


EXPORT_SYMBOL() should be right after the symbol definition, IMHO.

files that exists only to aggregate EXPORT_SYMBOL are a relic of the
past and must RIP, away from the kernel. I played the gravedigger
for net/netsyms.c and kernel/ksyms.c, I guess Len will not object
to you putting acpi_ksyms.c in so friendly company 8-)

- Arnaldo


> @Len:
> What's your opinion on this proposal?

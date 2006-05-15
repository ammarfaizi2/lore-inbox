Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965073AbWEOSJa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965073AbWEOSJa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 14:09:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965074AbWEOSJa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 14:09:30 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:2572 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S965073AbWEOSJ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 14:09:29 -0400
Message-ID: <4468C3B8.8090502@shadowen.org>
Date: Mon, 15 May 2006 19:08:56 +0100
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: [PATCH] x86 NUMA panic compile error
References: <20060515005637.00b54560.akpm@osdl.org>	<20060515140811.GA23750@shadowen.org>	<20060515175306.GA18185@elte.hu> <20060515110814.11c74d70.akpm@osdl.org>
In-Reply-To: <20060515110814.11c74d70.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Ingo Molnar <mingo@elte.hu> wrote:
> 
>>
>>* Andy Whitcroft <apw@shadowen.org> wrote:
>>
>>
>>> 	if (use_cyclone == 0) {
>>> 		/* Make sure user sees something */
>>>-		static const char s[] __initdata = "Not an IBM x440/NUMAQ. Don't use i386 CONFIG_NUMA anywhere else."
>>>+		static const char s[] __initdata = "Not an IBM x440/NUMAQ. Don't use i386 CONFIG_NUMA anywhere else.";
>>> 		early_printk(s);
>>> 		panic(s);
>>> 	}
>>
>>i still strongly oppose the original Andi hack... numerous reasons were 
>>given not to apply it (it's nice to simulate/trigger rarer features on 
>>mainstream hardware too, and this ability to boot NUMA on my flat x86 
>>testbox found at least one other NUMA bug already). Furthermore, the 
>>crash i reported was fixed by the NUMA patchset.
> 
> 
> I'll be darned.  I never knew it was even possible to run x86 numa kernels
> on non-numa boxen.  I'd have tested about 1000000 of Christoph Lameter's
> patches if someone had told me.  Yes, it's useful.
>

We always assumed it might be reasonable for a distro to want a single
installer kernel for all machines.  So having a combined numa not numa
capable kernel always seemed like a good idea.

>>Andrew, please drop:
>>
>>  x86_64-mm-i386-numa-summit-check.patch
> 
> 
> bang.
> 
> 
>>(which has nothing to do with x86_64 anyway)
> 
> 
> True.
> 
> I guess the concern here is that we don't want people building these
> frankenkernels and then sending us bug reports against them.
> 
> So it is perhaps reasonable to do this panic, but only if !CONFIG_EMBEDDED? 
> (It really is time to start renaming CONFIG_EMBEDDED to CONFIG_DONT_DO_THIS
> or something).

How about CONFIG_EXPERIMENTAL?

-apw

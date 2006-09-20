Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751874AbWITQpH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751874AbWITQpH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 12:45:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751557AbWITQpH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 12:45:07 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:49624 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751874AbWITQpB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 12:45:01 -0400
Message-ID: <45117047.60701@sgi.com>
Date: Wed, 20 Sep 2006 18:45:59 +0200
From: Jes Sorensen <jes@sgi.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060907)
MIME-Version: 1.0
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       bjorn_helgaas@hp.com, Nick Piggin <nickpiggin@yahoo.com.au>,
       Andrew Morton <akpm@osdl.org>, Robin Holt <holt@sgi.com>,
       Dean Nelson <dcn@sgi.com>, Hugh Dickins <hugh@veritas.com>
Subject: Re: [patch] mspec driver
References: <yq0psdrc81u.fsf@jaguar.mkp.net> <20060920085939.47b753d9.rdunlap@xenotime.net>
In-Reply-To: <20060920085939.47b753d9.rdunlap@xenotime.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:
> On 20 Sep 2006 03:26:53 -0400 Jes Sorensen wrote:
>> @@ -439,6 +439,14 @@ config SGI_MBCS
>>           If you have an SGI Altix with an attached SABrick
>>           say Y or M here, otherwise say N.
>>  
>> +config MSPEC
>> +	tristate "Memory special operations driver"
>> +	depends on IA64
>> +	help
>> +	  If you have an ia64 and you want to enable memory special
>> +	  operations support (formerly known as fetchop), say Y here,
>> +	  otherwise say N.
> 
> If the answers are {Y, N}, then it should be bool instead of tristate.
> If tristate, M can be an answer....

True, will look into that.

>> +#include <linux/config.h>
> 
> Don't need to include config.h (it's done by build system).
> (well, actually autoconf.h is)

True, I remember that changing - what happens when the code sits around
for too long. Personally I prefer it is included explicitly, but I'll
change it anyway.

>> +static struct vm_operations_struct mspec_vm_ops = {
>> +	.open = mspec_open,
>> +	.close = mspec_close,
>> +	.nopfn = mspec_nopfn
>> +};
> 
> These interfaces create a userspace interface, eh?
> So those 3 functions could stand to have kernel-doc function
> comments and have documentation in Documentation/ABI/ (see its
> README file for more details).  Maybe check all of
> Documentation/SubmitChecklist for other items...

Mmmmmmm, I'd need someone else to write that up, might take a little
longer to get done. Robin know any volunteers?

>> +/*
>> + * mspec_init
>> + *
>> + * Called at boot time to initialize the mspec facility.
>> + */
>> +static int __init
>> +mspec_init(void)
> 
> ugh, matey.  All on one line.

Sorry, but I think that one falls under personal preference. It's short
than 80, which is what really matters.

Cheers,
Jes

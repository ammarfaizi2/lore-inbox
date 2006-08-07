Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932130AbWHGQpU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932130AbWHGQpU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 12:45:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932123AbWHGQpU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 12:45:20 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:54999 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932130AbWHGQpT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 12:45:19 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86_64: Make NR_IRQS configurable in Kconfig
References: <m1irl4ftya.fsf@ebiederm.dsl.xmission.com>
	<20060807085924.72f832af.rdunlap@xenotime.net>
Date: Mon, 07 Aug 2006 10:44:00 -0600
In-Reply-To: <20060807085924.72f832af.rdunlap@xenotime.net> (Randy Dunlap's
	message of "Mon, 7 Aug 2006 08:59:24 -0700")
Message-ID: <m1irl4ebsf.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Randy.Dunlap" <rdunlap@xenotime.net> writes:

>> diff --git a/arch/x86_64/Kconfig b/arch/x86_64/Kconfig
>> index 7598d99..d744e5b 100644
>> --- a/arch/x86_64/Kconfig
>> +++ b/arch/x86_64/Kconfig
>> @@ -384,6 +384,19 @@ config NR_CPUS
>>  	  This is purely to save memory - each supported CPU requires
>>  	  memory in the static kernel configuration.
>>  
>> +config NR_IRQS
>> +	int "Maximum number of IRQs (224-4096)"
>> +	range 256 4096
>> +	depends on SMP
>> +	default "4096"
>> +	help
>> +	  This allows you to specify the maximum number of IRQs which this
>> +	  kernel will support. Current maximum is 4096 IRQs as that
>> +	  is slightly larger than has observed in the field.
>> +
>> +	  This is purely to save memory - each supported IRQ requires
>> +	  memory in the static kernel configuration.
>
> If (a) "nor does hardware typically provide that many irq sources"
> and (b) "This is purely to save memory", why is the default
> 4096 instead of something smaller?

a) Because I would like to flush out bugs.
b) Because I want a default that works for everyone.
c) Because with MSI we have a potential for large irq counts on most systems.
d) Because anyone who disagrees with me can send a patch and fix
   the default.
e) Because with the default number of cpus we can very close to needing
   this many irqs in the worst case.
f) This is much better than previous to my patch and setting NR_CPUS=255
   and getting 8K IRQS.
g) Because I probably should have been more inventive than copying the
   NR_IRQS text, but when I did the wording sounded ok to me.

Eric

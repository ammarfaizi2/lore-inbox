Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932303AbWF0MLh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932303AbWF0MLh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 08:11:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932342AbWF0MLh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 08:11:37 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:23825 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S932303AbWF0MLf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 08:11:35 -0400
Message-ID: <44A1204F.3070704@shadowen.org>
Date: Tue, 27 Jun 2006 13:10:55 +0100
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>
CC: Yasunori Goto <y-goto@jp.fujitsu.com>,
       Toralf Foerster <toralf.foerster@gmx.de>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: linux-2.6.17.1: undefined reference to `online_page'
References: <200606251704_MC3-1-C36D-5D33@compuserve.com>	 <20060626163235.A022.Y-GOTO@jp.fujitsu.com> <1151343992.10877.34.camel@localhost.localdomain>
In-Reply-To: <1151343992.10877.34.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen wrote:
> On Mon, 2006-06-26 at 16:39 +0900, Yasunori Goto wrote:
> 
>>===================================================================
>>--- linux-2.6.17.orig/mm/Kconfig        2006-06-26 14:19:11.000000000
>>+0900
>>+++ linux-2.6.17/mm/Kconfig     2006-06-26 14:19:53.000000000 +0900
>>@@ -115,7 +115,7 @@ config SPARSEMEM_EXTREME
>> # eventually, we can have this option just 'select SPARSEMEM'
>> config MEMORY_HOTPLUG
>>        bool "Allow for memory hot-add"
>>-       depends on SPARSEMEM && HOTPLUG && !SOFTWARE_SUSPEND
>>+       depends on SPARSEMEM && HOTPLUG && !SOFTWARE_SUSPEND
>>&& !(X86_32 && !HIGHMEM)
>> 
>> comment "Memory hotplug is currently incompatible with Software
>>Suspend"
>>        depends on SPARSEMEM && HOTPLUG && SOFTWARE_SUSPEND 
> 
> 
> I think it makes a lot more sense to just disable sparsemem when !
> HIGHMEM.  Plus, we can do all of that in the arch-specific Kconfigs and
> not litter the generic ones with this stuff.

SPARSEMEM cirtainly isn't going to offer you anything much with this
little memory.  If you were going to do this I'd say it makes more sense
to introduce an ARCH_DISABLE_MEMORY_HOTPLUG sort of thing and add that
in the x86 Kconfig.

-apw

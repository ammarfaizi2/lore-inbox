Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752584AbWKAX6V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752584AbWKAX6V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 18:58:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752585AbWKAX6V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 18:58:21 -0500
Received: from gw.goop.org ([64.81.55.164]:16006 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1752584AbWKAX6U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 18:58:20 -0500
Message-ID: <45493497.1040707@goop.org>
Date: Wed, 01 Nov 2006 15:58:15 -0800
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20061027)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Rusty Russell <rusty@rustcorp.com.au>, Chris Wright <chrisw@sous-sol.org>,
       Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org,
       virtualization@lists.osdl.org
Subject: Re: [PATCH 4/7] paravirtualization: Allow selected bug checks to
 be	skipped by paravirt kernels
References: <20061029024504.760769000@sous-sol.org>	<20061029024607.401333000@sous-sol.org>	<200610290831.21062.ak@suse.de>	<1162178936.9802.34.camel@localhost.localdomain>	<20061030231132.GA98768@muc.de>	<1162376827.23462.5.camel@localhost.localdomain>	<1162376894.23462.7.camel@localhost.localdomain>	<1162376981.23462.10.camel@localhost.localdomain>	<1162377043.23462.12.camel@localhost.localdomain> <20061101152946.14f95f79.akpm@osdl.org>
In-Reply-To: <20061101152946.14f95f79.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Wed, 01 Nov 2006 21:30:43 +1100
> Rusty Russell <rusty@rustcorp.com.au> wrote:
>
>   
>> --- a/include/asm-i386/bugs.h
>> +++ b/include/asm-i386/bugs.h
>> @@ -21,6 +21,7 @@
>>  #include <asm/processor.h>
>>  #include <asm/i387.h>
>>  #include <asm/msr.h>
>> +#include <asm/paravirt.h>
>>     
>
> In many other places you have
>
> #ifdef CONFIG_PARAVIRT
> #include <asm/paravirt.h>
> ...
>
> But not here.
>
> Making <asm/paravirt.h> invulnerable would be the more typical approach.
CONFIG_PARAVIRT is not being used to guard asm/paravirt.h from multiple 
inclusion.  In places where it is being used to guard #include 
<asm/paravirt.h>, the idea is that asm/paravirt.h defines various 
inlines/macros which would otherwise be defined in the header.  So, for 
example, asm/desc.h would normally define load_gdt() in the 
!CONFIG_PARAVIRT case, but asm/paravirt.h defines it when 
CONFIG_PARAVIRT is enabled. 

In this case, asm/paravirt.h included because we need the definition for 
paravirt_enabled(), not because it is replacing any of bugs.h's definitions.

    J

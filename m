Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264382AbTLKIUh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 03:20:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264395AbTLKIUh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 03:20:37 -0500
Received: from 216-239-45-4.google.com ([216.239.45.4]:44049 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id S264382AbTLKIUf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 03:20:35 -0500
Message-ID: <3FD828BE.7020906@google.com>
Date: Thu, 11 Dec 2003 00:20:14 -0800
From: Paul Menage <menage@google.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030701
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Yu, Luming" <luming.yu@intel.com>
CC: linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
Subject: Re: [ACPI] ACPI global lock macros
References: <3ACA40606221794F80A5670F0AF15F8401720C21@PDSMSX403.ccr.corp.intel.com>
In-Reply-To: <3ACA40606221794F80A5670F0AF15F8401720C21@PDSMSX403.ccr.corp.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yu, Luming wrote:
> 
> 
> Above code have a bug! Considering below code:
> 
> u8	acquired = FALSE;
> 
> ACPI_ACQUIRE_GLOBAL_LOC(acpi_gbl_common_fACS.global_lock, acquired);
> if(acquired) {
> ....
> }
> 
> Gcc will complain " ERROR: '%cl' not allowed with sbbl ". And I think any other compiler will
> complain that  too !

Oops - the version I posted differed in one character from the version 
that I'd compiled - I'd just used "sbb" in the working version and let 
the compiler figure out which version to use.

> 
> How about  below changes to your proposal code.
> 
> <             "sbbl   %0,%0" \
> <             :"=r"(Acq):"r"(GLptr),"i"(~1L):"dx","ax"); \
> ---
> 
>>            "sbbl   %%eax,%%eax" \
>>            :"=a"(Acq):"r"(GLptr),"i"(~1L):"dx"); \

Yes, that would work too, but I don't like forcing the asm to use 
particular registers when there's no good reason to do so.

> 
> 
> PS. I'm very curious about how could you find this bug.  

It was mainly down to the differences between the i386 and x86_64 
versions, and trying to understand the reasons for those differences, 
and indeed how the entire set of macros worked at all.

Paul


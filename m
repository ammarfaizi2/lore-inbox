Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262374AbUKKWbL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262374AbUKKWbL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 17:31:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262376AbUKKWbL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 17:31:11 -0500
Received: from fw.osdl.org ([65.172.181.6]:52461 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262374AbUKKWbF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 17:31:05 -0500
Date: Thu, 11 Nov 2004 14:30:45 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Len Brown <len.brown@intel.com>
cc: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Natalie Protasevich <Natalie.Protasevich@UNISYS.com>
Subject: Re: [PATCH] fix  platform_rename_gsi related ia32 build breakage
In-Reply-To: <1100211749.5510.753.camel@d845pe>
Message-ID: <Pine.LNX.4.58.0411111427050.2301@ppc970.osdl.org>
References: <4192A959.9020806@conectiva.com.br>  <4192A9BF.2080606@conectiva.com.br>
 <4192ADF4.1050907@conectiva.com.br>  <Pine.LNX.4.58.0411101621020.2301@ppc970.osdl.org>
 <1100211749.5510.753.camel@d845pe>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 11 Nov 2004, Len Brown wrote:
> 
> I used a function pointer here because the same kernel binary must be
> able to run on an ES7000 or a non-ES7000, so the compile-time inline
> idiom doesn't work. 

Sure it does. Do something like this in a header file

	static inline int translate_irq_number(...)
	{
		#ifdef CONFIG_ACPI_BOOT
			return fn_ptr_xxx();
		#else
			return irq;
		#endif
	}

which means that yes, it uses the function pointer when it is meaningful, 
but if there is no point, the code just goes away.

> If you read this far and have suggestions for a more descriptive name
> than platform_rename_gsi(), just let me know.

At _least_ write out what the hell "gsi" is.

TLA's are bad. "gsi" apparently isn't the Geological Survey of Ireland, 
but that's all I can tell from google.

		Linus

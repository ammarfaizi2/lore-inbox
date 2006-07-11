Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751109AbWGKREw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751109AbWGKREw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 13:04:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751122AbWGKREw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 13:04:52 -0400
Received: from fmr17.intel.com ([134.134.136.16]:32158 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751109AbWGKREv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 13:04:51 -0400
Subject: Re: [PATCH] irqtrace-option-off-compile-fix
From: Tim Chen <tim.c.chen@linux.intel.com>
Reply-To: tim.c.chen@linux.intel.com
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, akpm@osdl.org
In-Reply-To: <1152601989.3128.10.camel@laptopd505.fenrus.org>
References: <1152577120.7654.9.camel@localhost.localdomain>
	 <1152601989.3128.10.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Organization: Intel
Date: Tue, 11 Jul 2006 09:23:22 -0700
Message-Id: <1152635003.7654.40.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-8) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was testing on x86_64 and turned off the option in
arch/x86_64/Kconfig.debug. 

When the option is turned off, the following functions become undefined:
local_irq_disable()           
local_irq_enable()             
local_irq_save(flags)          
local_irq_restore(flags)       
safe_halt() 
local_save_flags()
irqs_disabled()
irqs_disabled_flags(flags)                   

It seems plausible that some users may want to avoid the overhead of
tracing IRQFLAGS by turning the option off.

Regards,
Tim Chen

On Tue, 2006-07-11 at 09:13 +0200, Arjan van de Ven wrote:
> On Mon, 2006-07-10 at 17:18 -0700, Tim Chen wrote:
> > When CONFIG_TRACE_IRQFLAGS_SUPPORT is turned off, the latest kernel has
> > compile errors.  The patch below fix the problems.
> 
> 
> Hi,
> 
> which architecture did you see this on? (asking because IA64 and PPC
> compile just fine without this, and for x86 and x86-64 this is not an
> option you can turn off as user, it's not a user selectable config
> option but it's a "I have this feature in arch" option)
> 
> Greetings,
>    Arjan van de Ven


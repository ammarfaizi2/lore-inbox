Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262119AbVAZXtw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262119AbVAZXtw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 18:49:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262105AbVAZXsI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 18:48:08 -0500
Received: from fmr23.intel.com ([143.183.121.15]:16086 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S262127AbVAZT02 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 14:26:28 -0500
Date: Wed, 26 Jan 2005 11:26:19 -0800
From: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
To: Nathan Lynch <nathanl@austin.ibm.com>
Cc: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>,
       lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] unexport register_cpu and unregister_cpu
Message-ID: <20050126112619.A27536@unix-os.sc.intel.com>
Reply-To: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
References: <1106722547.9855.36.camel@localhost.localdomain> <20050126102226.A27022@unix-os.sc.intel.com> <1106766630.13753.23.camel@biclops>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1106766630.13753.23.camel@biclops>; from nathanl@austin.ibm.com on Wed, Jan 26, 2005 at 01:10:30PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2005 at 01:10:30PM -0600, Nathan Lynch wrote:
> On Wed, 2005-01-26 at 10:22 -0800, Keshavamurthy Anil S wrote:
> > On Wed, Jan 26, 2005 at 12:55:47AM -0600, Nathan Lynch wrote:
> > > http://linus.bkbits.net:8080/linux-2.5/cset@4180a2b7mi2fzuNQDBOQY7eMAkns8g?nav=index.html|src/|src/drivers|src/drivers/base|related/drivers/base/cpu.c
> > > 
> > > This changeset introduced exports for register_cpu and unregister_cpu
> > > right after 2.6.10.  As far as I can tell these are not called from any
> > > code which can be built as a module, and I can't think of a good reason
> > > why any out of tree code would use them.  Unless I've missed something,
> > > can we remove them before 2.6.11?
> > 
> > 	No this is not correct. ACPI processor.ko driver which supports
> > physical CPU hotplug needs register_cpu() and unregister_cpu() functions
> > for dynamically hotadd/hotremove support of the processors.
> 
> I do not understand your objection.  The processor module does not call
> the interfaces in question directly.  They are called only from arch
> setup code (e.g. arch/ia64/kernel/topology.c) which is never built as a
> module.

Oops.. Sorry, its my fault.

> 
> > Please see drivers/acpi/processor_core.c  
> > 	acpi_processor_hotadd_init() -> arch_register_cpu() ->
> > 		->register_cpu().
> 
> Sure -- the arch_register_cpu and arch_unregister_cpu symbols need to be
> exported for this use (and they are).  Exporting register_cpu and
> unregister_cpu is unnecessary.

I agree with you 100%. 

> 
> I double-checked an ia64 build with CONFIG_ACPI_HOTPLUG_CPU=y and
> CONFIG_ACPI_PROCESSOR=m and saw no errors or warnings caused by the
> change...

Andrew, I have no objection with Nathan's patch.

thanks,
Anil


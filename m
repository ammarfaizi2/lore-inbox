Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262504AbVAZXkC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262504AbVAZXkC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 18:40:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261593AbVAZXjJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 18:39:09 -0500
Received: from fmr23.intel.com ([143.183.121.15]:10697 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S261597AbVAZSWk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 13:22:40 -0500
Date: Wed, 26 Jan 2005 10:22:27 -0800
From: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
To: Nathan Lynch <nathanl@austin.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       anil.s.keshavamurthy@intel.com
Subject: Re: [PATCH] unexport register_cpu and unregister_cpu
Message-ID: <20050126102226.A27022@unix-os.sc.intel.com>
Reply-To: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
References: <1106722547.9855.36.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1106722547.9855.36.camel@localhost.localdomain>; from nathanl@austin.ibm.com on Wed, Jan 26, 2005 at 12:55:47AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2005 at 12:55:47AM -0600, Nathan Lynch wrote:
> http://linus.bkbits.net:8080/linux-2.5/cset@4180a2b7mi2fzuNQDBOQY7eMAkns8g?nav=index.html|src/|src/drivers|src/drivers/base|related/drivers/base/cpu.c
> 
> This changeset introduced exports for register_cpu and unregister_cpu
> right after 2.6.10.  As far as I can tell these are not called from any
> code which can be built as a module, and I can't think of a good reason
> why any out of tree code would use them.  Unless I've missed something,
> can we remove them before 2.6.11?

	No this is not correct. ACPI processor.ko driver which supports
physical CPU hotplug needs register_cpu() and unregister_cpu() functions
for dynamically hotadd/hotremove support of the processors.

Please see drivers/acpi/processor_core.c  
	acpi_processor_hotadd_init() -> arch_register_cpu() ->
		->register_cpu().

-Anil



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751678AbWCBTdO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751678AbWCBTdO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 14:33:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752043AbWCBTdO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 14:33:14 -0500
Received: from mail.suse.de ([195.135.220.2]:9900 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751676AbWCBTdN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 14:33:13 -0500
From: Andi Kleen <ak@suse.de>
To: "Brown, Len" <len.brown@intel.com>
Subject: Re: 2.6.16rc5 'found' an extra CPU.
Date: Thu, 2 Mar 2006 20:33:04 +0100
User-Agent: KMail/1.9.1
Cc: "Dave Jones" <davej@redhat.com>,
       "Chuck Ebbert" <76306.1226@compuserve.com>,
       "linux-kernel" <linux-kernel@vger.kernel.org>,
       "linux-acpi" <linux-acpi@vger.kernel.org>
References: <F7DC2337C7631D4386A2DF6E8FB22B30063F9031@hdsmsx401.amr.corp.intel.com>
In-Reply-To: <F7DC2337C7631D4386A2DF6E8FB22B30063F9031@hdsmsx401.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603022033.05173.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 02 March 2006 20:26, Brown, Len wrote:
> Dave,
> Your DSDT looks fine.
> I was wrong assuming there were 3 Processor entries there.
> 
> > > Did you really build a 256-CPU SMP kernel or is ACPI 
> > > ignoring CONFIG_NR_CPUS or something?
> >
> >Yes, it's =256.
> 
> I expect this is the root problem.

It's useless anyways because the x86 apics cannot handle more than
255. Best fix is probably just the appended one. Does that fix the
issue?

i386 already had it correct BTW.

-Andi

Limit max number of CPUs to 255 

Because 256 causes overflows in some code that stores them in 8 bit
fields and the x86 APIC architecture cannot handle more than 255
anyways.

Signed-off-by: Andi Kleen <ak@suse.de>

Index: linux/arch/x86_64/Kconfig
===================================================================
--- linux.orig/arch/x86_64/Kconfig
+++ linux/arch/x86_64/Kconfig
@@ -323,7 +323,7 @@ config HAVE_ARCH_EARLY_PFN_TO_NID
 
 config NR_CPUS
 	int "Maximum number of CPUs (2-256)"
-	range 2 256
+	range 2 255
 	depends on SMP
 	default "8"
 	help

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263062AbTEMAyu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 20:54:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263077AbTEMAyu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 20:54:50 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:51960 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S263062AbTEMAyt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 20:54:49 -0400
Subject: Re: [PATCH] linux-2.5.69_clear-smi-fix_A1
From: john stultz <johnstul@us.ibm.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@digeo.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, James <jamesclv@us.ibm.com>
In-Reply-To: <3EC04261.6020206@us.ibm.com>
References: <1052785802.4169.12.camel@w-jstultz2.beaverton.ibm.com>
	 <3EC04261.6020206@us.ibm.com>
Content-Type: text/plain
Organization: 
Message-Id: <1052787818.4171.29.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 12 May 2003 18:03:38 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-05-12 at 17:54, Dave Hansen wrote:
> john stultz wrote:
> > 	I've been having problems with ACPI on a box here in our lab. Some of
> > our more recent hardware requires that SMIs are routed through the
> > IOAPIC, thus when we clear_IO_APIC() at boot time, we clear the BIOS
> > initialized SMI pin. This basically clobbers the SMI so we can then
> > never make the transition into ACPI mode. 
> > 
> > This patch simply reads the apic entry in clear_IO_APIC to make sure the
> > delivery_mode isn't dest_SMI. If it is, we leave the apic entry alone
> > and return.
> > 
> > With this patch, the box boots and SMIs function properly.
> 
> So, without the patch, what happens?  Does the thing just completely
> freeze when it tries to turn ACPI on?  Does the machine _require_ that
> you use ACPI?

When trying to boot w/ ACPI the transition fails and the box hobbles
along to different degrees. Normally the interrupt routing is bad and a
scsi or network card fails to init. 

Without ACPI the system boots fine. SMIs are still clobbered, but
they're less critical.

But really, ACPI (and SMIs) should "just work".  ;)

thanks
-john


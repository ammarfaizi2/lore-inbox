Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261325AbUBYUYI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 15:24:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261395AbUBYUYI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 15:24:08 -0500
Received: from fmr04.intel.com ([143.183.121.6]:25307 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S261325AbUBYUYE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 15:24:04 -0500
Subject: Re: 2.6.3 doesn't see my 2nd CPU
From: Len Brown <len.brown@intel.com>
To: Phil White <cerise@littlegreenmen.armory.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <A6974D8E5F98D511BB910002A50A6647615F2BC9@hdsmsx402.hd.intel.com>
References: <A6974D8E5F98D511BB910002A50A6647615F2BC9@hdsmsx402.hd.intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1077740640.5913.433.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 25 Feb 2004 15:24:00 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> CONFIG_HIGHMEM64G=y
> CONFIG_X86_PAE=y

> ACPI: S3 and PAE do not like each other for now, S3 disabled.

Try disabling PAE mode -- it only slows down your 1GB system anyway and
who knows -- maybe that is what broke.

> Booting processor 1/1 eip 2000
> Unable to handle kernel paging request<1>Unable to handle kernel
> paging request at virtual address 3f83ec0d

re: acpi=force
ACPI and MPS both recognize your 2nd processor as LAPIC ID 1, and the
smpboot code that tries to start it up and fails is common to both modes
-- so I don't see an MPS or ACPI-specific issue here.

> Another update.  The second processor still isn't working,
> but with args noapic, noirqbalance, and
> maxcpus=4 (even though there's only 2 cpus),
> the APIC problems go away.  They're replaced with
> spurious interrupts however.

I don't see these options having any effect on the root problem, which
is that the kernel faults when starting the 2nd processor.  Note that
"noapic" technically isn't supported on an MPS compliant SMP system.

-Len



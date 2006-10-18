Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423097AbWJRWYq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423097AbWJRWYq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 18:24:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423104AbWJRWYq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 18:24:46 -0400
Received: from mx1.redhat.com ([66.187.233.31]:57482 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1423095AbWJRWYp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 18:24:45 -0400
Date: Wed, 18 Oct 2006 18:24:33 -0400
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: acpi-devel@lists.sourceforge.net
Subject: SMP broken on pre-ACPI machine.
Message-ID: <20061018222433.GA4770@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	acpi-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been chasing a bug that got filed against the Fedora kernel
a while back:  https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=199052
This is a dual pentium pro from an era before we had ACPI, and
it seems to be falling foul of this test in smpboot.c  ..

    if (!smp_found_config && !acpi_lapic) {
        printk(KERN_NOTICE "SMP motherboard not detected.\n");
        smpboot_clear_io_apic_irqs();
        phys_cpu_present_map = physid_mask_of_physid(0);
        if (APIC_init_uniprocessor())
            printk(KERN_NOTICE "Local APIC not detected."
                       " Using dummy APIC emulation.\n");
        map_cpu_to_logical_apicid();
        cpu_set(0, cpu_sibling_map[0]);
        cpu_set(0, cpu_core_map[0]);
        return;
    }


My initial reaction is that the !acpi_lapic test should be conditional
on some variable that gets set if the ACPI parsing actually succeeded.

Thoughts?

	Dave

-- 
http://www.codemonkey.org.uk

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161216AbWBUAOJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161216AbWBUAOJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 19:14:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161217AbWBUAOJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 19:14:09 -0500
Received: from simmts7.bellnexxia.net ([206.47.199.165]:56788 "EHLO
	simmts7-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S1161216AbWBUAOI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 19:14:08 -0500
Message-ID: <43FA5B47.3070703@ns.sympatico.ca>
Date: Mon, 20 Feb 2006 20:13:59 -0400
From: Kevin Winchester <kwin@ns.sympatico.ca>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: x86_64 ACPI Error in 2.6.16-rc4-mm1
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have the following little message in my log with rc4-mm1 that I don't 
have with vanilla rc4, running on a single processor athlon 64 box:

ACPI Error (acpi_processor-0488): Getting cpuindex for acpiid 0x1 [20060210]

It apparently gets printed here (in drivers/acpi/processor_core.c):

        /*
         *  Extra Processor objects may be enumerated on MP systems with
         *  less than the max # of CPUs. They should be ignored _iff
         *  they are physically not present.
         */
        if (cpu_index >= NR_CPUS) {
                if (ACPI_FAILURE
                    (acpi_processor_hotadd_init(pr->handle, &pr->id))) {
                        ACPI_ERROR((AE_INFO,
                                    "Getting cpuindex for acpiid 0x%x",
                                    pr->acpi_id));
                        return_VALUE(-ENODEV);
                }
        }

It doesn't seem to cause anything not to work, but I thought I'd mention 
it anyway.  If it is obvious to anyone why I get the message, I won't 
have to try to bisect the patches.

I can send my config if anyone wants to see it, and I can also test 
patches.  I'm not subscribed to the list, so please CC me.

Thanks,
Kevin Winchester



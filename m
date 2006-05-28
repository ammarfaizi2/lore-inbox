Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750787AbWE1QEE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750787AbWE1QEE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 May 2006 12:04:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750786AbWE1QEE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 May 2006 12:04:04 -0400
Received: from rtr.ca ([64.26.128.89]:27031 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1750783AbWE1QEB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 May 2006 12:04:01 -0400
Message-ID: <4479C9F0.9090807@rtr.ca>
Date: Sun, 28 May 2006 12:04:00 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org,
       len.brown@intel.com
Subject: [BUG] Link problem on drivers/acpi/processor_idle.c
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In 2.6.17-rc5, the GNU linker gives me this message:

WARNING: drivers/acpi/processor.o - Section mismatch: reference to .init.data: from .text between 'acpi_processor_power_init' (at offset 0xec7) and 'acpi_processor_cst_has_changed'

It is basically pointing out a potential bug on from processor_idle.c,
on this line of code:

     dmi_check_system(processor_power_dmi_table);

The problem here, is that processor_power_dmi_table is declared as __cpuinitdata,
and is not guaranteed to exist when invoked from code other than __init code.

The acpi_processor_power_init() routine is NOT marked as __init code.

Cheers

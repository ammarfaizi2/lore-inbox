Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932245AbWFGPCz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932245AbWFGPCz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 11:02:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932246AbWFGPCy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 11:02:54 -0400
Received: from rtr.ca ([64.26.128.89]:58774 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S932241AbWFGPCy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 11:02:54 -0400
Message-ID: <4486EA96.9080502@rtr.ca>
Date: Wed, 07 Jun 2006 11:02:46 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, len.brown@intel.com,
       linux-acpi@vger.kernel.org
Subject: 2.6.17-rc6 (potential) bugs:
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From building the 2.6.17-rc6 kernel on my x86 machine:
>WARNING: drivers/acpi/processor.o - Section mismatch: reference to .init.data: from .text between 'acpi_processor_power_init' (at offset 0xec7) and 'acpi_processor_cst_has_changed'

This is due to processor_power_dmi_table[] (__cpuinitdata)
being accessed from acpi_processor_power_init() (a non-__init function).
If the memory for the table is ever released after bootup,
then this code may crash and burn.

>WARNING: drivers/video/macmodes.o - Section mismatch: reference to .init.text:mac_find_mode from __ksymtab between '__ksymtab_mac_find_mode' (at offset 0x0) and '__ksymtab_mac_map_monitor_sense'

This one looks like a similar issue, but my eyes failed to spot the offending lines.

Cheers

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964853AbWC2ABD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964853AbWC2ABD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 19:01:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964854AbWC2ABD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 19:01:03 -0500
Received: from mx2.suse.de ([195.135.220.15]:49886 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964853AbWC2ABB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 19:01:01 -0500
From: Andi Kleen <ak@suse.de>
To: "Luck, Tony" <tony.luck@intel.com>
Subject: Re: Some section mismatch in acpi_processor_power_init on ia64 build
Date: Wed, 29 Mar 2006 02:00:55 +0200
User-Agent: KMail/1.9.1
Cc: "Raj, Ashok" <ashok.raj@intel.com>, linux-kernel@vger.kernel.org
References: <B8E391BBE9FE384DAA4C5C003888BE6F0613EDAB@scsmsx401.amr.corp.intel.com>
In-Reply-To: <B8E391BBE9FE384DAA4C5C003888BE6F0613EDAB@scsmsx401.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603290200.56023.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 29 March 2006 01:09, Luck, Tony wrote:
> I've only just noticed these warnings when building ia64 !SMP or
> !HOTPLUG_CPU
> kernels:
> 
> WARNING: drivers/acpi/processor.o - Section mismatch: reference to
> .init.data: from .text between 'acpi_processor_power_init' (at offset
> 0x5040) and 'acpi_processor_power_exit'
> WARNING: drivers/acpi/processor.o - Section mismatch: reference to
> .init.data: from .text between 'acpi_processor_power_init' (at offset
> 0x5050) and 'acpi_processor_power_exit'

These functions need to be marked __cpuinit I guess. I doubt they
run without new CPUs.

> 
> According to git bisect, they began with Matt Domsch's "ia64: use i386
> dmi_scan.c"
> patch (commit 3ed3bce8), but it appears that the real issue may be
> further back when
> Ashok Raj marked processor_power_dmi_table as __cpuinitdata in 7ded5689
> with a
> cryptic comment by AK (Andi Kleen?):
>   /* Actually this shouldn't be __cpuinitdata, would be better to fix
> the
>      callers to only run once -AK */

Yes that's me. What is cryptic?

-Andi

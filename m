Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269409AbTGOSgs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 14:36:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269518AbTGOSgr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 14:36:47 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:33458 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S269409AbTGOSfO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 14:35:14 -0400
Date: Tue, 15 Jul 2003 20:49:29 +0200 (MEST)
Message-Id: <200307151849.h6FInTkH025346@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: andrew.grover@intel.com, hugh@veritas.com, len.brown@intel.com
Subject: RE: ACPI patches updated (20030714)
Cc: acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       marcelo@conectiva.com.br
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jul 2003 11:07:29 -0700, "Brown, Len" wrote:
>Ps. Below is the current plan for ACPI build and boot knobs.  Except for the
>config syntax -- 2.4 and 2.5 should end up the same.  Let me know if we
>missed anything.
>
>Audit of ACPI build and boot options
>Scrubbed w/ Andy 7/10 -- see TODO for Lenb's plan
>
>
>Build Options
>-------------
>Indentation shows dependency (from acpi/Kconfig, Makefile)
>
>CONFIG_ACPI_HT_ONLY
>	depends on X86 && ACPI && X86_LOCAL_APIC
>	:= acpitable.o
>
>	TODO: simplify acpitable.c to only to LAPIC enumeration for HT
>		It probably shouldn't parse the non-LAPIC MADT entries

I would like to see HT_ONLY generalized to parsing the MADT for
I/O-APICs. The problem I have is that some mainboards, like my
i850 ASUS P4T-E, have I/O-APICs but no MP tables. The only way for
the Linux kernel to discover the I/O-APICs on these mainboard is
through MADT parsing.

However, this currently requires me to enable all of ACPI, which
I don't need or want for many reasons, including code bloat and
behavioural side-effects.

Replacing "HT_ONLY" with "MADT_PARSING_ONLY" would be ideal, IMO.

/Mikael

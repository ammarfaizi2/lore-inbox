Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265640AbUBJFha (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 00:37:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265641AbUBJFha
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 00:37:30 -0500
Received: from fmr04.intel.com ([143.183.121.6]:3467 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S265640AbUBJFh2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 00:37:28 -0500
Subject: Re: HT CPU handling - 2.6.2
From: Len Brown <len.brown@intel.com>
To: Hod McWuff <hod@wuff.dhs.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <BF1FE1855350A0479097B3A0D2A80EE0023E8B98@hdsmsx402.hd.intel.com>
References: <BF1FE1855350A0479097B3A0D2A80EE0023E8B98@hdsmsx402.hd.intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1076391435.4103.730.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 10 Feb 2004 00:37:15 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Your BIOS is reporting the 2nd CPU as disabled, and telling us that it
has LAPIC id 0x81 = 129.  The ACPI table code prints this out and
registers the processor anyway, but that chokes because the LAPIC ID is
way out of bounds.

I'm thinking that ACPI should not register a processor that the BIOS
marked as disabled...

What should you do?  Apparently you've got an HT-enabled platform, BIOS,
and OS, but do not have an HT-enabled processor.  Your choices are to
disable HT in the BIOS SETUP to clean up this message, or plug in an
HT-enabled processor.

cheers,
-Len

On Mon, 2004-02-09 at 15:44, Hod McWuff wrote:
> I've got a 2.0A GHz P4, advertised as non-hyperthread, that seems to
> be
> reporting the presence of a second CPU. It also seems to be disabled
> by
> setting bit 7 of its ID. I've tried compiling with support for 130
> CPU's
> and nothing changed. What would have to be done to get this disabled
> CPU half back online?
> 
> Feb  9 04:45:03 pug ACPI: Local APIC address 0xfee00000
> Feb  9 04:45:03 pug ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
> Feb  9 04:45:03 pug Processor #0 15:2 APIC version 20
> Feb  9 04:45:03 pug ACPI: LAPIC (acpi_id[0x02] lapic_id[0x81]
> disabled)
> Feb  9 04:45:03 pug Processor #129 invalid (max 16)
> Feb  9 04:45:03 pug ACPI: LAPIC_NMI (acpi_id[0x01] dfl dfl lint[0x1])
> Feb  9 04:45:03 pug ACPI: LAPIC_NMI (acpi_id[0x02] dfl dfl lint[0x1])
> 
> -
> To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 


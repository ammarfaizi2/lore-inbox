Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265689AbUBJHcs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 02:32:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265694AbUBJHcs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 02:32:48 -0500
Received: from data.idl.com.au ([203.32.82.9]:11661 "EHLO smtp.idl.net.au")
	by vger.kernel.org with ESMTP id S265689AbUBJHcq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 02:32:46 -0500
From: Athol Mullen <athol_SPIT_SPAM@idl.net.au>
Subject: Re: HT CPU handling - 2.6.2
Newsgroups: linux.kernel
References: <1nyMT-4MT-11@gated-at.bofh.it> <1nyMT-4MT-9@gated-at.bofh.it>
Organization: Mullen Automotive Engineering
Date: Tue, 10 Feb 2004 18:28:41 +1100
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402101828.42001.athol_SPIT_SPAM@idl.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Len Brown <len.brown@intel.com> wrote:
> Your BIOS is reporting the 2nd CPU as disabled, and telling us that it
> has LAPIC id 0x81 = 129.  The ACPI table code prints this out and
> registers the processor anyway, but that chokes because the LAPIC ID is
> way out of bounds.

IIRC, This is what happens with any P4 that sets the HT flag but only
has one logical CPU.  Completely within Intel specs.  I spent several
days struggling with this months ago when I thought that the 2.4GHz P4
I've got was HT capable.  Then I RTFM...

BTW, IIRC, the BIOS of my machine shows "Local APIC Support" instead of
"Hyperthreading Support" if the CPU installed isn't really HT capable.

> I'm thinking that ACPI should not register a processor that the BIOS
> marked as disabled...

The processor counter should find "logical processors present" is one
and ignore the hardware disabled 2nd logical CPU.

> What should you do?  Apparently you've got an HT-enabled platform, BIOS,
> and OS, but do not have an HT-enabled processor.  Your choices are to
> disable HT in the BIOS SETUP to clean up this message, or plug in an
> HT-enabled processor.

Better still, enable Local APIC but not SMP or HT when you build a
kernel.  That way, you get Local APIC support without SMP kernel.

-- 
Athol
<http://cust.idl.com.au/athol>
Linux Registered User # 254000
I'm a Libran Engineer. I don't argue, I discuss.



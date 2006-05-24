Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932657AbWEXIL2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932657AbWEXIL2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 04:11:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932660AbWEXIL2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 04:11:28 -0400
Received: from aun.it.uu.se ([130.238.12.36]:17623 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S932657AbWEXIL1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 04:11:27 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17524.5395.541534.323286@alkaid.it.uu.se>
Date: Wed, 24 May 2006 10:10:59 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: "Brown, Len" <len.brown@intel.com>
Cc: "Vladimir Dvorak" <dvorakv@vdsoft.org>,
       "Jan Engelhardt" <jengelh@linux01.gwdg.de>, "Andi Kleen" <ak@suse.de>,
       <linux-kernel@vger.kernel.org>
Subject: RE: APIC error on CPUx
In-Reply-To: <CFF307C98FEABE47A452B27C06B85BB68AD7E5@hdsmsx411.amr.corp.intel.com>
References: <CFF307C98FEABE47A452B27C06B85BB68AD7E5@hdsmsx411.amr.corp.intel.com>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brown, Len writes:
 > Vladimir's SCB2/Serverworks boots with and without "acpi=off",
 > and in both cases the IOAPICS are set up properly,
 > the device work, and there are the following messages:
 > 
 > APIC error on CPU1: 00(40)
 > APIC error on CPU0: 00(40)
 > APIC error on CPU0: 40(40)
 > APIC error on CPU0: 40(40)
 > APIC error on CPU0: 40(40)
 > 
 > These are the now infamous "Receive illegal vector" messages.
 > I expect this chipset has a physical APIC bus (rather than
 > the FSB delivery used today) which is mis-behaving.
 > 
 > I've never heard of this being associated with an actual
 > failure (such as a lost interrupt).  This message is already
 > KERN_DEBUG -- can't get any lower priority than that.
 > Maybe we should put this message under apic_printk()?

The default must be that APIC errors are logged. They are valid
indicators of hardware brokenness, and have in the past been
traced to bad mobos, bad PSUs, bad cooling, and even kernel bugs.
The fact that many systems manage to limp along in their presence
doesn't matter.

The default for apic_printk is to print nothing (apic_verbosity
== APIC_QUIET). You could add a fourth level (ERROR or WARNING)
between QUIET and VERBOSE, make apic_verbosity initialise to that
level, and use that level for the APIC error messages. That would
make the messages visible by default but possible to suppress for
knowledgeable users.

/Mikael

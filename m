Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751637AbWCPGyJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751637AbWCPGyJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 01:54:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752200AbWCPGyI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 01:54:08 -0500
Received: from mraos.ra.phy.cam.ac.uk ([131.111.48.8]:13551 "EHLO
	mraos.ra.phy.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1751637AbWCPGyH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 01:54:07 -0500
To: "Yu, Luming" <luming.yu@intel.com>
cc: linux-kernel@vger.kernel.org, "Linus Torvalds" <torvalds@osdl.org>,
       "Andrew Morton" <akpm@osdl.org>, "Tom Seeley" <redhat@tomseeley.co.uk>,
       "Dave Jones" <davej@redhat.com>, "Jiri Slaby" <jirislaby@gmail.com>,
       michael@mihu.de, mchehab@infradead.org,
       "Brian Marete" <bgmarete@gmail.com>,
       "Ryan Phillips" <rphillips@gentoo.org>, gregkh@suse.de,
       "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org,
       "Mark Lord" <lkml@rtr.ca>, "Randy Dunlap" <rdunlap@xenotime.net>,
       jgarzik@pobox.com, "Duncan" <1i5t5.duncan@cox.net>,
       "Pavlik Vojtech" <vojtech@suse.cz>, "Meelis Roos" <mroos@linux.ee>
Subject: Re: 2.6.16-rc5: known regressions [TP 600X S3, vanilla DSDT] 
In-Reply-To: Your message of "Thu, 16 Mar 2006 14:41:27 +0800."
             <3ACA40606221794F80A5670F0AF15F840B37A678@pdsmsx403> 
Date: Thu, 16 Mar 2006 06:54:04 +0000
From: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Message-Id: <E1FJmN2-00009O-00@skye.ra.phy.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Okay it's compiling with that change.  Now those two methods look
like:

      Method (_PSV, 0, NotSerialized)
      {
        /* Store (DerefOf (Index (DerefOf (MODP (0x00)), 0x01)),  Local0) */
	   Return (Local0)
      }
      Method (_AC0, 0, NotSerialized)
      {
	  If (H8DR)
	  {
	      Store (\_SB.PCI0.ISA0.EC0.HT00, Local1)
	  }
	  Else
	  {
	      And (\_SB.RBEC (0x20), 0x01, Local1)
	  }

	  Store (Local1, \_TZ.THM0.AC0M)
       /* Store (DerefOf (Index (DerefOf (MODP (0x01)), Local1)), Local0) */
	  Return (Local0)
      }

But I have two worries:

1. The lines that I commented out are not identical (if they are
   identical in your setup, maybe we have different disassembled
   DSDT's?).

2. With those lines commented out, the local variables might contain
   garbage, since those lines initialize them.  The iasl compiler also
   worries about this:

  thm0-ac0psv-line.dsl 10504:                 Return (Local0)
  Error    1013 - Method local variable is not initialized ^  (Local0)

  thm0-ac0psv-line.dsl 10520:                  Return (Local0)
  Error    1013 -  Method local variable is not initialized ^  (Local0)

Should I change the Return statement to Return(0)?

-Sanjoy

`Never underestimate the evil of which men of power are capable.'
         --Bertrand Russell, _War Crimes in Vietnam_, chapter 1.

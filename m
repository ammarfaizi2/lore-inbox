Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262360AbTK1POS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Nov 2003 10:14:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262373AbTK1POS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Nov 2003 10:14:18 -0500
Received: from mail1.neceur.com ([193.116.254.3]:47246 "EHLO mail1.neceur.com")
	by vger.kernel.org with ESMTP id S262360AbTK1POC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Nov 2003 10:14:02 -0500
In-Reply-To: <001a01c3b515$b6030de0$0f00a8c0@client.attbi.com>
To: "Brendan Howes" <brendan@netzentry.com>
Cc: linux-kernel@vger.kernel.org
Subject: NForce2 pseudoscience stability testing (2.6.0-test11)
MIME-Version: 1.0
X-Mailer: Lotus Notes Build V65_M1_04032003NP April 03, 2003
Message-ID: <OF6617181D.A93B9D63-ON80256DEC.004D7534-80256DEC.0053A823@uk.neceur.com>
From: ross.alexander@uk.neceur.com
Date: Fri, 28 Nov 2003 15:13:45 +0000
X-MIMETrack: Serialize by Router on LDN-THOTH/E/NEC(Release 5.0.10 |March 22, 2002) at
 11/28/2003 03:13:44 PM,
	Serialize complete at 11/28/2003 03:13:44 PM,
	Itemize by SMTP Server on ldn-hermes/E/NEC(Release 5.0.10 |March 22, 2002) at
 11/28/2003 03:13:44 PM,
	Serialize by Router on ldn-hermes/E/NEC(Release 5.0.10 |March 22, 2002) at
 11/28/2003 03:13:46 PM,
	Serialize complete at 11/28/2003 03:13:46 PM
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brendan et al,

I have been test various kernel parameter combinations to test stability.

Basic scenario is default IDE driver, AIC7xxx PCI SCSI connected to HP 
externel DVD.
Using grip (CDDA ripper) to test if system locks up.  Unstable systems 
will normally lock up
around track two or three.  Stable systems are those which haven't locked 
up after half
a dozen different CDs have been ripped.

MB: ASUS A7N8X
CPU: Athlon XP 2700+
Memory: 1.5GB (3 x 512MB DIMMs)
Disk: Internal 80GB IDE

COMPILE         SMP     ACPI    PCI     LAPIC   APIC    RESULT  NOTE
SMP,PREM                ON                              F
SMP,PREM                ON      NOACPI                  F
SMP,PREM                OFF                             F
SMP,PREM                OFF             NO      NO      S
SMP,PREM                OFF                     NO      F
SMP,PREM                OFF             NO              S
SMP,PREM                ON              NO      NO      F       1
SMP                     ON              NO              F       2
SMP                                                     F       3
APIC,LAPIC                                              S
PREM,APIC,LAPIC                                         S

* SMP = On (if compiled it) unless nosmp set.  Using nosmp with smp kernel 
causes very odd results.
* ACPI = Compiled by default.  Set off using kernel paramter acpi=off.
* PCI = Kernel parameter.  Only used to turn APCI routing off.
* LAPIC = Kernel paramter to turn it off (nolapic).
* APIC = Kernel paramter to turn it off (noapic).

1. Using APCI PCI routing and nolapic gives very odd results.  As soon as 
the network tries
to configure itself it simple hangs (but C-Alt-Del will reboot it).

2. Using the nolapic kernel parameter without disabling ACPI does nothing.

3. Using kernel parameter nosmp on and SMP kernel causes all the lower 16 
IRQs to work in XT-PIC
mode and the PCI network card to use IRQ 21 with IO-APIC-level.  Trying to 
modprobe aic7xxx hung
modprobe but not system.

The conclusion to this is the problem is in Local APIC with SMP.  I'm not 
saying this is actually true
only that is what the data suggests.  If anybody wants me to try some 
other stuff feel free to suggest
ideas.

Cheers,

Ross

---------------------------------------------------------------------------------
Ross Alexander                           "We demand clearly defined
MIS - NEC Europe Limited            boundaries of uncertainty and
Work ph: +44 20 8752 3394         doubt."

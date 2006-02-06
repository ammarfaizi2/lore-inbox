Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751407AbWBKKdh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751407AbWBKKdh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Feb 2006 05:33:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751408AbWBKKdh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Feb 2006 05:33:37 -0500
Received: from tirith.ics.muni.cz ([147.251.4.36]:59539 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S1751407AbWBKKdg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Feb 2006 05:33:36 -0500
Subject: RE: EC interrupt mode by default breaks power button and lid button
Date: Mon, 6 Feb 2006 15:37:47 +0800
In-reply-to: <3ACA40606221794F80A5670F0AF15F84041AC24F@pdsmsx403>
From: Jiri Slaby <jirislaby@gmail.com>
To: "Yu, Luming" <luming.yu@intel.com>
Cc: "Gerhard Schrenk" <deb.gschrenk@gmx.de>,
       "Brown, Len" <len.brown@intel.com>, <linux-kernel@vger.kernel.org>
Message-Id: <E1F7s49-0003gB-00@decibel.fi.muni.cz>
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Envelope-From: xslaby@informatics.muni.cz
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luming Yu wrote:
>Please don't revert that patch, and test kernel parameter ec_intr=0
>Also, please send me acpidump output.
>
>I'm wondering how ec interrupt mode breaks power & lid button.
Hello, I have some problems too:
ACPI: write EC, IB not empty
ACPI: write EC, IB not empty
ACPI: write EC, IB not empty
ACPI Exception (evregion-0409): AE_TIME, Returned by Handler for [EmbeddedControl] [20060127]
ACPI Error (psparse-0517): Method parse/execution failed [\_SB_.PCI0.SBRG.EC0_.RDC3] (Node ddf13fa8), AE_TIME
ACPI Error (psparse-0517): Method parse/execution failed [\ECIO] (Node ddf13628), AE_TIME
ACPI Error (psparse-0517): Method parse/execution failed [\_SB_.PCI0.SBRG.EC0_.ACPS] (Node ddf11228), AE_TIME
ACPI Error (psparse-0517): Method parse/execution failed [\ACPS] (Node ddf0b368), AE_TIME
ACPI Error (psparse-0517): Method parse/execution failed [\_SB_.PCI0.AC0_._PSR] (Node ddf10228), AE_TIME
 acpi_ac-0095 [10] ac_get_state          : Error reading AC Adapter state

acpidump here:
http://www.fi.muni.cz/~xslaby/sklad/adump

dmesgs here:
http://www.fi.muni.cz/~xslaby/sklad/intr0 ec_intr=0
http://www.fi.muni.cz/~xslaby/sklad/intr1 ec_intr=1
http://www.fi.muni.cz/~xslaby/sklad/intrx without ec_intr param

acpi irqs with ec_intr1 increments by touching the button, but acpi_listen says
nothing.

I had to use ec_burst=1 in latest kernels, now there is no option such this.
I had to use patch from bug 4980 (if the number is correct), but they become to
kernel in 2.6.16-rc1-git8, so I tried rc2, but with this error.

regards,
--
Jiri Slaby         www.fi.muni.cz/~xslaby
\_.-^-._   jirislaby@gmail.com   _.-^-._/
B67499670407CE62ACC8 22A032CC55C339D47A7E

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932537AbWEVHG0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932537AbWEVHG0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 03:06:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932539AbWEVHG0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 03:06:26 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:19298 "EHLO
	pd2mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S932537AbWEVHGZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 03:06:25 -0400
Date: Mon, 22 May 2006 01:06:10 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: ACPI suspend problems revisited: USB & 1394 modules?
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <447162E2.7050803@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I reported a problem with ACPI suspend on a Compaq Presario X1050 laptop 
a while ago:

http://bugzilla.kernel.org/show_bug.cgi?id=6075

Essentially when coming out of suspend I get ACPI execution errors like:

ACPI: read EC, IB not empty
ACPI Exception (evregion-0409): AE_TIME, Returned by Handler for
[EmbeddedControl] [20060127]
ACPI Exception (dswexec-0458): AE_TIME, While resolving operands for
[AE_NOT_CONFIGURED] [20060127]
ACPI Error (psparse-0517): Method parse/execution failed
[\_SB_.C046.C059.C0EA.C11D] (Node dfea0280), AE_TIME
ACPI Error (psparse-0517): Method parse/execution failed [\_WAK] (Node
c14dc500), AE_TIME

After this point, the battery status is no longer reported, the keyboard 
starts losing keypresses and the mouse pointer tends to freeze up for a 
while and then unstick. What ACPI seems to be having problems with is 
that the ACPI Embedded Controller seems to be in a wacked-out state 
where it appears to not process its input. As well, the keyboard/PS2 
controller is messed up and keeps losing sync. Since these are 
apparently usually the same physical hardware, this isn't too surprising 
to see both problems.

Another user mentioned recently. that removing USB and IEEE1394 modules 
prevented the problem on his HP laptop. For me, if the ohci_hcd, 
ehci_hcd and ohci1394 modules are removed, suspend indeed appears to 
work. I haven't tested all possible combinations, but it seems that if 
any of those are loaded, the problem shows up. I've seen a number of 
suspend scripts people have written that remove at least the USB modules 
before suspend and reload them afterwards, but this seems like a rather 
brutal hack.

I can possibly imagine some BIOS SMM code causing problems on the USB 
side, but I'm not sure how the 1394 module could be involved here..

Does anyone have any ideas as to how I could help debug this further?

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

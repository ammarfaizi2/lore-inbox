Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261418AbVGSP1s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261418AbVGSP1s (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Jul 2005 11:27:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261416AbVGSP1s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jul 2005 11:27:48 -0400
Received: from alpha.tmit.bme.hu ([152.66.246.10]:11787 "EHLO alpha.ttt.bme.hu")
	by vger.kernel.org with ESMTP id S261856AbVGSP1p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jul 2005 11:27:45 -0400
Message-ID: <42DD9AB9.1030808@alpha.tmit.bme.hu>
Date: Tue, 19 Jul 2005 17:28:41 -0700
From: Gyorgy Horvath <horvaath@alpha.tmit.bme.hu>
User-Agent: Mozilla Thunderbird 0.9 (Windows/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: ANNOUNCE: Driver for Rocky 4782E WDT and pls help
References: <42DC2871.1030103@alpha.tmit.bme.hu> <1121704467.12438.71.camel@localhost.localdomain>
In-Reply-To: <1121704467.12438.71.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again,

I have scanned IHC errata for this Rocky stuff.

First, lspi -vvv said that Rocky has 82820.
Hmm... I have a phy look at the card and see 82801.
OK.
I went to the Intel site, and downloaded the spec updates
for it.

http://www.intel.com/design/chipsets/mobile/documentation845.htm#specupdates
Intel (R) 82801CAM I/O Controller Hub 3 (ICH3-M)
Specification Update

-- -- --
Errata 22. IDE Hang Issue

Problem:

An arbitration deadlock in the ICH3-M may occur if
IDE traffic is combined with heavy graphic traffic and
internal/external PCI Bus Master traffic to memory.

Implication:

This issue may lockup the IDE bus master causing a
system hang. This issue was found during ongoing internal
validation using a synthetic test environment and there
have been no failures reported by customers.

Workaround:

BIOS needs to set configuration register
(Device 31, Function 0, offset FCh, bit 23) to prevent the
arbitration deadlock. Contact your local Intel Field
representative if you require more detailed
BIOS workaround information.

-- -- --
Errata 24. DWORD I/O Cycle Native Mode IDE Issue

Problem:

An I/O read crossing a DWORD boundary being sent
from processor to the ICH3-M may not complete correctly.
The ICH3-M will treat such a transaction as two single DWORD
I/O accesses.
If native mode IDE addressing is enabled, the ICH3-M will
return the first I/O cycle completion request to the MCH
but the second I/O cycle may get decoded to the IDE
controller instead of its intended address.

Implication:

System may hang while processor waits for return of I/O cycle.

Workaround:

Disable Native Mode IDE in BIOS. See ICH3-M BIOS Specification
Update for more details.
-- -- --
There are A LOT of other issues, but the aboves may be relevant.
I am going to try them.
Can you guide me where can I place the mentioned workarounds?
Also - how can I check that we are REALLY facing this chipset?
Are the PCI ID's enough?
(btw. lspci makes me fool)

Also, disabling IDE DMA caused an other side effect.
At a Poisson distributed moment - my interrupt from
the SGA155D simply can not get thru.

It is a known issue for me. SGA1GED dual gigabit
ethernet (monitor) card produced the same on a brand new
PC (blue lights from the power supply, etc... :-).

Since the chipset is so new - no IDE DMA in 2.4.18 for this.
It is not a real problem since we have a 3ware raid in place.
Now it is 14 days up, and cca. 160 Giga of headers were captured.
(students are on their holliday - that is why so few data)
The workaround was QED. The capture task reads AMCC S5933
when the IT count is stalled for a while.
That rearms the IT logic - and the show goes on.

Unfortunatelly, for the POS stuff this trick cannot be used.
Precise timing for TX schedule is vital.

So I have to dig further.

Best regards

Gyuri


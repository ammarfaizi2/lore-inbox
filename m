Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263055AbVG3QUe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263055AbVG3QUe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 12:20:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263061AbVG3QUe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 12:20:34 -0400
Received: from zproxy.gmail.com ([64.233.162.203]:59844 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263055AbVG3QUb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 12:20:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=S88k6//kB2hnLrFFPQEg5FXVgATOUlfjfQ009Ydr0uTMllrlazEwYlmIEIO18TKNdqkcaB6sShvftDKUHdKKPR8cbwfT1gFkuAlQYTPT5JKy+yZ9VA63gvtNX6dbB6KvvKtlB9vY5tkqiBcoHMLyaMYTs+4q5qxR87O0OVhAb7A=
Message-ID: <87ab37ab0507300920570b0ea6@mail.gmail.com>
Date: Sun, 31 Jul 2005 00:20:30 +0800
From: kylin <fierykylin@gmail.com>
Reply-To: kylin <fierykylin@gmail.com>
To: rajesh.shah@intel.com
Subject: Re: Re: Problem while inserting pciehp (PCI Express Hot-plug) driver
Cc: linux-kernel@vger.kernel.org, linux-newbie@vger.kernel.org,
       acpi-devel@lists.sourceforge.net,
       linux-hotplug-devel@lists.sourceforge.net, dkumar@noida.hcltech.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

n the latest update of the Intel's E7520 MCH,the very NOTFIX entry
caught my eye:
//////////////////////
PCI Express Hot-Plug MSI interrupt issue
////////////////////
Problem:
During a link down state, the MCH will not send MSI interrupts to the
front side bus. In general
MSI messages need not be delivered when the link is down, but in the
event that MSI interrupt routing is used on Hot-Plug events, the
processor will wait indefinitely for this interrupt. Waiting for
command complete interrupts is a normal part of the steps in the
orderly removal process, and link down will occur at the point that
power is removed from the slot. Subsequent accesses to the slot
control register to update indicators and power control will not
generate the expected MSI interrupts from the MCH until slot power is
restored, and the link is back up.
Implication:
Hot-Plug software written to wait for command complete interrupts will
hang in MSI interrupt mode.
Workaround:
Run in either of the other two interrupt modes (the "legacy" method
using the MCHGPE# to signal
hot-plug interrupts to the ICH or "native" interrupt mode using PCI
interrupts (INTA#)).
Alternatively in MSI mode, software may poll for command complete
rather than wait for MSI, or implement the command complete timeout to
continue to the next slot control update rather than repeat the
current slot control update
I wonder if i can workaround the MSI using the polling way on the
server geared by E7520 and the firmware with no OSC implemented


-- 
we who r about to die,salute u!

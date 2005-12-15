Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751124AbVLOVgp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751124AbVLOVgp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 16:36:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751126AbVLOVgp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 16:36:45 -0500
Received: from sj-iport-2-in.cisco.com ([171.71.176.71]:15625 "EHLO
	sj-iport-2.cisco.com") by vger.kernel.org with ESMTP
	id S1751124AbVLOVgo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 16:36:44 -0500
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-pci <linux-pci@atrey.karlin.mff.cuni.cz>
Subject: Re: MSI and driver APIs
X-Message-Flag: Warning: May contain useful information
References: <1134617893.16880.17.camel@gaston> <adamzj2nk76.fsf@cisco.com>
	<1134680882.16880.37.camel@gaston> <adaek4enjoz.fsf@cisco.com>
	<1134681498.16880.39.camel@gaston>
From: Roland Dreier <rdreier@cisco.com>
Date: Thu, 15 Dec 2005 13:36:37 -0800
In-Reply-To: <1134681498.16880.39.camel@gaston> (Benjamin Herrenschmidt's
 message of "Fri, 16 Dec 2005 08:18:17 +1100")
Message-ID: <adawti6m49m.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.17 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-OriginalArrivalTime: 15 Dec 2005 21:36:38.0141 (UTC) FILETIME=[A131BAD0:01C601BF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Benjamin> But won't the driver call pci_enable/disable_msi() in
    Benjamin> those cases ? If not, it's easy enough to add (explicit
    Benjamin> disable rather than not-enabled).

    Benjamin> I'm mostly concerned about "dumb" drivers that don't
    Benjamin> know about MSI at all...

Well, a driver for a chip that does MSI may be "dumb" in that sense.
For example, tg3 only got MSI support in April '05 or so.

Although looking at tg3.c, it seems that nothing special is required
to disable MSI -- there is a special chip register bit to set to
enable MSI mode, but it doesn't seem necessary to clear the bit to
disable MSI.

The case I'm worried about is a chip where something special has to be
done to get out of MSI mode, but the driver is totally dumb and just
does request_irq() on its legacy interrupt.  The core PCI code doesn't
have the chip-specific knowledge to fully turn off MSI.

But I don't know of a real device that falls into that category, so
your scheme is probably OK.

 - R.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751091AbVLOVSL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751091AbVLOVSL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 16:18:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751096AbVLOVSL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 16:18:11 -0500
Received: from sj-iport-2-in.cisco.com ([171.71.176.71]:43057 "EHLO
	sj-iport-2.cisco.com") by vger.kernel.org with ESMTP
	id S1751091AbVLOVSK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 16:18:10 -0500
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-pci <linux-pci@atrey.karlin.mff.cuni.cz>
Subject: Re: MSI and driver APIs
X-Message-Flag: Warning: May contain useful information
References: <1134617893.16880.17.camel@gaston> <adamzj2nk76.fsf@cisco.com>
	<1134680882.16880.37.camel@gaston>
From: Roland Dreier <rdreier@cisco.com>
Date: Thu, 15 Dec 2005 13:18:04 -0800
In-Reply-To: <1134680882.16880.37.camel@gaston> (Benjamin Herrenschmidt's
 message of "Fri, 16 Dec 2005 08:08:02 +1100")
Message-ID: <adaek4enjoz.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.17 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-OriginalArrivalTime: 15 Dec 2005 21:18:05.0391 (UTC) FILETIME=[09F18DF0:01C601BD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Benjamin> You can have multiple MSIs too (they just have to be
    Benjamin> contiguous in numbers and aligned on the nearest power
    Benjamin> of 2).

Good point.  I just got too used to the x86-ism of the current MSI
code, which can't handle allocating contiguous vectors.

    Benjamin> I'm tempted to leave them enabled and only disable them
    Benjamin> when request_irq() is done on the legacy INTx... Does
    Benjamin> anybody see a problem with this approach ?

You might run into trouble on hardware (think tg3 or its ilk again)
where you might have to do something beyond disabling MSI in the PCI
header to switch the chip out of MSI mode.

 - R.

Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751182AbWFFAeQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751182AbWFFAeQ (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 20:34:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751184AbWFFAeQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 20:34:16 -0400
Received: from gate.crashing.org ([63.228.1.57]:35809 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751182AbWFFAeP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 20:34:15 -0400
Subject: Re: [PATCH 9/9] PCI PM: generic suspend/resume fixes
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Adam Belay <abelay@novell.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Greg KH <greg@kroah.com>,
        Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
        linux-pci@atrey.karlin.mff.cuni.cz
In-Reply-To: <1149529685.7831.177.camel@localhost.localdomain>
References: <1149497178.7831.163.camel@localhost.localdomain>
	 <1149502891.30554.1.camel@localhost.localdomain>
	 <1149529685.7831.177.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 06 Jun 2006 10:33:59 +1000
Message-Id: <1149554040.559.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-06-05 at 13:48 -0400, Adam Belay wrote:

> I've only tested this on a few x86 boxes.  However, I think it's moving
> in the right direction for correctly suspending devices.  It's worth
> mentioning that the PCI PM specification requires the device to be
> disabled before entering D3 (something that we fail to do before this
> patchset), and the vast majority of devices would end up in this state
> if we were using pci_set_power_state() in this function.

That should be done only for D3 though. Not other states.

> Unfortunately, far too many drivers still depend on this generic suspend
> call, when they should all implement their own suspend function.  I
> would except pci_disable_device() issues to the the exception, and as
> such, device drivers should provide a ->suspend function that doesn't
> call pci_disable_device() when they know their hardware can be
> problematic.
> 
> With that in mind, any thoughts on giving this a little time in -mm and
> seeing how it fares?  If any problems come up, we could revert to a more
> conservative approach.

Problem is that you may end up disabling something like ... the ACPI
controller, and that will cause VERY BAD things with your BIOS when
actually trying to enter S3 or S4

Ben.



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264542AbTEPS1O (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 14:27:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264544AbTEPS1O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 14:27:14 -0400
Received: from ida.rowland.org ([192.131.102.52]:37636 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S264542AbTEPS1M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 14:27:12 -0400
Date: Fri, 16 May 2003 14:40:04 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Paul Fulghum <paulkf@microgate.com>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       <johannes@erdfelt.com>,
       USB development list <linux-usb-devel@lists.sourceforge.net>
Subject: Re: Test Patch: 2.5.69 Interrupt Latency
In-Reply-To: <1053107295.2606.21.camel@toshiba>
Message-ID: <Pine.LNX.4.44L0.0305161422280.1310-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 16 May 2003, Paul Fulghum wrote:

> Agreed, when the controller sets the FGR bit, it
> starts sending the resume signal to all ports,
> waking attached devices, which will send back
> valid resume signals to the host controller, which
> will complete the wakeup. Which takes us back
> to the thrashing problem.
> 
> For the case where ports are not hardwired to OC,
> we should account for the possibility that the
> OC condition may clear (bad cable replaced, etc).
> 
> So if we allow suspend, and then ignore resumes
> on an OC (temporary condition) port, then that port will not
> be able to cause a valid resume when the OC
> condition is cleared. (per port RD is already set)
> 
> So always allowing suspend, and selectively doing the
> wakeup will cause:
> 1. thrashing for case of one port OC,
> other port OK with attached device.
> 2. prevent port with OC from doing resume
> after clearing OC condition.

I disagree with 1.  When one port has an attached device there won't be
any problem because suspends will never occur (since one port is active).

But I agree with 2.  So yes, it's probably safer to do a conditional 
suspend rather than a conditional resume.

> For the case of all ports hardwired OC, this
> will work because you suspend the whole controller
> and never get a valid resume.

Not suspending isn't really a big deal.  After all, we would suspend only 
when no devices are plugged in anyway.  Is the PIIX4 chipset used in 
laptops, where the power saving might be important?  That's the only 
reason I can think of for wanting to suspend whenever possible.

Alan Stern



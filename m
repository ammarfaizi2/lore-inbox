Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964812AbVI0FPA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964812AbVI0FPA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 01:15:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964813AbVI0FPA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 01:15:00 -0400
Received: from colo.lackof.org ([198.49.126.79]:61389 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S964812AbVI0FPA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 01:15:00 -0400
Date: Mon, 26 Sep 2005 23:21:28 -0600
From: Grant Grundler <grundler@parisc-linux.org>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: Grant Grundler <grundler@parisc-linux.org>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, greg@kroah.com, linux-pci@atrey.karlin.mff.cuni.cz,
       ak@suse.de
Subject: Re: [PATCH] MSI interrupts: disallow when no LAPIC/IOAPIC support
Message-ID: <20050927052128.GB21108@colo.lackof.org>
References: <20050926201156.7b9ef031.rdunlap@xenotime.net> <20050927044840.GA21108@colo.lackof.org> <20050926215245.7a1be7fa.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050926215245.7a1be7fa.rdunlap@xenotime.net>
X-Home-Page: http://www.parisc-linux.org/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2005 at 09:52:45PM -0700, Randy.Dunlap wrote:
> "nosmp" (currently) means 1 CPU and no LAPICs/no IOAPICs.

ok - ie we ignore HW that may be present.

In a way, this makes sense since LAPIC was used for
IRQ "load balancing" - ie IRQs could get redirected
to another "less busy" CPU.  IIRC, discussions about
"XPR" should explain how that works.

> It doesn't have to be that way, but yes, I suspect that it's
> mostly historical, plus a method of getting to a lowest common
> hardware boot sequence, which is sometimes nice for debugging
> or installation.
> 
> Nevertheless, there is a problem here.  What do you suggest
> to solve it?  Just making PCI_MSI depend on Local APIC support,
> or something else?

Yeah, my preference would be PCI_MSI only depend on Local APIC.
(Note that having a Local APIC implies having an IO APIC as well
- but MSI should completely ignore it.)

But I don't know enough x86 history to know if thats feasible
or not. And I'm not blessed with the time to unravel the x86
APIC support - if the dependencies are necessary, so be it.

> [Kernel is assigning MSI interrupts, but then they are "lost."
> Using "irqpoll" will find them, but that's a performance penalty.]

Interesting. I'm suprised an MSI can get "lost".
It implies MSI code is allocating a CPU vector but the vector is
not getting enabled/unmasked or the Local APIC is ignoring it.

Yeah, we don't want to be using irqpoll for this - entirely
defeats the purpose of MSI.

thanks,
grant

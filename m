Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262576AbUJ1A0T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262576AbUJ1A0T (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 20:26:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262557AbUJ1AYl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 20:24:41 -0400
Received: from cantor.suse.de ([195.135.220.2]:20699 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262691AbUJ1ASC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 20:18:02 -0400
Date: Thu, 28 Oct 2004 02:17:54 +0200
From: Andi Kleen <ak@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@tux.tmfweb.nl, Paulo Marques <pmarques@grupopie.com>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       Andi Kleen <ak@suse.de>, akpm@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Add p4-clockmod driver in x86-64
Message-ID: <20041028001754.GG23595@wotan.suse.de>
References: <88056F38E9E48644A0F562A38C64FB600333A69D@scsmsx403.amr.corp.intel.com> <417FB7BA.9050005@grupopie.com> <20041027213807.GA9334@nospam.com> <1098913837.7783.8.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1098913837.7783.8.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27, 2004 at 10:50:38PM +0100, Alan Cox wrote:
> On Mer, 2004-10-27 at 22:38, Rutger Nijlunsing wrote:
> > So you've got the _disadvantages_ of a slow clock (programs run
> > slower), and not the _advantages_ (power consumption is same as idle
> > CPU and not lower, temperature is same as idle CPU and not lower).
> > 
> > But why does the P4 have such a mode? It uses this mode during thermal
> > throttling to get to the 'idle' temperature.
> 
> It isn't obvious how you software idle a PIV - "hlt" at least does not
> seem to do that.

It depends on the BIOS. hlt can do it with the right SMM code.
Other than that you need ACPI.

The main reason that BIOS don't use the more advanced power saving
modi is that they tend to have much longer latencies, and hlt cannot
know what interrupt latency the OS wants. A lot of BIOS seem 
to go for short latency for compatibility.

That is why using the ACPI processor driver is a much better
choice, because it actually tries to figure this out and use the
correct sleep mode for the load.  It doesn't do it very well on Linux yet
though because of lacking infrastructure in the main kernel
(e.g. it needs better accounting for interrupts) , but I hope 
that can be eventually improved.

<insert standard rant about the the 1ms timer tick that also
doesn't help at all for this>

-Andi

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263387AbTJQKbk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 06:31:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263389AbTJQKbk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 06:31:40 -0400
Received: from pentafluge.infradead.org ([213.86.99.235]:47318 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S263387AbTJQKbi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 06:31:38 -0400
Subject: Re: [Linux-fbdev-devel] Re: FBDEV 2.6.0-test7 updates.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Otto Solares <solca@guug.org>
Cc: "Carlo E. Prelz" <fluido@fluido.as>,
       James Simmons <jsimmons@infradead.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20031016210643.GD19795@guug.org>
References: <20031015162056.018737f1.akpm@osdl.org>
	 <Pine.LNX.4.44.0310160022210.13660-100000@phoenix.infradead.org>
	 <20031016091918.GA1002@casa.fluido.as> <1066298431.1407.119.camel@gaston>
	 <20031016210643.GD19795@guug.org>
Content-Type: text/plain
Message-Id: <1066386638.4777.214.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 17 Oct 2003 12:30:39 +0200
Content-Transfer-Encoding: 7bit
X-SA-Exim-Mail-From: benh@kernel.crashing.org
X-SA-Exim-Scanned: No; SAEximRunCond expanded to false
X-Pentafluge-Mail-From: <benh@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> - Could I2C be ported to kernel I2C api and separated?, so it use would not
> require the fbdev module loaded.

I don't plan to do that. The i2c _IS_ using the kernel i2c APIs, but
the proper DDC probing requires various other register tweaking and
I just don't want to have a separate driver tapping the radeon registers
at this point.

I'm really very much in favor of having the fbdev be the kernel API
to display devices in general, including for things like EDID retreival.

> - PCI IDs list should be in pci_ids.h as every other drivers, reality is
> that adding new IDs to pci_ids.h is not hard so your driver will not be the
> exception to the rule.

Looks like you didn't have to deal with all of the merge conflicts
that happen systematically when you have to maintain a kernel tree and 
have changes to pci_ids :)

pci_ids.h is hell to manage. Really. And it makes it a lot simpler for now,
at least until the driver is considered as final enough to be merged upstream,
to just keep a copy of the XFree IDs in there. I may do differently once the
driver is complete enough, but not at this point. And no, I'm far from beeing
the only one to decide not to use pci_ids.h :) I try to use it most of the time,
but in the case of radeonfb, it just makes things too painful for now.

Ben.
 


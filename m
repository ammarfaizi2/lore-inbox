Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269630AbUJLL02@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269630AbUJLL02 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 07:26:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269632AbUJLL02
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 07:26:28 -0400
Received: from gate.crashing.org ([63.228.1.57]:39623 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S269630AbUJLL0Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 07:26:24 -0400
Subject: Re: Totally broken PCI PM calls
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: David Brownell <david-b@pacbell.net>, Paul Mackerras <paulus@samba.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>
In-Reply-To: <20041012102723.B31597@flint.arm.linux.org.uk>
References: <1097455528.25489.9.camel@gaston>
	 <Pine.LNX.4.58.0410102102140.3897@ppc970.osdl.org>
	 <16746.2820.352047.970214@cargo.ozlabs.ibm.com>
	 <200410110947.38730.david-b@pacbell.net> <1097533687.13642.30.camel@gaston>
	 <20041012102723.B31597@flint.arm.linux.org.uk>
Content-Type: text/plain
Message-Id: <1097580294.26641.1.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 12 Oct 2004 21:24:54 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> What about the case where you're walking the tree for a resume, and
> you've hotplugged a whole tree of devices which have a similar bus
> setup to the original.
> 
> Yes, I'm thinking of the case of Cardbus with hotpluggable PCI buses.
> If we detect that the "bridge" at the top of the chain has changed,
> we _really_ don't want to try to restore the state of the child
> devices - they may have the same bus IDs, but they could well object
> to being inappropriately setup.
> 
> Sure, we can say "don't do that then" but I suspect the exact same
> problem is present with USB, and USB is far more liable to have this
> type of abuse than PCI.

Most of the time, this scenario works fine (provided you have paulus
recent patch tho), since the "host controller" of whatever tree of
devices will only start registering it's child after beeing itself woken
up, stuffs will end up at the right place... In fact, the only real race
we have, after paulus patch is applied, is some tiny window when adding
devices suring the suspend process. It's so tiny that we can probably
find a way to just error out the insertion in this case tho... 

Ben.




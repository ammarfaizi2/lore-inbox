Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263069AbTJaIAi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Oct 2003 03:00:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263077AbTJaIAi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Oct 2003 03:00:38 -0500
Received: from pentafluge.infradead.org ([213.86.99.235]:59322 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S263069AbTJaIAh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Oct 2003 03:00:37 -0500
Subject: Re: RadeonFB [Re: 2.4.23pre8 - ACPI Kernel Panic on boot]
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Kristofer T. Karas" <ktk@enterprise.bidmc.harvard.edu>
Cc: Kronos <kronos@kronoz.cjb.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Javier Villavicencio <jvillavicencio@arnet.com.ar>
In-Reply-To: <1067491238.1735.4.camel@ktkhome>
References: <20031029210321.GA11437@dreamland.darkstar.lan>
	 <1067491238.1735.4.camel@ktkhome>
Content-Type: text/plain
Message-Id: <1067587196.715.1.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 31 Oct 2003 18:59:57 +1100
Content-Transfer-Encoding: 7bit
X-SA-Exim-Mail-From: benh@kernel.crashing.org
X-SA-Exim-Scanned: No; SAEximRunCond expanded to false
X-Pentafluge-Mail-From: <benh@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Yes, I can reproduce without the tainting kernel module (fglrx.o). 
> Debugging a bit, the corruption shows up when using ATI's "fglr" device
> driver in XF86Config.  If I switch to using the unaccelerated "Radeon"
> driver provided by XFree, then the screen remains readable upon return
> from X.  Thus, the kernel module is OK, the ATI proprietary glx and dri
> modules are OK, it's just the driver.
> 
> However, I still think this belongs as a kernel issue, because it
> appears to be a failing of the radeonfb.o module to properly set the
> radeon registers.  Remember that version 0.1.4 of the driver does not
> have this issue; it works just fine with the ATI fglr X driver.

Ok, first thing: XFree "radeon" _is_ accelerated, though it doesn't
do 3D on recent cards

Then, the problem you are having is well known and I don't have a
simple workaround at hand other than re-initing the engine on each
console switch, which I would have very much liked to avoid... maybe
I can add an fbdev hook to the switch from KD_GRAPHICS to KD_TEXT
which is what we really want to cleanup the engine.

Can you verify that running fbset -accel 0 then back 1 cures the
problem for you ?

Ben.
 


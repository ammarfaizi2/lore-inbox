Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261802AbUB0MCl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 07:02:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261798AbUB0MCl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 07:02:41 -0500
Received: from gate.crashing.org ([63.228.1.57]:44474 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261802AbUB0MCj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 07:02:39 -0500
Subject: [PATCHES] ppc64 iommu rewrite & G5 support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1077882827.22213.340.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 27 Feb 2004 22:53:48 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

In the following few emails are the bits of the long awaited ppc64
iommu rewrite and DART support for the PowerMac G5. The DART code
is still marked EXPERIMENTAL (though I haven't had any problem with
it here). 

I also implemented some basic virtual merging on top of the original
rewrite that is also marked EXPERIMENTAL and not enabled by default,
though it appears to work fine, because some drivers may still have
issues with it. It can still be enabled with a kernel command line
option despite beeing off in the .config (iommu=vmerge) or disabled
when the config .option is set (iommu=novmerge).

I will make it the default once we have moved the boundary limit
information down to struct device and fixed our pci_map_sg()
implementation to use that information, as it was discussed separately.

Many Kudos to Olof Johansson who did the bulk of the work, wiping out
the old ppc64 TCE mess to replace it with something that allowed people
like me to actually do further hacking on it while keeping the
noise/swearing level in the office acceptable (Rusty, in the cubicle
next to mine, will thank you Olof !) He is also responsible for getting
the crap out of Apple's DART implementation & HW bugs and producing a
working driver for it.

My contribution is limited to the vmerge stuff, further cleanups, some
fixes here or there, and proper IO hole accounting.

Have fun and backup your data !

Ben.






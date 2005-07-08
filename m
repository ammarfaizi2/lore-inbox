Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262804AbVGHT1r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262804AbVGHT1r (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 15:27:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262787AbVGHTZN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 15:25:13 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:40663
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S262788AbVGHTXr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 15:23:47 -0400
Date: Fri, 08 Jul 2005 12:23:34 -0700 (PDT)
Message-Id: <20050708.122334.66180889.davem@davemloft.net>
To: ak@suse.de
Cc: Adnan.Khaleel@newisys.com, linux-kernel@vger.kernel.org
Subject: Re: Instruction Tracing for Linux
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <p738y0hp0zc.fsf@verdi.suse.de>
References: <DC392CA07E5A5746837A411B4CA2B713010D7790@sekhmet.ad.newisys.com.suse.lists.linux.kernel>
	<p738y0hp0zc.fsf@verdi.suse.de>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@suse.de>
Date: 08 Jul 2005 21:11:03 +0200

> While some CPUs (like Intel P4) have ways to do such hardware
> tracing I know of no free tool that uses it. There are some user
> space tools to collect at user space, but they probably won't help you.

FWIW, even without explicit tracing support in the CPU it
is possible to get these kinds of traces nontheless.

One great example is how they did this on Sparc sun4d machines
at Sun using SKY which was written by Gordon Irlam.  You can
read about it at:

     http://www.base.com/gordoni/sky.html

Basically, the "simulator" would take advantage of Sparc's
delay slot branching to explicitly execute one instruction
from the kernel's code stream at a time.

So it would branch to the kernel's current PC, and in the delay
slot branch back into the simulator.

The only special case is that it needs two temporary registers, global
registers %g2 and %g3, to pull off this trick.  So if the instruction
needed to actually use either register %g2 or %g3, it was emulated in
software instead of actually being executed.

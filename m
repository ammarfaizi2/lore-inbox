Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262059AbTIZLkc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 07:40:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262060AbTIZLkc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 07:40:32 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:38882 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S262059AbTIZLka (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 07:40:30 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16244.9644.70305.752172@gargle.gargle.HOWL>
Date: Fri, 26 Sep 2003 13:40:28 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Chris Sykes <chris@spackhandychoptubes.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel panic on 2.4.22 (no TSC) when compiled for i486
In-Reply-To: <20030926084848.GA16991@spackhandychoptubes.co.uk>
References: <20030926084848.GA16991@spackhandychoptubes.co.uk>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Sykes writes:
 > I'm getting a kernel panic from my 2.4.22 kernel when compiled for
 > i486 (see attached .config).
 > 
 > "Kernel panic: Kernel compiled for Pentium+, requires TSC feature!"
 > 
 > The CPU is a Cyrix Cx486DX2 100MHz part.  I tried booting with notsc
 > but I get the message:
 > "notsc: Kernel compiled with CONFIG_X86_TSC, cannot disable TSC."
 > 
 > The kernel will work fine when recompiled for i386.
 > 
 > Does a real 486 have a TSC, or is this a config bug?
...
 > CONFIG_M486=y
...
 > CONFIG_X86_TSC=y

I've reproduced this problem. It's a bug in the configuration
system which triggers when you change an option which has
derived options.

In this case, when first configuring for a CPU with TSC the
derived CONFIG_X86_TSC option is added. Then when reconfiguring
for a TSC-less CPU (e.g., 486) the derived option stays because
it derived from something that _was_ defined at the start of the
config run.

The workaround is to do an additional 'make oldconfig', after
which the derived option will be gone.

/Mikael

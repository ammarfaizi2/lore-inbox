Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276057AbRJGCyt>; Sat, 6 Oct 2001 22:54:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276058AbRJGCyk>; Sat, 6 Oct 2001 22:54:40 -0400
Received: from sushi.toad.net ([162.33.130.105]:61405 "EHLO sushi.toad.net")
	by vger.kernel.org with ESMTP id <S276057AbRJGCye>;
	Sat, 6 Oct 2001 22:54:34 -0400
Subject: Re: Linux should not set the "PnP OS" boot flag
From: Thomas Hood <jdthood@mail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.14 (Preview Release)
Date: 06 Oct 2001 22:54:37 -0400
Message-Id: <1002423279.978.28.camel@thanatos>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ebiederman@uswest.net wrote:
> Hmm.  Linux isn't quite a "PnP OS".  I agree that in the short
> term we should not set the boot flag.  But we should also investigate
> what needs to added so that setpnp does not need to be called.

This change has to be permanent.  Linux should never automatically
set the boot flag, no matter how PnP-competent we make it.
The reason is that setting the flag affects what the BIOS will
do on the _subsequent_ boot.  But Linux can't possibly know 
which operating system will be booted _next time_.  This is
something that has to be left up to the user to control.

Assuming I've made that point, I'll go on to say that I do not
know of any reason why the PnP-OS flag should _ever_ be set.
SFAIK all that setting the flag does is stop the PnP BIOS
from configuring devices in the way that it has been told to do
(if we used "setpnp -b" to set the nonvolative configuration).
I don't see why we would ever want to do this.  If the BIOS does
configure the devices, nothing stops us from reconfiguring them
(using "setpnp") once Linux has booted.  The PnP-OS flag is called
a "quick boot" flag, but the time savings involved must be on the
order of milliseconds.  All that we seem to achieve by booting
Linux with disabled devices is to induce certain device drivers
to segfault.

Please let me know if I'm overlooking something.

If I'm right, then bootflag.c should be modified (see my patch)
to remove the bit that sets the flag.  It would be nice,
however, if the flag could be controlled via a /proc entry.

--
Thomas




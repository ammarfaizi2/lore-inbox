Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132592AbRDIBxz>; Sun, 8 Apr 2001 21:53:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132600AbRDIBxp>; Sun, 8 Apr 2001 21:53:45 -0400
Received: from mackman.submm.caltech.edu ([131.215.85.46]:10920 "EHLO
	mackman.net") by vger.kernel.org with ESMTP id <S132592AbRDIBxc>;
	Sun, 8 Apr 2001 21:53:32 -0400
Date: Sun, 8 Apr 2001 18:53:30 -0700 (PDT)
From: Ryan Mack <rmack@mackman.net>
To: <linux-kernel@vger.kernel.org>
Subject: [QUESTIONS] Transision from pcmcia-cs to 2.4 built-in PCMCIA
In-Reply-To: <3AD1084F.A916D361@torque.net>
Message-ID: <Pine.LNX.4.30.0104081846460.16728-100000@mackman.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a 3c595 CardBus card and a Lucent Orinoco card

under pcmcia-cs I used the following drivers:

pcmcia_core, ds, and (I think) cs for low level stuff,
i82365 for the controller,
cb_enabler and 3c595_cb for the 3c595,
and wvlan_cs for the Orinoco

under the kernel pcmcia support, I use:

pcmcia_core and ds for low level stuff,
yenta_socket for the controller,
3c59x (same driver as PCI) for the 3c595,
and hermes and orinoco_cs for the Orinoco

Now after awhile I figured out what new drivers I should start using, but
I have a few things about the change that still confuse me...

First, why have I stopped needing cs and cb_enabler?

Second, why is yenta_socket only compiled if I enable CardBus support in
the kernel?  I'm running an Orinoco card on another machine, and since I
don't think it's CardBus (am I wrong?), I didn't enable CB in the kernel.
The i82365 driver is the only one compiled, but it seems to work fine on
that machine.  Should I enable CardBus support and use yenta_socket
instead?

Third, on the first machine with both cards, neither card works if I use
i82365 instead of yenta_socket, why?  The Orinoco gets Tx timeouts on
every packet, and inserting the 3c595 causes the controller (socket) to
time out waiting for reset and it doesn't recognize the 3c595.

Despite the confusion of changing systems, I must say that the orinoco
driver works much better than wvlan_cs for me, as the two Orinoco cards in
IBSS Ad-Hoc mode would get intermittent Tx timeouts with the wvlan_cs
driver.  It's also nice not to have to rebuild pcmcia-cs when I upgrade my
kernel anymore.  Keep up the good work!

Ryan


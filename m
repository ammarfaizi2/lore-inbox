Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265768AbTIJVWt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 17:22:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265767AbTIJVWt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 17:22:49 -0400
Received: from mta1.cl.cam.ac.uk ([128.232.0.15]:32488 "EHLO
	wisbech.cl.cam.ac.uk") by vger.kernel.org with ESMTP
	id S265768AbTIJVWl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 17:22:41 -0400
X-Mailer: exmh version 2.5+CL 07/13/2001 with nmh-1.0.4
From: Jon Fairbairn <Jon.Fairbairn@cl.cam.ac.uk>
X-emacs-edited: yes
To: linux-kernel@vger.kernel.org
Subject: Omnibook PCMCIA slots unusable after suspend.
X-Face: H#SM:U1U-/6#NN83s6?Die557~]Dfifz~-|V:wSKGL6T-|!qk{U4/M7+k5Py!-{q=2Q/%0@
        E29yc_kQC&^
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Date: Wed, 10 Sep 2003 22:22:32 +0100
Message-ID: <15685.1063228952@cl.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[I'm not subscribed, so please Cc me in any replies]

In short: I'm using an HP Ombibook 800CT, have started using
a Carbus PCMCIA network card and am losing the card after
suspends.


I've tried searching lkml for similar things but didn't find
anything that seemed close enough, so here's a little more
detail (though I don't want to add too much until I know you
want to hear about it).

"modprobe yenta_socket" normally logs:

Sep  4 21:39:10 graffito kernel: Linux Kernel Card Services 3.1.22
Sep  4 21:39:10 graffito kernel:   options:  [pci] [cardbus] [pm]
Sep  4 21:39:10 graffito kernel: PCI: Found IRQ 9 for device 00:04.0
Sep  4 21:39:10 graffito kernel: PCI: Found IRQ 7 for device 00:04.1
Sep  4 21:39:10 graffito kernel: Yenta IRQ list 0448, PCI irq9
Sep  4 21:39:10 graffito kernel: Socket status: 30000020
Sep  4 21:39:10 graffito kernel: Yenta IRQ list 0448, PCI irq7
Sep  4 21:39:10 graffito kernel: Socket status: 30000006

but after "apm --suspend" I get the same except:

Sep  6 23:23:55 graffito kernel: Socket status: 66012d18
...
Sep  6 23:23:55 graffito kernel: Socket status: 2a035c8a


The effect of this is that it can't see anything in the
socket, so I can't get it to load the driver for the PCMCIA
card.  It only happens if the machine has been on battery
power during the suspend. It doesn't happen if the socket is
set to PCIC mode in the BIOS, though in that case I can't
use the card anyway. It happens whether or not the card is
present, and whether or not cardmgr is running, and it
happens in 2.4.21, 2.4.22 and 2.6.0-test4.

Rebooting without powering off clears the condition, but
nothing else I've tried (cardctl eject &c, loading and
unloading modules round the suspend, using setpci to restore
the registers of the bridge, passing do_apm=0 to
pcmcia_core) makes any difference.

The card in question is a netgear FA511, but I don't think
that's relevant as the problem happens even if I don't plug
it in until after the suspend, and so long as yenta_socket
reports a sensible status it works fine (with the tulip
driver). 

Please let me know if you need more information.


Thanks,

   Jón

-- 
Jón Fairbairn



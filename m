Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312476AbSDCXju>; Wed, 3 Apr 2002 18:39:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312488AbSDCXjk>; Wed, 3 Apr 2002 18:39:40 -0500
Received: from ecs.fullerton.edu ([137.151.27.1]:9399 "EHLO
	titan.ecs.fullerton.edu") by vger.kernel.org with ESMTP
	id <S312476AbSDCXje>; Wed, 3 Apr 2002 18:39:34 -0500
Date: Wed, 3 Apr 2002 15:39:27 -0800 (PST)
From: Denny Gudea <ekay@ecs.fullerton.edu>
To: <andrewm@uow.edu.au>, <netdev@oss.sgi.com>, <linux-kernel@vger.kernel.org>
Subject: 3c59x.c - kernel message explosion (fwd)
Message-ID: <Pine.GSO.4.33.0204031538340.19587-100000@titan.ecs.fullerton.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

id like to thank you for maintaining this driver..

i have a 3com 3c905 and im using 3c59x.c driver to run it in my linux
machine. it is connected to a hub on a network with 7 nodes. it seems like
one of the hosts on my network has a duplex problem (as is described in
vortex.txt). the problem i'm having is that the driver does a lot of
kernel messages for this error even though my debug is set to the default.

i've looked at the code and the problem seems to be due to a small typo:
this code segment begins at line 1826:
------------------------------------------------
       if (status & TxComplete) {                      /* Really "TxError" for us. */
                tx_status = inb(ioaddr + TxStatus);
                /* Presumably a tx-timeout. We must merely re-enable. */
                if (vortex_debug > 2
                        || (tx_status != 0x88 && vortex_debug > 0)) {
                        printk(KERN_ERR "%s: Transmit error, Tx status register %2.2x.\n",
                                   dev->name, tx_status);
                        if (tx_status == 0x82) {
                                printk(KERN_ERR "Probably a duplex mismatch.  See "
                                                "Documentation/networking/vortex.txt\n");
                        }
                        dump_tx_ring(dev);
-------------------------------------------------
i believe the problem resides when it tests for the debug level:

	          if (vortex_debug > 2
                        || (tx_status != 0x88 && vortex_debug > 0)) {

the || operator should be a && because we only want to print the error
message if debug is greater than 2 and the transmit status is not what it
should be.



thanks a lot

denny gudea
ekay@ecs.fullerton.edu



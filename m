Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266081AbRGGJR0>; Sat, 7 Jul 2001 05:17:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266074AbRGGJRQ>; Sat, 7 Jul 2001 05:17:16 -0400
Received: from smtp.mailbox.co.uk ([195.82.125.32]:10123 "EHLO
	smtp.mailbox.net.uk") by vger.kernel.org with ESMTP
	id <S266069AbRGGJRB>; Sat, 7 Jul 2001 05:17:01 -0400
Date: Sat, 7 Jul 2001 10:16:57 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: linux-kernel@vger.kernel.org
Subject: 2.4.6 PCMCIA NET modular build breakage
Message-ID: <20010707101657.C10927@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Seems like its something that appeared between 2.4.5 and 2.4.6.  Anyone
know the correct fix, other than reversing the change?

----- Forwarded message from Nicolas Pitre <nico@cam.org> -----
---------- Forwarded message ----------
Date: Fri, 6 Jul 2001 12:17:54 +0400
From: Oleg Drokin <green@iXcelerator.com>
To: nico@CAM.ORG
Subject: 2.4.6-rmk1-np1 breakage

Hello!

   these sevaral bits from latest patch do not allow kernel to build
   when PCMCIA netcard is selected, but all if the cards are selected as modules

diff -uNr linux-2.4.5-rmk7-np1/drivers/net/pcmcia/Config.in linux-2.4.6-rmk1-np1/drivers/net/pcmcia/Config.in
--- linux-2.4.5-rmk7-np1/drivers/net/pcmcia/Config.in   Mon May 28 10:21:00 2001
+++ linux-2.4.6-rmk1-np1/drivers/net/pcmcia/Config.in   Wed Jul  4 10:47:46 2001@@ -32,13 +32,4 @@
    fi
 fi

-if [ "$CONFIG_PCMCIA_3C589" = "y" -o "$CONFIG_PCMCIA_3C574" = "y" -o \
-     "$CONFIG_PCMCIA_FMVJ18X" = "y" -o "$CONFIG_PCMCIA_PCNET" = "y" -o \
-     "$CONFIG_PCMCIA_NMCLAN" = "y" -o "$CONFIG_PCMCIA_SMC91C92" = "y" -o \
-     "$CONFIG_PCMCIA_XIRC2PS" = "y" -o "$CONFIG_PCMCIA_RAYCS" = "y" -o \
-     "$CONFIG_PCMCIA_NETWAVE" = "y" -o "$CONFIG_PCMCIA_WAVELAN" = "y" -o \
-     "$CONFIG_PCMCIA_XIRTULIP" = "y" ]; then
-   define_bool CONFIG_PCMCIA_NETCARD y
-fi

And this bit for top level Makefile

-DRIVERS-$(CONFIG_PCMCIA_NETCARD) += drivers/net/pcmcia/pcmcia_net.o
+DRIVERS-$(CONFIG_NET_PCMCIA) += drivers/net/pcmcia/pcmcia_net.o

Since all net cards are modules, object list for pcmcia_net.o is empty and
kernel can't be linked.

Bye,
    Oleg


----- End forwarded message -----

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html


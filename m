Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130756AbRAFXL3>; Sat, 6 Jan 2001 18:11:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130810AbRAFXLT>; Sat, 6 Jan 2001 18:11:19 -0500
Received: from Isis151.urz.uni-duesseldorf.de ([134.99.138.151]:4868 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S130756AbRAFXLJ>; Sat, 6 Jan 2001 18:11:09 -0500
Date: Sun, 7 Jan 2001 00:11:33 +0100 (CET)
From: Kai Germaschewski <kai@thphy.uni-duesseldorf.de>
To: Jochen Friedrich <jochen@nwe.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.0 link error with modular PCMCIA
In-Reply-To: <Pine.LNX.4.21.0101062058490.1700-100000@melmac.internal.nwe.de>
Message-ID: <Pine.LNX.4.30.0101062347190.13176-100000@vaio>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 6 Jan 2001, Jochen Friedrich wrote:

> Hi,
>
> problem is that CONFIG_PCMCIA_NETCARD=y, although all drivers are
> compiled as modules, so there's no drivers/net/pcmcia/pcmcia_net.o...

This should fix it.

--- drivers/net/Makefile%	Fri Jan  5 15:10:11 2001
+++ drivers/net/Makefile	Sat Jan  6 23:48:28 2001
@@ -26,7 +26,7 @@
   obj-$(CONFIG_ISDN) += slhc.o
 endif

-subdir-$(CONFIG_PCMCIA) += pcmcia
+subdir-$(CONFIG_NET_PCMCIA) += pcmcia
 subdir-$(CONFIG_TULIP) += tulip
 subdir-$(CONFIG_IRDA) += irda
 subdir-$(CONFIG_TR) += tokenring

The problem is that CONFIG_PCMCIA is M, therefore drivers/net/pcmcia is
not entered during "make vmlinux". The patch fixes this and will produce
an (empty) pcmcia_net.o

And, yes, the directory will also be entered when doing "make modules",
because pcmcia is in $(mod-subdirs).

--Kai



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264658AbRFPVM3>; Sat, 16 Jun 2001 17:12:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264661AbRFPVMT>; Sat, 16 Jun 2001 17:12:19 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:59865 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S264658AbRFPVMK>;
	Sat, 16 Jun 2001 17:12:10 -0400
Message-ID: <3B2BCB8C.85792582@mandrakesoft.com>
Date: Sat, 16 Jun 2001 17:11:40 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-pre3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Eric Smith <eric@brouhaha.com>,
        linux-kernel@vger.kernel.org, arjanv@redhat.com, mj@ucw.cz
Subject: [PATCH] Re: 2.4.2 yenta_socket problems on ThinkPad 240
In-Reply-To: <Pine.LNX.4.21.0106161153440.9942-100000@penguin.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------66207676316662F835AEDC44"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------66207676316662F835AEDC44
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Linus Torvalds wrote:
> As far as I can tell, the yenta code should _really_ do something like
> 
>         PCI_PROMARY_BUS:        dev->subordinate->primary
>         PCI_SECONDARY_BUS:      dev->subordinate->secondary
>         PCI_SUBORDINATE_BUS:    dev->subordinate->subordinate
>         PCI_SEC_LATENCY_TIMER:  preferably settable, not just hardcoded to 176

Ah, nice.  That produces numbers on my laptop that look a bit better. 
Patch attached (which conflicts with the previous yenta.c patch).

I left 176 hardcoded for now, pending thinking on the rest of your
message...

-- 
Jeff Garzik      | Andre the Giant has a posse.
Building 1024    |
MandrakeSoft     |
--------------66207676316662F835AEDC44
Content-Type: text/plain; charset=us-ascii;
 name="yenta.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="yenta.patch"

Index: drivers/pcmcia/yenta.c
===================================================================
RCS file: /cvsroot/gkernel/linux_2_4/drivers/pcmcia/yenta.c,v
retrieving revision 1.1.1.25.4.1
diff -u -r1.1.1.25.4.1 yenta.c
--- drivers/pcmcia/yenta.c	2001/06/16 19:21:56	1.1.1.25.4.1
+++ drivers/pcmcia/yenta.c	2001/06/16 21:09:40
@@ -644,9 +644,9 @@
 	config_writeb(socket, PCI_LATENCY_TIMER, 168);
 	config_writel(socket, PCI_PRIMARY_BUS,
 		(176 << 24) |			   /* sec. latency timer */
-		(dev->subordinate->number << 16) | /* subordinate bus */
-		(dev->subordinate->number << 8) |  /* secondary bus */
-		dev->bus->number);		   /* primary bus */
+		(dev->subordinate->subordinate << 16) | /* subordinate bus */
+		(dev->subordinate->secondary << 8) |  /* secondary bus */
+		dev->subordinate->primary);		   /* primary bus */
 
 	/*
 	 * Set up the bridging state:

--------------66207676316662F835AEDC44--


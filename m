Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262947AbTDIJox (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 05:44:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262955AbTDIJox (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 05:44:53 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:4557 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S262947AbTDIJow (for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Apr 2003 05:44:52 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16019.60959.273586.121431@gargle.gargle.HOWL>
Date: Wed, 9 Apr 2003 11:55:43 +0200
From: mikpe@csd.uu.se
To: "Kaj-Michael Lang" <milang@tal.org>
Cc: "Marcelo Tosatti" <marcelo@conectiva.com.br>,
       linuxppc-dev@lists.linuxppc.org, "lkml" <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.21-pre7
In-Reply-To: <00b101c2fdeb$e1aa6e20$56dc10c3@amos>
References: <Pine.LNX.4.53L.0304041815110.32674@freak.distro.conectiva>
	<00b101c2fdeb$e1aa6e20$56dc10c3@amos>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kaj-Michael Lang writes:
 > > So here goes -pre7. Hopefully the last -pre.
 > >
 > Won't compile for my PPC:
 > ---
 >         -o vmlinux
 > drivers/ide/idedriver.o(.text+0x1a544): In function `pmac_outbsync':
 > : undefined reference to `io_flush'
 > drivers/ide/idedriver.o(.text+0x1a544): In function `pmac_outbsync':
 > : relocation truncated to fit: R_PPC_REL24 io_flush

Someone updated pmac.c without testing it: io_flush() doesn't exist
in 2.4.21-pre. Based on the diff from -pre6 to -pre7, I'd say the
following is a reasonable approximation. My PM4400 runs with this
patch right now.

/Mikael

--- linux-2.4.21-pre7/drivers/ide/ppc/pmac.c.~1~	Wed Apr  9 10:33:30 2003
+++ linux-2.4.21-pre7/drivers/ide/ppc/pmac.c	Wed Apr  9 11:37:16 2003
@@ -50,6 +50,8 @@
 #undef IDE_PMAC_DEBUG
 #define DMA_WAIT_TIMEOUT	500
 
+#define io_flush(x) (void)(x)
+
 typedef struct pmac_ide_hwif {
 	ide_ioreg_t			regbase;
 	unsigned long			mapbase;

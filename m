Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261386AbSJYMtl>; Fri, 25 Oct 2002 08:49:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261388AbSJYMtl>; Fri, 25 Oct 2002 08:49:41 -0400
Received: from fiberbit.xs4all.nl ([213.84.224.214]:18819 "EHLO localhost")
	by vger.kernel.org with ESMTP id <S261386AbSJYMtk>;
	Fri, 25 Oct 2002 08:49:40 -0400
Date: Fri, 25 Oct 2002 14:55:14 +0200
From: Marco Roeland <marco.roeland@xs4all.nl>
To: linux-kernel@vger.kernel.org
Cc: Alan Cox <alan@redhat.com>
Subject: Re: Linux 2.5.44-ac3
Message-ID: <20021025125514.GA30278@localhost>
References: <200210251019.g9PAJ8V14406@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <200210251019.g9PAJ8V14406@devserv.devel.redhat.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Linux 2.5.44-ac2
> o	Rip out lots of the left over pcibios_ stuff	(Greg Kroah-Hartmann)

Since -ac2 there's a pcibios_read_config_dword left in drivers/pcmcia/cist.c
preventing (CardBus) PCMCIA to compile.

The following makes it compile again, whether it _works_ I've absolutely no
idea, lacking amongst others any kernel knowledge or even a cardbus card.
Compiles for me (TM) ;-)

# This is a GNU diff generated patch for the following project:
# Project Name: Linux kernel tree
# -------------------------------------------------------------
 drivers/pcmcia/cistpl.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)
# -------------------------------------------------------------
#
--- linux-2.5.44-ac3/drivers/pcmcia/cistpl.c	Tue Oct  8 14:34:46 2002
+++ linux-2.5.44-ac3-fix/drivers/pcmcia/cistpl.c	Fri Oct 25 14:24:07 2002
@@ -429,7 +429,7 @@
 #ifdef CONFIG_CARDBUS
     if (s->state & SOCKET_CARDBUS) {
 	u_int ptr;
-	pcibios_read_config_dword(s->cap.cb_dev->subordinate->number, 0, 0x28, &ptr);
+	pci_read_config_dword(s->cap.cb_dev, 0x28, &ptr);
 	tuple->CISOffset = ptr & ~7;
 	SPACE(tuple->Flags) = (ptr & 7);
     } else

-- 
Marco Roeland

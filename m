Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317251AbSG2Nz2>; Mon, 29 Jul 2002 09:55:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317253AbSG2Nz2>; Mon, 29 Jul 2002 09:55:28 -0400
Received: from daimi.au.dk ([130.225.16.1]:24096 "EHLO daimi.au.dk")
	by vger.kernel.org with ESMTP id <S317251AbSG2Nz1>;
	Mon, 29 Jul 2002 09:55:27 -0400
Message-ID: <3D454A03.363B1BA4@daimi.au.dk>
Date: Mon, 29 Jul 2002 15:58:27 +0200
From: Kasper Dupont <kasperd@daimi.au.dk>
Organization: daimi.au.dk
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.9-31smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org, Andre Hedrick <andre@linux-ide.org>
Subject: Re: Linux 2.4.19-rc1-ac5
References: <200207152148.g6FLm7Q24750@devserv.devel.redhat.com>
		<3D340775.7F7AAFB9@daimi.au.dk> <3D35A554.5E7BBF59@daimi.au.dk> 
		<3D4478DA.53CF8999@daimi.au.dk> <1027944055.842.29.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> On Mon, 2002-07-29 at 00:06, Kasper Dupont wrote:
> roc;
> > #ifdef CONFIG_IDEDMA_AUTO
> >                 if (!noautodma)
> >                         hwif->autodma = 1;
> > #endif /* CONFIG_IDEDMA_AUTO */
> >         }
> > #endif /* CONFIG_BLK_DEV_IDEDMA */
> >
> > CONFIG_IDEDMA_AUTO will always be turned off by
> > make *config, but if I enable this option by
> > changing .config with a texteditor DMA actually
> > works.
> >
> 
> I'll take a look. That looks like an escaped piece of history

Hmm, I don't see where the historic part of this is.
It looks like it is a new option, but there is just
no way to enable it. Before the change the code would
work as if the option was enabled.

FYI I'm currently using this workaround:

diff -Nur linux.old/drivers/ide/alim15x3.c linux.new/drivers/ide/alim15x3.c
--- linux.old/drivers/ide/alim15x3.c	Mon Jul 29 02:56:13 2002
+++ linux.new/drivers/ide/alim15x3.c	Mon Jul 29 02:57:07 2002
@@ -34,6 +34,9 @@
 #include <linux/stat.h>
 #include <linux/proc_fs.h>
 
+/* For some reason this is needed and cannot be enabled in .config */
+#define CONFIG_IDEDMA_AUTO
+
 static int ali_get_info(char *buffer, char **addr, off_t offset, int count);
 extern int (*ali_display_info)(char *, char **, off_t, int);  /* ide-proc.c */
 static struct pci_dev *bmide_dev;

-- 
Kasper Dupont -- der bruger for meget tid på usenet.
For sending spam use mailto:razrep@daimi.au.dk
or mailto:mcxumhvenwblvtl@skrammel.yaboo.dk

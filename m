Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317444AbSG1XCs>; Sun, 28 Jul 2002 19:02:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317458AbSG1XCr>; Sun, 28 Jul 2002 19:02:47 -0400
Received: from daimi.au.dk ([130.225.16.1]:13496 "EHLO daimi.au.dk")
	by vger.kernel.org with ESMTP id <S317444AbSG1XCr>;
	Sun, 28 Jul 2002 19:02:47 -0400
Message-ID: <3D4478DA.53CF8999@daimi.au.dk>
Date: Mon, 29 Jul 2002 01:06:02 +0200
From: Kasper Dupont <kasperd@daimi.au.dk>
Organization: daimi.au.dk
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.9-31smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Andre Hedrick <andre@linux-ide.org>
Subject: Re: Linux 2.4.19-rc1-ac5
References: <200207152148.g6FLm7Q24750@devserv.devel.redhat.com> <3D340775.7F7AAFB9@daimi.au.dk> <3D35A554.5E7BBF59@daimi.au.dk>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After many hours of trial and error I came to the
conclusion, that the problem must be in these lines
in the file drivers/ide/alim15x3.c

#ifdef CONFIG_BLK_DEV_IDEDMA
        if (m5229_revision >= 0x20) {
                /*
                 * M1543C or newer for DMAing
                 */
                hwif->dmaproc = &ali15x3_dmaproc;
#ifdef CONFIG_IDEDMA_AUTO
                if (!noautodma)
                        hwif->autodma = 1;
#endif /* CONFIG_IDEDMA_AUTO */
        }
#endif /* CONFIG_BLK_DEV_IDEDMA */

CONFIG_IDEDMA_AUTO will always be turned off by
make *config, but if I enable this option by
changing .config with a texteditor DMA actually
works.

This makes me ask the following questions?

1) Why can't CONFIG_IDEDMA_AUTO be enabled from
   make *config?

2) What would it take to fix that?

3) How come DMA works fine with autodma=1, but
   hdparm -d1 /dev/hda fails?

-- 
Kasper Dupont -- der bruger for meget tid på usenet.
For sending spam use mailto:razrep@daimi.au.dk
or mailto:mcxumhvenwblvtl@skrammel.yaboo.dk

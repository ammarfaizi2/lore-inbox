Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315627AbSGVDZ2>; Sun, 21 Jul 2002 23:25:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315856AbSGVDZ2>; Sun, 21 Jul 2002 23:25:28 -0400
Received: from maillog.promise.com.tw ([210.244.60.166]:12295 "EHLO
	maillog.promise.com.tw") by vger.kernel.org with ESMTP
	id <S315627AbSGVDZ1>; Sun, 21 Jul 2002 23:25:27 -0400
Message-ID: <01ee01c2312e$22976900$47cba8c0@promise.com.tw>
From: "support" <support@promise.com.tw>
To: <romieu@cogenit.fr>, <giro@hades.udg.es>
Cc: "Hank" <hanky@promise.com.tw>, <linux-kernel@vger.kernel.org>,
       <marcelo@conectiva.com.br>, <alan@lxorguk.ukuu.org.uk>
References: <01b801c22f0b$c02cc360$47cba8c0@promise.com.tw>
Subject: Re: [PATCH] 2.4.19-rc2-ac2 pdc202xx.c update
Date: Mon, 22 Jul 2002 11:16:04 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Giro,

Yes, It's 2.4.18 + patch-2.4.19-rc2 + patch-2.4.19-rc2-ac2 +
promise-patch-2.4.19-rc2-ac2.

Sorry, In ide.c (line-918) lack a '{' sign.c

> drivers/ide/idedriver.o(.text+0x3b37): undefined reference to
> `pdc202xx_marvell_idle'

Sorry, You must not enable CONFIG_BLK_DEV_PDC202XX
Or append follows will be okay.
ide.c (line-172)
#ifdef CONFIG_BLK_DEV_PDC202XX
extern int pdc202xx_marvell_idle (ide_drive_t *);/* needed below -- Promise
*/
#endif

ide.c (line-918)
 if (GET_STAT() & (BUSY_STAT|DRQ_STAT)) {
#ifdef CONFIG_BLK_DEV_PDC202XX
  /* Give a breath for Idle Immediate by Promise */
  if (HWIF(drive)->pci_devid.vid == PCI_VENDOR_ID_PROMISE)
   pdc202xx_marvell_idle(drive);
  else
#endif
   OUT_BYTE(WIN_IDLEIMMEDIATE, IDE_COMMAND_REG); /* force an abort */
 }


Alan or Marcelo, Would you please help us to update above issue? Thanks.


Francois,

We don't occur Oops you said, Please check your patch rule again.


--
Promise Technology, Inc



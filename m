Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275066AbTHQIAa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 04:00:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275070AbTHQIAa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 04:00:30 -0400
Received: from smtp2.att.ne.jp ([165.76.15.138]:17918 "EHLO smtp2.att.ne.jp")
	by vger.kernel.org with ESMTP id S275066AbTHQIA3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 04:00:29 -0400
Message-ID: <135601c36495$85e507b0$1aee4ca5@DIAMONDLX60>
From: "Norman Diamond" <ndiamond@wta.att.ne.jp>
To: <linux-kernel@vger.kernel.org>
Subject: Re: Trying to run 2.6.0-test3
Date: Sun, 17 Aug 2003 16:59:34 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Additional defect:

Support for the 16-bit IDE card KME KXL-C005 was added to the external
PCMCIA package a couple of years ago, and has finally been copied into the
kernel for 2.6.0.  But it doesn't work in 2.6.0-test3.

cardctl ident gets it right:
Socket 1:
  product info: "KME", "KXLC005", "00"
  manfid: 0x0032, 0x0704
  function: 8 (SCSI)
Of course the card is lying, it's really IDE.

2.6.0-test3 gets it wrong:
Aug 17 16:39:01 diamondpana cardmgr[540]: socket 1: KME KXLC005 CD-ROM
Aug 17 16:39:01 diamondpana cardmgr[540]: executing: 'modprobe -v ide_cs'
Aug 17 16:39:02 diamondpana cardmgr[540]: + insmod /lib/modules/2.6.0-test3/kernel/drivers/ide/legacy/ide-cs.ko
Aug 17 16:39:02 diamondpana cardmgr[540]: bind 'ide_cs' to socket 1 failed: Invalid argument

lsmod agrees that the module name is different from the filename:
Module                  Size  Used by
ide_cs                  6400  0

So the problem indeed seems to be an invalid argument in binding.


Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313867AbSFCDtt>; Sun, 2 Jun 2002 23:49:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314077AbSFCDts>; Sun, 2 Jun 2002 23:49:48 -0400
Received: from matrix.seed.net.tw ([192.72.81.219]:35600 "EHLO
	mail.seed.net.tw") by vger.kernel.org with ESMTP id <S313867AbSFCDts>;
	Sun, 2 Jun 2002 23:49:48 -0400
Message-ID: <01bd01c20ab1$ece95900$c0cca8c0@promise.com.tw>
From: "Hank Yang" <hanky@promise.com.tw>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>, <andre@linuxdiskcert.org>,
        <marcelo@conectiva.com.br>
Cc: <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>,
        <arjanv@redhat.com>, "Linus Chen" <linusc@promise.com.tw>,
        "Crimson Hung" <crimsonh@promise.com.tw>,
        "Jenny Liang" <jennyl@promise.com.tw>, <jordanr@promise.com>
In-Reply-To: <E16lBmI-0006nf-00@the-village.bc.nu> <039701c20892$3940ca30$c0cca8c0@promise.com.tw> <1022855592.4124.415.camel@irongate.swansea.linux.org.uk>
Subject: Re: [PATCH] 2.4.19pre9 in pdc202xx.c bug
Date: Mon, 3 Jun 2002 11:51:19 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dears.

    There is something wrong in drivers/ide/pdc202xx.c ide driver.
Andre Hedrick has merged ide stuff to 2.4.18 kernel that released for
RedHat 7.3, SuSE 8.0 and Mandrake 8.2. That has a bug inside to
harmful our company.

First, in pdc202xx_dmaproc() function.

Our source code is:
unsigned long atapi_port =high_16+ 0x20 + (hwif->channel ? 0x04 : 0x00);

2.4.19pre8(RedHat 7.3, SuSE 8.0 and Mandrake 8.2) is:
unsigned long atapi_reg = high_16 + (hwif->channel ? 0x24 : 0x00);

The Primary channel get wrong address, So this cause our PDC20265/67
couldn't
work on Primary channel with LBA48 drives.
Andre, I think this is your mistake, Could you please kind to fix it?

Second, our PDC20262 controller do not support LBA48 with hardware48hack
function. Please fix it in pdc202xx_dmaproc() function also.

Third, I told Alan before.
In pdc202xx_new_tune_chipset() function.
We need to set timing for only ATA133 drives exist on both channel.
If not ATA133 drives exists, we do not need to set timing here.
Please update this function also.

Fourth.
I hope can add quirk drives list to pdc202xx.c below
"QUANTUM FIREBALLP KA9.1"
"QUANTUM FIREBALLP KX13.6"
please append these if you are in available.

The last.
I hope you guys could help us to notice RedHat, SuSE, Mandrake and
etc to fix this bug as soon as possible.

Thanks in advance and sincerely
Hank Yang




Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130874AbQLECMk>; Mon, 4 Dec 2000 21:12:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130875AbQLECMa>; Mon, 4 Dec 2000 21:12:30 -0500
Received: from uberbox.mesatop.com ([208.164.122.11]:11276 "EHLO
	uberbox.mesatop.com") by vger.kernel.org with ESMTP
	id <S130874AbQLECMV>; Mon, 4 Dec 2000 21:12:21 -0500
From: Steven Cole <elenstev@mesatop.com>
Reply-To: elenstev@mesatop.com
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-test12-pre4 + cs46xx + KDE 2.0 = frozen system
Date: Mon, 4 Dec 2000 18:42:11 -0700
X-Mailer: KMail [version 1.1.95.2]
Content-Type: text/plain; charset=US-ASCII
Cc: alan@lxorguk.ukuu.org.uk
MIME-Version: 1.0
Message-Id: <00120418421100.04128@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
>> > Crystal 4280/461x + AC97 Audio, version 0.14, 13:39:25 Dec  4 2000
>> > cs461x: Card found at 0xf8ffe000 and 0xf8e00000, IRQ 18
>> > cs461x: Unknown card (FFFFFFFF:FFFFFFFF) at 0xf8ffe000/0xf8e00000, IRQ 18
>> > ac97_codec: AC97 Audio codec, id: 0x4352:0x5914 (Unknown)
>>
>> This is failing to detect the CS46xx. I assume someone has fiddled with the
>> driver. Does it work correctly on your machine in 2.2.18pre24 ?

I believe it did for 2.2.18pre23.  I'll try out 2.2.18pre24 and your 
following patch when I'm back at work about 12 hours from now.
Thanks!
Steven Cole

Alan Cox wrote:
>
>A follow on question. This may be 2.4 PCI changes. That would mean you might
>want..
>
>--- drivers/sound/cs46xx.c~    Sat Dec  2 01:44:21 2000
>+++ drivers/sound/cs46xx.c     Mon Dec  4 22:58:58 2000
>@@ -2534,6 +2534,11 @@
>       struct cs_card *card;
>       struct cs_card_type *cp = &cards[0];
>
>+      if (pci_enable_device(pci_dev)<0)
>+      {
>+              printk(KERN_ERR "cs461x: unable to enable\n");
>+              return -EIO;
>+      }
>       if ((card = kmalloc(sizeof(struct cs_card), GFP_KERNEL)) == NULL) {
>               printk(KERN_ERR "cs461x: out of memory\n");
>               return -ENOMEM;

I'll apply that patch tomorrow.

Steven
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

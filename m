Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129763AbRBHFHx>; Thu, 8 Feb 2001 00:07:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129753AbRBHFHn>; Thu, 8 Feb 2001 00:07:43 -0500
Received: from smtp3.jp.psi.net ([154.33.63.113]:47633 "EHLO smtp3.jp.psi.net")
	by vger.kernel.org with ESMTP id <S129763AbRBHFHZ>;
	Thu, 8 Feb 2001 00:07:25 -0500
Message-ID: <3A822987.59BBA51B@vgkk.com>
Date: Thu, 08 Feb 2001 14:07:19 +0900
From: "A.Sajjad Zaidi" <sajjad@vgkk.com>
Organization: Vanguard K.K.
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
CC: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Promise, DMA and RAID5 problems running 2.4.1
In-Reply-To: <14CC6FFB19AD@vcnet.vc.cvut.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Petr Vandrovec wrote:

> It is known bug which I reported to Andre already. Open
> drivers/ide/ide.c in favorite text editor, and replace strange
> body of ide_delay_50ms() with simple mdelay(50). Promise driver
> invokes ide_delay_50ms with interrupts disabled, so it freezes
> here forever. If you have NMI watchdog, you'll get nice oopses.
>
> As for DMA failure itself, I have no idea what is wrong in your
> case, but I found that mine Promise works with Linux only iff there
> is master on each channel, slave alone does not work. And I did not
> tried master+slave together.
>                                     Petr Vandrovec
>                                     vandrove@vc.cvut.cz

Ok, I changed ide.c and stopped getting the freeze, but bad DMA status errors
were still showing up.

Then I connected all the drives as masters (2x ATA-100, 2x ATA-66) and havent
gotten anything yet. Buffered disk reads are still about 36.50 MB/sec on the
raid5 device, so its fast enough for what I need.

Next step is to see how well Reiserfs works here.

Thank you everyone who has helped.

A.Sajjad Zaidi

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266149AbRF2SJF>; Fri, 29 Jun 2001 14:09:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266153AbRF2SI4>; Fri, 29 Jun 2001 14:08:56 -0400
Received: from mailout03.sul.t-online.com ([194.25.134.81]:43527 "EHLO
	mailout03.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S266149AbRF2SIq>; Fri, 29 Jun 2001 14:08:46 -0400
Message-ID: <3B3CC466.9CAC4365@t-online.de>
Date: Fri, 29 Jun 2001 20:09:42 +0200
From: Gunther.Mayer@t-online.de (Gunther Mayer)
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andre Hedrick <andre@aslab.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Patch(2.4.5): Fix PCMCIA ATA/IDE freeze (w/ PCI add-in cards)V3
In-Reply-To: <Pine.LNX.4.04.10106281317001.30863-100000@mail.aslab.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre Hedrick wrote:
> 
> That is a legacy bit from ATA-2 but it is one of those things you can not
> get rid of :-( even thou things are obsoleted, they are not retired.
> This means that you have to go back into the past to see how it was used,
> silly!  I hope you agree to that point.

No,
in ANSI X3.279-1996, "AT Attachment Interface with Extensions (ATA-2)",
Approved September 11, 1996 , control register bit 3-7 are reserved.

However ANSI X3.221-1994, "AT Attachment Interface for Disk Drives",
Approved May 12, 1994, bit3 is "1" and bits 4-7 are "x". No further explanation.

How far back must we go, to get the sense ?

> 
> This is the drive->ctrl register pointer.
> 
> outp(drive->ctl|0x02, IDE_CONTROL_REG);
> 
> typedef union {
>         unsigned all                    : 8;    /* all of the bits together */
>         struct {
>                 unsigned bit0           : 1;
>                 unsigned nIEN           : 1;    /* device INTRQ to host */
>                 unsigned SRST           : 1;    /* host soft reset bit */
>                 unsigned bit3           : 1;    /* ATA-2 thingy */
>                 unsigned reserved456    : 3;
>                 unsigned HOB            : 1;    /* 48-bit address ordering */
>         } b;
> } control_t;
> 
> This is a new struct that is to be added for 48-bit addressing and it will
> reflect drive->ctl soon.  I have not decided how to use it best or at all,
> but it has meaning and once I add-in the real def of bit3 then I will not
> need to look it up again.

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129069AbQJaTl1>; Tue, 31 Oct 2000 14:41:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129828AbQJaTlH>; Tue, 31 Oct 2000 14:41:07 -0500
Received: from mail-04-real.cdsnet.net ([63.163.68.109]:38922 "HELO
	mail-04-real.cdsnet.net") by vger.kernel.org with SMTP
	id <S129069AbQJaTlC>; Tue, 31 Oct 2000 14:41:02 -0500
Message-ID: <39FF20F7.E9E15008@mvista.com>
Date: Tue, 31 Oct 2000 11:43:51 -0800
From: George Anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.72 [en] (X11; I; Linux 2.2.14-VPN i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: "linux-kernel@vger.redhat.com" <linux-kernel@vger.kernel.org>
Subject: Re: Locking question, is this cool?
In-Reply-To: <E13qgf5-00089s-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > At line 1073 of ../drivers/char/i2lib.c (2.4.0-test9) we find:
> >
> > WRITE_LOCK_IRQSAVE(...
> >
> > this is followed by:
> >
> > COPY_FROM_USER(...
> >
> > It seems to me that this could result in a page fault with interrupts
> > off.  Is this ok?
> 
> It wont do what you want - it'll re-enable irqs and may then deadlock. It might
> need to copy the buffer to a temporary space then take the lock >
> -
I suspected as much.  I see the same error (bug?) at line 978 of
../drivers/char/riotty.c

Seems like a common problem.

george
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

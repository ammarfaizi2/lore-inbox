Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261560AbSJALIj>; Tue, 1 Oct 2002 07:08:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261563AbSJALIj>; Tue, 1 Oct 2002 07:08:39 -0400
Received: from mta04bw.bigpond.com ([139.134.6.87]:10231 "EHLO
	mta04bw.bigpond.com") by vger.kernel.org with ESMTP
	id <S261560AbSJALIi>; Tue, 1 Oct 2002 07:08:38 -0400
Message-ID: <08e001c2693b$8e64e8c0$41368490@archaic>
From: "David McIlwraith" <quack@bigpond.net.au>
To: "Martin Diehl" <lists@mdiehl.de>
Cc: <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.21.0210010523290.485-100000@notebook.diehl.home>
Subject: Re: calling context when writing to tty_driver
Date: Tue, 1 Oct 2002 21:13:22 +1000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.3663.0
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3663.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Semaphores may sleep - therefore, they cannot be used from a 'non-sleep'
context.

Sincerely,
David McIlwraith quack@bigpond.net.au

----- Original Message -----
From: "Martin Diehl" <lists@mdiehl.de>
To: <linux-kernel@vger.kernel.org>
Cc: "Greg KH" <greg@kroah.com>
Sent: Tuesday, October 01, 2002 8:37 PM
Subject: calling context when writing to tty_driver


>
> Hi,
>
> just hitting another "sleeping on semaphore from illegal context" issue
> with 2.5.39. Happened on down() in either usbserial->write_room() or
> usbserial->write(), when invoked from bh context.
>
> Some grepping reveals no documentation of calling context requirements
> for those driver calls and existing serial code seems to be happy with bh
> context. Therefore I'm wondering whether it is permitted to call from
> don't-sleep context?
>
> Since write_room() is usually called immediately before write()'ing stuff
> to the driver it would be a good idea to keep them both callable from bh,
> IMHO. For example tty_ldisc->write_wakeup() might probably want to issue
> write_room() followed by write().
>
> Currently, usbserial calls write_wakeup() from bh (on OUT urb completion)
> but needs process context for write_room() and write(). My impression is
> the whole point of write_room() is to find out how many data can be
> accepted by the write() - if write() would be allowed to sleep it could
> just block to deal with any amount of data.
>
> TIA for any insight.
>
> Martin
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131394AbRAUAcu>; Sat, 20 Jan 2001 19:32:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132685AbRAUAcj>; Sat, 20 Jan 2001 19:32:39 -0500
Received: from mailout3-0.nyroc.rr.com ([24.92.226.118]:8959 "EHLO
	mailout3-0.nyroc.rr.com") by vger.kernel.org with ESMTP
	id <S132637AbRAUAcY>; Sat, 20 Jan 2001 19:32:24 -0500
Message-ID: <022f01c08342$088f67b0$0701a8c0@morph>
From: "Dan Maas" <dmaas@dcine.com>
To: "Edgar Toernig" <froese@gmx.de>, "Michael Lindner" <mikel@att.net>
Cc: "Chris Wedgwood" <cw@f00f.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <fa.nc2eokv.1dj8r80@ifi.uio.no> <fa.dcei62v.1s5scos@ifi.uio.no> <015e01c082ac$4bf9c5e0$0701a8c0@morph> <3A69361F.EBBE76AA@att.net> <20010120200727.A1069@metastasis.f00f.org> <3A694254.B52AE20B@att.net> <3A6A09F2.8E5150E@gmx.de>
Subject: Re: PROBLEM: select() on TCP socket sleeps for 1 tick even if data  available
Date: Sat, 20 Jan 2001 19:35:12 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It's not the select that waits. It's a delay in the tcp send
> path waiting for more data.  Try disabling it:
>
> int f=1;
> setsockopt(s, SOL_TCP, TCP_NODELAY, &f, sizeof(f));

Bingo! With this fix, 2.2.18 performance becomes almost identical to 2.4.0
performance. I assume 2.4.0 disables Nagle by default on local
connections...

Dan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

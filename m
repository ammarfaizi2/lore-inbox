Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129444AbRATW2i>; Sat, 20 Jan 2001 17:28:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129729AbRATW23>; Sat, 20 Jan 2001 17:28:29 -0500
Received: from pop.gmx.net ([194.221.183.20]:37259 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S129444AbRATW2P>;
	Sat, 20 Jan 2001 17:28:15 -0500
Message-ID: <3A6A09F2.8E5150E@gmx.de>
Date: Sat, 20 Jan 2001 22:58:10 +0100
From: Edgar Toernig <froese@gmx.de>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.0.32 i586)
MIME-Version: 1.0
To: Michael Lindner <mikel@att.net>
CC: Chris Wedgwood <cw@f00f.org>, Dan Maas <dmaas@dcine.com>,
        linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: select() on TCP socket sleeps for 1 tick even if data 
 available
In-Reply-To: <fa.nc2eokv.1dj8r80@ifi.uio.no> <fa.dcei62v.1s5scos@ifi.uio.no> <015e01c082ac$4bf9c5e0$0701a8c0@morph> <3A69361F.EBBE76AA@att.net> <20010120200727.A1069@metastasis.f00f.org> <3A694254.B52AE20B@att.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Lindner wrote:
>[...]
>                 send(s, ".", 1, 0);
>[...]
>         while (select(r+1, &readfds, 0, 0, 0) > 0) {
>[...]
>[select returns only after about 1 HZ]

Ever heard of nagle?  (If not, there's a long thread about
it on the mailing list *g*)

It's not the select that waits. It's a delay in the tcp send
path waiting for more data.  Try disabling it:

	int f=1;
	setsockopt(s, SOL_TCP, TCP_NODELAY, &f, sizeof(f));

Ciao, ET.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

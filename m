Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131034AbRALO4X>; Fri, 12 Jan 2001 09:56:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131048AbRALO4N>; Fri, 12 Jan 2001 09:56:13 -0500
Received: from mail.rd.ilan.net ([216.27.80.130]:64274 "EHLO mail.rd.ilan.net")
	by vger.kernel.org with ESMTP id <S131034AbRALO4H>;
	Fri, 12 Jan 2001 09:56:07 -0500
Message-ID: <3A5F1AD9.F9868559@holly-springs.nc.us>
Date: Fri, 12 Jan 2001 09:55:21 -0500
From: Michael Rothwell <rothwell@holly-springs.nc.us>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: O_NONBLOCK, read(), select(), NFS, Ext2, etc.
In-Reply-To: <E14H0hc-00043X-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > using the O_NONBLOCK flag, then read() and write() will always return
> > immediately and not block the calling process. This does not appear to
> > be true; but perhaps I am doing something wrong. If I open() a file (on
> > 2.2.18) from a floppy or NFS mount (to test in a slow environment) with
> > O_NONBLOCK|O_RDONLY, read() will still block. If I try to select() on
> > the file descriptor, select() always returns 0.
> 
> The definition of immediate is not 'instant'. Otherwise no I/O system would
> ever return anything but -EWOULDBLOCK. Its that it won't wait when there is
> no data pending. On a floppy there is always data pending


How about using fcntl(), O_ASYNC and SIGIO? Or maybe a broader question:
what's the preferred/working way to do async file i/o on Linux?

-M
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

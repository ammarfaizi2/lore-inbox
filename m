Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129213AbQJ3VJE>; Mon, 30 Oct 2000 16:09:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129564AbQJ3VIy>; Mon, 30 Oct 2000 16:08:54 -0500
Received: from [24.65.192.120] ([24.65.192.120]:35056 "EHLO webber.adilger.net")
	by vger.kernel.org with ESMTP id <S129213AbQJ3VIo>;
	Mon, 30 Oct 2000 16:08:44 -0500
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200010302108.e9UL8cJ12524@webber.adilger.net>
Subject: Re: 2.2.X patch query
In-Reply-To: <Pine.LNX.4.10.10010301935480.10495-100000@infradead.org>
 "from Riley Williams at Oct 30, 2000 08:01:32 pm"
To: Riley Williams <rhw@memalpha.cx>
Date: Mon, 30 Oct 2000 14:08:38 -0700 (MST)
CC: Linux kernel development list <linux-kernel@vger.kernel.org>
X-Mailer: ELM [version 2.4ME+ PL73 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Riley Williams writes:
> I'm NOT planning on making panics automatically dump to floppy. What I
> was looking at instead was to add a SysRq option to dump the current
> syslog buffer to floppy. This would be available at any time, but ONLY
> if the kernel has SYSRQ support compiled in, and has additionally
> enabled CONFIG_SYSRQ_DUMPLOG (which appears when SYSRQ is enabled). In
> addition, it would need to be enabled at runtime, probably by writing
> to a root-owned /proc file with 0600 permissions.

Just as an FYI, there is a patch that does essentially what you are
looking at: kmsgdump, by Willy Tarreau.  It does a syslog dump to
floppy with SysRq-D, and has the excellent feature that it writes a
(simple) MS-DOS formatted floppy, which also has a "pass-through"
boot sector, so you can leave it in the floppy drive and it will not
halt booting.  You can have syslog sizes up to 64kB.  It also supports
printing to the printer port.

http://www-miaif.lip6.fr/willy/pub/linux-patches/kmsgdump/

This would actually be very handy in conjunction with the "loadable
sysrq functions" patch that has been posted here a couple of times.

I suspect that such a patch wouldn't make it into 2.2 or 2.4.  I also
don't see why you want to have a strangely formatted floppy, since even
a regular 1.44 format will hold your proposed maximum 1MB buffer.  Since
the printk buffer is pinned kernel memory, you probably don't want that
any larger (if 1MB at all).

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

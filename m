Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129261AbQJ2Qwl>; Sun, 29 Oct 2000 11:52:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129237AbQJ2Qwc>; Sun, 29 Oct 2000 11:52:32 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:7466 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129099AbQJ2QwY>; Sun, 29 Oct 2000 11:52:24 -0500
Subject: Re: SMP System 2.2.15 #2 locking & Memory oddness?
To: babina@pex.net (John Babina III)
Date: Sun, 29 Oct 2000 16:26:18 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (Linux kernel mailing list)
In-Reply-To: <Pine.LNX.4.20.0010291020560.7464-100000@pioneer.local.net> from "John Babina III" at Oct 29, 2000 10:41:01 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13pvHo-0006Aj-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Then I killed the two apache processes and the memory usage stayed
> basically the same.  I even checked top and ps, with no other programs
> hogging memory.  I can't seem to get the memory to "clear".

The memory usage stuff seems sane. We wont free memory because its unused its
just now cached and blown away if it must be replaced

> Linux Kernel 2.2.15 #2 SMP

Go to 2.2.17 or higher for SMP with high TCP loads. At least one bad bug
with exactly the sort of locks you describe got fixed. Let me know if 2.2.17
behaves better I'd like to chase this one down if not

> Linux Kernel max processes per user upped to 512 from 256
> (this was an attempt to resolve the problem, system crashing before this
> was done as well)

More processes is fine. It wont die if it runs out just refuse to create stuff
so you'd see cgi's failing

> Apache 1.3.14 running with max processes of 450, mostly serving tiny
> static graphics (< 1k each) - standard apache, this is the one that gets
> around 500,000 hits a day

For static images you'll find thttpd gives way better performance generally
(http://www.acme.com). However thats I think unrelated to your problems. You
have crashes not overloading and overloading would make it slow and annoying
not die

Alan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

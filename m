Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129613AbRCCR3A>; Sat, 3 Mar 2001 12:29:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129618AbRCCR2u>; Sat, 3 Mar 2001 12:28:50 -0500
Received: from smtp-rt-11.wanadoo.fr ([193.252.19.62]:30654 "EHLO
	magnolia.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S129613AbRCCR2h>; Sat, 3 Mar 2001 12:28:37 -0500
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: <linuxppc-dev@lists.linuxppc.org>, <linux-kernel@vger.kernel.org>
Subject: Re: The IO problem on multiple PCI busses
Date: Sat, 3 Mar 2001 18:28:08 +0100
Message-Id: <19350126105952.7554@smtp.wanadoo.fr>
In-Reply-To: <3AA0CF0D.CB9D544C@mandrakesoft.com>
In-Reply-To: <3AA0CF0D.CB9D544C@mandrakesoft.com>
X-Mailer: CTM PowerMail 3.0.6 <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I/O is not supposed to be fast, that's what MMIO is for. :)  Just do
>
>void outb (u8 val, u16 addr)
>{
>	void *addr = ioremap (ISA_IO_BASE + addr);
>	if (addr) {
>		writeb (val, addr);
>		iounmap (addr);
>	}
>}
>
>You can map and unmap for each call :)  Ugly and slow, but hey, it's
>I/O...

Well, that would really suck ;) And I don't think it would be necessary
as we can probably limit each IO bus to 64k without much problem, and
have them permanently ioremap'ed.

Ben.

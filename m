Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129834AbQKBXUE>; Thu, 2 Nov 2000 18:20:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129843AbQKBXTy>; Thu, 2 Nov 2000 18:19:54 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:46930 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129834AbQKBXTs>; Thu, 2 Nov 2000 18:19:48 -0500
Subject: Re: select() bug
To: pmarquis@iname.com (Paul Marquis)
Date: Thu, 2 Nov 2000 23:20:51 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <3A01F3EF.59761C8E@iname.com> from "Paul Marquis" at Nov 02, 2000 06:08:31 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13rTfB-00023L-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm not exactly sure what you mean by this statement.  Would you mind
> explaining further?

Well take a socket with 64K of buffering. You don't want to wake processes
waiting in select or in write every time you can scribble another 1460 bytes
to the buffer. Instead you wait until there is 32K of room then wake the
user. That means that there is one wakeup/trip through userspace every 32K
rather than potentially every time a byte is read the other end

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

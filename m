Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129371AbQJ3WmU>; Mon, 30 Oct 2000 17:42:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129475AbQJ3WmJ>; Mon, 30 Oct 2000 17:42:09 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:43534 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S129371AbQJ3WmG>;
	Mon, 30 Oct 2000 17:42:06 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: test10-pre7 
In-Reply-To: Your message of "Mon, 30 Oct 2000 14:24:13 -0800."
             <Pine.LNX.4.10.10010301423070.1085-100000@penguin.transmeta.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 31 Oct 2000 09:41:57 +1100
Message-ID: <11037.972945717@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Oct 2000 14:24:13 -0800 (PST), 
Linus Torvalds <torvalds@transmeta.com> wrote:
>This is the right fix. We MUST NOT sort those things.

Correction.  We can sort them if we know what the correct link order
should be.  In far too many Makefiles, we have no idea if the existing
order is required or is just historical so we fail safe and do not sort
them.  For USB we know what the link order must be, usb.o must be
first, the rest do not matter.  This patch only affects usb because it
is the only one that uses LINK_FIRST.

>The only reason for sorting is apparently to remove the "multi-objs"
>things, and replace them with the object files they are composed of.
>
>To which I say "Why?"
>
>It makes more sense to just leave the multi's there.

obj-y is used together with export-objs to split objects into O_OBJS
(no export symbol) and OX_OBJS (export symbol).  If usbcore.o (multi)
is not replaced by its components then usb.o (in export-objs) is not
added to OX_OBJS so usb.c gets compiled with the wrong flags which
causes incorrect module symbols.  Multi's in obj-y have to replaced by
their components before being split into O_OBS and OX_OBJS.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

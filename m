Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129203AbQJ3XEC>; Mon, 30 Oct 2000 18:04:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129290AbQJ3XDw>; Mon, 30 Oct 2000 18:03:52 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:55566 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S129203AbQJ3XDq>;
	Mon, 30 Oct 2000 18:03:46 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: test10-pre7 
In-Reply-To: Your message of "Mon, 30 Oct 2000 14:51:25 -0800."
             <Pine.LNX.4.10.10010301447490.1085-100000@penguin.transmeta.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 31 Oct 2000 10:03:39 +1100
Message-ID: <11462.972947019@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Oct 2000 14:51:25 -0800 (PST), 
Linus Torvalds <torvalds@transmeta.com> wrote:
>On Tue, 31 Oct 2000, Keith Owens wrote:
>> 
>> obj-y is used together with export-objs to split objects into O_OBJS
>> (no export symbol) and OX_OBJS (export symbol).  If usbcore.o (multi)
>> is not replaced by its components then usb.o (in export-objs) is not
>> added to OX_OBJS so usb.c gets compiled with the wrong flags which
>> causes incorrect module symbols.  Multi's in obj-y have to replaced by
>> their components before being split into O_OBS and OX_OBJS.
>
>Your honour, I object.
>
>What would be wrong with just splitting it the other way, ie make OX_OBJS
>be the expanded (but not ordered) list?
>
>That should take care of it, no?

usbcore.o is both multi part *and* order critical.  This is a
combination that the existing "link order relies on declaration order"
kludge cannot cope with.  It requires an explicit declaration of link
order, which is exactly what LINK_FIRST implements.

FWIW, 2.5 kbuild will use LINK_FIRST and LINK_LAST exclusively, instead
of relying on the declaration order.  This is primarily so we get
documentation of link order and why it matters.  But it will also mean
that we can neatly sort declarations by CONFIG_ name if we want to.
That global change is only for 2.5, but there is nothing to stop us
using the preferred technique now, if nothing else works.

For usb, no other Makefile techniques will work, it needs LINK_FIRST.
I don't want to change the USB source code to overcome kbuild problems,
especially when those problems will disappear in 2.5.  And I repeat,
this change only affects usb in 2.4.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

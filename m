Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129463AbQJ3WGn>; Mon, 30 Oct 2000 17:06:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129691AbQJ3WGd>; Mon, 30 Oct 2000 17:06:33 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:30734 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S129513AbQJ3WG0>;
	Mon, 30 Oct 2000 17:06:26 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: test10-pre7 
In-Reply-To: Your message of "Mon, 30 Oct 2000 17:01:20 CDT."
             <39FDEFB0.B99B7E68@mandrakesoft.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 31 Oct 2000 09:06:20 +1100
Message-ID: <10523.972943580@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Oct 2000 17:01:20 -0500, 
Jeff Garzik <jgarzik@mandrakesoft.com> wrote:
>Keith Owens wrote:
>> USB still gets unresolved symbols when part is in kernel, part is in
>> modules and modversions are set.  Patch against 2.4.0-test10-pre7, only
>> affects drivers/usb/Makefile.
>
>Or instead of all that, you could simply call the core init function
>from init/main.c...

Does that work when all of usb is a module?  The point of __initcall is
to avoid all the conditional code that used to be in main.c.

>Ya know, sorting those lists causes this problem, too...  usb.o is
>listed first in the various lists, as is usbcore.o.  Is it possible to
>avoid sorting?  Doing so will fix this, and also any other link order
>breakage like this that exists, too.

You have it backwards.  Rules.make does *not* sort, the link order is
implicit in the declaration order of objects in the Makefiles.  For
most makefiles, this kludge works, it does not work for USB.  See
http://www.uwsg.indiana.edu/hypermail/linux/kernel/0010.3/0661.html

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

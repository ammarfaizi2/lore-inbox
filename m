Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129100AbQJ3WPE>; Mon, 30 Oct 2000 17:15:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129157AbQJ3WOz>; Mon, 30 Oct 2000 17:14:55 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:37131 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129100AbQJ3WOj>;
	Mon, 30 Oct 2000 17:14:39 -0500
Message-ID: <39FDF2A6.AFA0B513@mandrakesoft.com>
Date: Mon, 30 Oct 2000 17:13:58 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
CC: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: test10-pre7
In-Reply-To: <10523.972943580@ocs3.ocs-net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:
> 
> On Mon, 30 Oct 2000 17:01:20 -0500,
> Jeff Garzik <jgarzik@mandrakesoft.com> wrote:
> >Keith Owens wrote:
> >> USB still gets unresolved symbols when part is in kernel, part is in
> >> modules and modversions are set.  Patch against 2.4.0-test10-pre7, only
> >> affects drivers/usb/Makefile.
> >
> >Or instead of all that, you could simply call the core init function
> >from init/main.c...
> 
> Does that work when all of usb is a module?  The point of __initcall is
> to avoid all the conditional code that used to be in main.c.

When all of usb is a module, there are no initcalls.

If you need static initialization for in-kernel init, here is the
shortest solution I can come up with:

/********************* usb.c **********************/

int usbcore_init() {...}

#ifdef MODULE
module_init(usbcore_init);
#endif
module_exit(usbcore_exit);

/******************** main.c ******************/

extern int usbcore_init (void);
	/* ... */
#ifdef CONFIG_USB
	usbcore_init();
#endif

-- 
Jeff Garzik             | "Mind if I drive?"  -Sam
Building 1024           | "Not if you don't mind me clawing at the
MandrakeSoft            |  dash and shrieking like a cheerleader."
                        |                     -Max
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129077AbQJ3RKp>; Mon, 30 Oct 2000 12:10:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129112AbQJ3RKg>; Mon, 30 Oct 2000 12:10:36 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:23059 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129077AbQJ3RKa>;
	Mon, 30 Oct 2000 12:10:30 -0500
Message-ID: <39FDAB1E.89BA3CC1@mandrakesoft.com>
Date: Mon, 30 Oct 2000 12:08:46 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Tigran Aivazian <tigran@veritas.com>
CC: root@chaos.analogic.com, John Levon <moz@compsoc.man.ac.uk>,
        Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: kmalloc() allocation.
In-Reply-To: <Pine.LNX.4.21.0010301653280.2617-100000@saturn.homenet>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tigran Aivazian wrote:
> 
> On Mon, 30 Oct 2000, Jeff Garzik wrote:
> 
> > "Richard B. Johnson" wrote:
> > > Now, I could set up a linked-list of buffers and use vmalloc()
> > > if the buffers were allocated from non-paged RAM. I don't think
> > > they are. These buffers must be present during an interrupt.
> >
> > Non-paged RAM?  I'm not sure what you mean by that.
> >
> > Both kmalloc and vmalloc allocate pages, but neither will allocate pages
> > that the system will swap out (page out).  [vk]malloc pages are always
> > around during an interrupt.

> Jeff, I was going to tell him that but in the previous sentence he was
> talking about userspace supplied buffers and those are certainly not
> pinned.

Well the problem sounds really strange then.  Why are kmalloc/vmalloc
being talked about at all, if we are dealing with userspace-supplied
buffers?

IF copy_to_user is being used here, userspace buffers in kernel space
are pointless.  Any userspace buffer supplied to read(2) must by design
be a different buffer than the 2nd arg of copy_to_user.  If copy_to_user
is being used, then there is a "copy" taking place...

Richard, if you want to read directly into userspace buffers, kiobufs
are the way to go...   If you don't want to ever swap them in and out,
you can mlock(2) them.  Or simply allocate the memory in the driver, and
mmap those buffers.  Much easier than read(2), and it eliminates any
copy step.

	Jeff



-- 
Jeff Garzik             | "Mind if I drive?"  -Sam
Building 1024           | "Not if you don't mind me clawing at the
MandrakeSoft            |  dash and shrieking like a cheerleader."
                        |                     -Max
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

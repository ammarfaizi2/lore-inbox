Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129032AbQJ3SMY>; Mon, 30 Oct 2000 13:12:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129026AbQJ3SMO>; Mon, 30 Oct 2000 13:12:14 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:38149 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129480AbQJ3SMC>;
	Mon, 30 Oct 2000 13:12:02 -0500
Message-ID: <39FDB9A7.154B385F@mandrakesoft.com>
Date: Mon, 30 Oct 2000 13:10:47 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: John Levon <moz@compsoc.man.ac.uk>,
        Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: kmalloc() allocation.
In-Reply-To: <Pine.LNX.3.95.1001030130325.2540C-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" wrote:
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
> >
> >       Jeff
> 
> Hmm, vmalloc() doesn't seem to have the size limitation. Are you sure
> that it's present during an interrupt? I can't page-fault during the
> interrupt.

vmalloc'd memory does have a size limitation, though it's larger than
kmalloc's limit.  AFAIK vmalloc'd memory is a collection of pages
remapping in the page tables to be virtually contiguous, implying that
it is present during an interrupt.

-- 
Jeff Garzik             | "Mind if I drive?"  -Sam
Building 1024           | "Not if you don't mind me clawing at the
MandrakeSoft            |  dash and shrieking like a cheerleader."
                        |                     -Max
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

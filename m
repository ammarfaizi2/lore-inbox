Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131013AbQLFBYk>; Tue, 5 Dec 2000 20:24:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131030AbQLFBYb>; Tue, 5 Dec 2000 20:24:31 -0500
Received: from sgi.SGI.COM ([192.48.153.1]:45944 "EHLO sgi.com")
	by vger.kernel.org with ESMTP id <S131013AbQLFBYZ>;
	Tue, 5 Dec 2000 20:24:25 -0500
Message-ID: <3A2D8E1D.CC04FDBC@thebarn.com>
Date: Tue, 05 Dec 2000 18:53:49 -0600
From: Russell Cattelan <cattelan@thebarn.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-whipme11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] livelock in elevator scheduling
In-Reply-To: <200011210838.RAA27382@asami.proc.flab.fujitsu.co.jp> <20001121112836.B10007@suse.de> <200011211130.UAA27961@asami.proc.flab.fujitsu.co.jp> <20001121123608.F10007@suse.de> <3A2840AB.EE085CAA@thebarn.com> <20001202164234.B31217@suse.de> <3A2C472B.DBEA9E9@thebarn.com> <20001206000108.F747@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:

> On Mon, Dec 04 2000, Russell Cattelan wrote:
> > I'm going to take a closer look at the scsi_back_merge_fn.
> > This may  have more to due with our/Chait's kiobuf modifications than
> > anything else.
> >
> >
> >
> > XFS (dev: 8/20) mounting with KIOBUFIO
> > Start mounting filesystem: sd(8,20)
> > Ending clean XFS mount for filesystem: sd(8,20)
> > kmem_alloc doing a vmalloc 262144 size & PAGE_SIZE 0 rval=0xe0a10000
> > Unable to handle kernel NULL pointer dereference at virtual address
> > 00000008
> >  printing eip:
> > c019f8b5
> > *pde = 00000000
> >
> > Entering kdb (current=0xc1910000, pid 5) on processor 1 Panic: Oops
> > due to panic @ 0xc019f8b5
> > eax = 0x00000002 ebx = 0x00000001 ecx = 0x00081478 edx = 0x00000000
> > esi = 0xc1957da0 edi = 0xc1923ac8 esp = 0xc1911e94 eip = 0xc019f8b5
> > ebp = 0xc1911e9c xss = 0x00000018 xcs = 0x00000010 eflags = 0x00010046
> > xds = 0x00000018 xes = 0x00000018 origeax = 0xffffffff &regs = 0xc1911e60
> > [1]kdb> bt
> >     EBP       EIP         Function(args)
> > 0xc1911e9c 0x00000000c019f8b5 scsi_back_merge_fn_c+0x15 (0xc1923a98,
> > 0xc1957da0, 0xcfb05780, 0x80)
> >                                kernel .text 0xc0100000 0xc019f8a0
>
> Ah, I see what it is now. The elevator is attempting to merge a buffer
> head into a kio based request, poof. The attached diff should take
> care of that in your tree.

Hmm..  Yup... that is actually the mods made for kio in our base XFS tree.
I wonder why the patch dropped them?
I should have caught that.

Thanks.
I'll let you know how things go.


>
>
> --
> * Jens Axboe <axboe@suse.de>
> * SuSE Labs
>
>   ------------------------------------------------------------------------
>
>    xfs-elv-1Name: xfs-elv-1
>             Type: Plain Text (text/plain)

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

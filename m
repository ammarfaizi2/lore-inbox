Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129598AbQK0UB0>; Mon, 27 Nov 2000 15:01:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129932AbQK0UBG>; Mon, 27 Nov 2000 15:01:06 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:37127 "EHLO
        neon-gw.transmeta.com") by vger.kernel.org with ESMTP
        id <S129598AbQK0UBD>; Mon, 27 Nov 2000 15:01:03 -0500
Message-ID: <3A22B668.7AA3AAC@transmeta.com>
Date: Mon, 27 Nov 2000 11:30:48 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11-pre5 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Philipp Rumpf <prumpf@parcelfarce.linux.theplanet.co.uk>
CC: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: How to transfer memory from PCI memory directly to user space safely 
 and portable?
In-Reply-To: <00112614213105.05228@paganini> <20001126151120.V2272@parcelfarce.linux.theplanet.co.uk> <8vu9ji$r2a$1@cesium.transmeta.com> <20001127192919.X2272@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Philipp Rumpf wrote:
> 
> On Mon, Nov 27, 2000 at 10:36:34AM -0800, H. Peter Anvin wrote:
> > Followup to:  <20001126151120.V2272@parcelfarce.linux.theplanet.co.uk>
> > By author:    Philipp Rumpf <prumpf@parcelfarce.linux.theplanet.co.uk>
> > In newsgroup: linux.dev.kernel
> > >
> > > I hope count isn't provided by userspace here ?
> > >
> > > > 1. What happens if the user space memory is swapped to disk? Will
> > > > verify_area() make sure that the memory is in physical RAM when it returns,
> > > > or will it return -EFAULT, or will something even worse happen?
> > >
> > > On i386, you'll sleep implicitly waiting for the page fault to be handled;  in
> > > the generic case, anything could happen.
> > >
> >
> > That doesn't sound right.  I would expect it to wait for the page to
> > be brought in on any and all architectures, otherwise it seems rather
> > impossible to write portable Linux kernel code.
> 
> The code in question was
>         memcpy_fromio(user_space_dst, iobase, count);
> 
> Assuming user_space_dst is a userspace pointer, what I said is true;  on some
> architectures we will be dereferencing random pointers in kernel space, and
> we won't get -EFAULT right on any architecture.
> 
> Or did I miss something ?
> 

Yes, the post you responded to was talking about verify_area() [which is,
admittedly, obsolete.]

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

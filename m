Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129524AbQK0T74>; Mon, 27 Nov 2000 14:59:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129598AbQK0T7q>; Mon, 27 Nov 2000 14:59:46 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:26895 "EHLO
        www.linux.org.uk") by vger.kernel.org with ESMTP id <S129524AbQK0T72>;
        Mon, 27 Nov 2000 14:59:28 -0500
Date: Mon, 27 Nov 2000 19:29:19 +0000
From: Philipp Rumpf <prumpf@parcelfarce.linux.theplanet.co.uk>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How to transfer memory from PCI memory directly to user space safely and portable?
Message-ID: <20001127192919.X2272@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <00112614213105.05228@paganini> <20001126151120.V2272@parcelfarce.linux.theplanet.co.uk> <8vu9ji$r2a$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <8vu9ji$r2a$1@cesium.transmeta.com>; from hpa@zytor.com on Mon, Nov 27, 2000 at 10:36:34AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2000 at 10:36:34AM -0800, H. Peter Anvin wrote:
> Followup to:  <20001126151120.V2272@parcelfarce.linux.theplanet.co.uk>
> By author:    Philipp Rumpf <prumpf@parcelfarce.linux.theplanet.co.uk>
> In newsgroup: linux.dev.kernel
> > 
> > I hope count isn't provided by userspace here ?
> > 
> > > 1. What happens if the user space memory is swapped to disk? Will 
> > > verify_area() make sure that the memory is in physical RAM when it returns, 
> > > or will it return -EFAULT, or will something even worse happen?
> > 
> > On i386, you'll sleep implicitly waiting for the page fault to be handled;  in
> > the generic case, anything could happen.
> > 
> 
> That doesn't sound right.  I would expect it to wait for the page to
> be brought in on any and all architectures, otherwise it seems rather
> impossible to write portable Linux kernel code.

The code in question was
	memcpy_fromio(user_space_dst, iobase, count);

Assuming user_space_dst is a userspace pointer, what I said is true;  on some
architectures we will be dereferencing random pointers in kernel space, and
we won't get -EFAULT right on any architecture.

Or did I miss something ?
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

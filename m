Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131675AbQKZPli>; Sun, 26 Nov 2000 10:41:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131985AbQKZPl2>; Sun, 26 Nov 2000 10:41:28 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:41739 "EHLO
        www.linux.org.uk") by vger.kernel.org with ESMTP id <S131675AbQKZPlX>;
        Sun, 26 Nov 2000 10:41:23 -0500
Date: Sun, 26 Nov 2000 15:11:20 +0000
From: Philipp Rumpf <prumpf@parcelfarce.linux.theplanet.co.uk>
To: Anders Torger <torger@ludd.luth.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How to transfer memory from PCI memory directly to user space safely and portable?
Message-ID: <20001126151120.V2272@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <00112614213105.05228@paganini>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <00112614213105.05228@paganini>; from torger@ludd.luth.se on Sun, Nov 26, 2000 at 02:21:31PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 26, 2000 at 02:21:31PM +0100, Anders Torger wrote:
> 	memcpy_toio(iobase, user_space_src, count);

I hope count isn't provided by userspace here ?

> 1. What happens if the user space memory is swapped to disk? Will 
> verify_area() make sure that the memory is in physical RAM when it returns, 
> or will it return -EFAULT, or will something even worse happen?

On i386, you'll sleep implicitly waiting for the page fault to be handled;  in
the generic case, anything could happen.

> 2. Is this code really portable? I currently have an I386 architecture, and I 
> could use copy_to/from_user on that instead, but that is not portable. Now, 
> by using memcpy_to/fromio instead, is this code fully portable?

No.  It would be portable if you were using memcpy_fromuser_toio and it
existed.

> 3. Will the current process always be the correct one? The copy functions is 
> directly initiated by the user, and not through an interrupt, so I think the 
> user space mapping will always be to the correct process. Is that correct?

current should be fine if you're not in a bh/interrupt/kernel thread.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

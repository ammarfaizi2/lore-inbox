Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129855AbQLBGyx>; Sat, 2 Dec 2000 01:54:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129913AbQLBGyn>; Sat, 2 Dec 2000 01:54:43 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:29930 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S129855AbQLBGyZ>;
	Sat, 2 Dec 2000 01:54:25 -0500
Date: Sat, 2 Dec 2000 01:23:56 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: "Dunlap, Randy" <randy.dunlap@intel.com>
cc: "'jbglaw@lug-owl.de'" <jbglaw@lug-owl.de>, linux-kernel@vger.kernel.org
Subject: RE: usbdevfs mount 2x, umount 1x
In-Reply-To: <D5E932F578EBD111AC3F00A0C96B1E6F07DBDDB0@orsmsx31.jf.intel.com>
Message-ID: <Pine.GSO.4.21.0012020113430.27040-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 30 Nov 2000, Dunlap, Randy wrote:

> Yes, that's how it looks to me also, so maybe it's not a kernel
> problem.  Thanks for the tip.
> 
> Here's more info, including the strace that Al Viro asked for.
> I also made sure that I'm using mount & umount version 2.10o.
> Please let me know if you need anything else.

Bug in umount(8) - it (a) is overagressive in pruning the stuff from
/etc/mtab and (b) doesn't even look into /proc/mounts. I bet that
the second time it didn't even call umount(2) - kernel is of no help
here, after all it's not psychic...

The final test: try to do the first umount with -n. If that helps (i.e if
the second umount does the right thing in that case) - that's it,
kernel side is OK. -n tells umount(8) to leave /etc/mtab untouched.
Note: it's _not_ a workaround. umount(8) is doing the wrong thing when
it purges all entries and that needs to be fixed. However, if
umount -n <mountpoint2>;umount <mountpoint1> works we have a proof that
the kernel side is OK and fixing umount(8) will solve the whole problem.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129256AbRBCEBO>; Fri, 2 Feb 2001 23:01:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129550AbRBCEBF>; Fri, 2 Feb 2001 23:01:05 -0500
Received: from h24-65-192-120.cg.shawcable.net ([24.65.192.120]:4089 "EHLO
	webber.adilger.net") by vger.kernel.org with ESMTP
	id <S129256AbRBCEAx>; Fri, 2 Feb 2001 23:00:53 -0500
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200102030359.f133xrM02216@webber.adilger.net>
Subject: Re: Reasons to honor readonly mount requests
In-Reply-To: <3A7B7F8C.67C2B603@commerceflow.com> from Jeffrey Keller at "Feb
 2, 2001 07:48:28 pm"
To: Jeffrey Keller <jeff@commerceflow.com>
Date: Fri, 2 Feb 2001 20:59:53 -0700 (MST)
CC: sct@redhat.com, linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff writes:
> I understand that both ext3fs and
> reiserfs will try to fix corrupt filesystems (or at least filesystems
> with unprocessed log entries) in-place even if they're mounted
> read-only.  Clearly, virtual replay means more work, but -- just for
> fun -- here are some cases in which it might matter:
> 
> 1. You want the disk image untouched for forensic analysis or data
>    recovery.
> 2. You don't trust the disk to do writes properly.
> 3. You don't trust the driver to do writes properly.
> 4. You want to test a newer or unstable FS implementation w/ option to
>    go back to the older one.

Excluding the root fs (which probably isn't involved in these sorts of
things anyways), you can always turn off the "RECOVERY" flag on the
filesystem and mount ext3 as ext2, which will not do any recovery.

> 5. You're sharing the disk via:
>         VMWare (multiple OS instances on 1 computer)
>         passive backplane (multiple computers on 1 bus)
>         PCI bridge (multiple computers w/ connected buses)
>         SCSI/FC/FireWire (multiple computers sharing device)
> 
> The merit of #5 is reduced but not quite obviated by the fact that
> it's generally unsafe to share a disk if even one party is writing to it.

Very true.  Any changes made by the writer will not be noticed by the
reader if it has already cached those pages.  Best to use a cluster
filesystem in all of these cases.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

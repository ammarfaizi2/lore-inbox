Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130195AbQLROsL>; Mon, 18 Dec 2000 09:48:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130192AbQLROsB>; Mon, 18 Dec 2000 09:48:01 -0500
Received: from hera.cwi.nl ([192.16.191.1]:14252 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S129391AbQLROrt>;
	Mon, 18 Dec 2000 09:47:49 -0500
Date: Mon, 18 Dec 2000 15:17:10 +0100 (MET)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200012181417.PAA167011.aeb@aak.cwi.nl>
To: tigran@veritas.com, torvalds@transmeta.com
Subject: Re: [patch-2.4.0-test13-pre3] rootfs boot param. support
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From: Tigran Aivazian <tigran@veritas.com>

    +    rootfs=        [KNL] Use filesystem type specified (e.g. rootfs=ext2) for root.

(i) I prefer "rootfstype". Indeed, "rootfs" is ambiguous.
It gives some property of the root filesystem, but which?
     
    +static char rootfs[128] __initdata = "ext2";

(ii) It is a bad idea to arbitrarily select "ext2".
Moreover, we want to recognize the case where a boot option was given,
see below.
     
    +    fs_type = get_fs_type(rootfs);
    +    if (fs_type) {
    +          sb = read_super(ROOT_DEV,bdev,fs_type,root_mountflags,NULL,1);
    +        if (sb)
    +            goto mount_it;
    +    }

(iii) I probably give the rootfstype explicitly because bad things
(like disk corruption) happen when the kernel misrecognizes some
filesystem, and perhaps starts updating access times or so.
Thus, if the boot option rootfstype is given, I prefer a boot failure
over a kernel attempt to try all filesystems it knows about, just like
mount(8) only will start guessing when no explicit type was given.

Andries
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

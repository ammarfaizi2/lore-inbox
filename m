Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272575AbRHaBQ2>; Thu, 30 Aug 2001 21:16:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272576AbRHaBQS>; Thu, 30 Aug 2001 21:16:18 -0400
Received: from hera.cwi.nl ([192.16.191.8]:7613 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S272575AbRHaBQG>;
	Thu, 30 Aug 2001 21:16:06 -0400
From: Andries.Brouwer@cwi.nl
Date: Fri, 31 Aug 2001 01:15:50 GMT
Message-Id: <200108310115.BAA318386@vlet.cwi.nl>
To: alan@lxorguk.ukuu.org.uk
Subject: Re: [PATCH] blkgetsize64 ioctl
Cc: bcrl@redhat.com, linux-kernel@vger.kernel.org, michael_e_brown@dell.com,
        tytso@mit.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From: Ben LaHaise
    ...

An interesting conversation, this.
A is blamed for making the terrible mistake of shipping an unreserved ioctl,
very stupid, because by accident B has made the minor mistake of shipping
an unreserved ioctl.
Maybe I misread something.

    From: Michael E Brown <michael_e_brown@dell.com>

    Alan,
        Here is a patch that reserves the 108 and 109 ioctl numbers for
    get/set last sector. This patch has already been merged into the ia64
    tree, and is currently necessary in order to support the EFI GPT
    partitioning scheme on ia64. It is also in the Red Hat kernel tree. I had
    assumed that somebody at Red Hat would have forwarded it to you.

Marking the numbers not-to-be-used is certainly a good idea.

Concerning the need for this particular nonsense - we have had this
discussion earlier this year, and also without any patches
one can read the last sector.  (Using some bad kludge, but still..)

One of the patches I have at ftp.kernel.org removes the entire problem -
one needs (1) a test in ll_rw_blk.c that uses not the size in 1024-byte blocks
but in 512-byte sectors, and (2) a set-blocksize ioctl.
And this latter is needed for other reasons as well.

Maybe I should resubmit some such patch fragments?

Andries


>   Content-Disposition: attachment; filename=patch-getlastsector-20010213
>
>   ZGlmZiAtcnVQIGxpbnV4L2luY2x1ZGUvbGludXgvZnMuaCBsaW51eC1pb2N0

Yes, indeed.

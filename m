Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270948AbRHTAIt>; Sun, 19 Aug 2001 20:08:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270953AbRHTAIj>; Sun, 19 Aug 2001 20:08:39 -0400
Received: from hera.cwi.nl ([192.16.191.8]:29369 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S270948AbRHTAIg>;
	Sun, 19 Aug 2001 20:08:36 -0400
From: Andries.Brouwer@cwi.nl
Date: Mon, 20 Aug 2001 00:08:40 GMT
Message-Id: <200108200008.AAA157827@vlet.cwi.nl>
To: ebiederm@xmission.com, esr@thyrsus.com, sct@redhat.com
Subject: Re: Swap size for a machine with 2GB of memory
Cc: gars@lanm-pc.com, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From: ebiederm@xmission.com (Eric W. Biederman)
    Date:     19 Aug 2001 14:49:23 -0600

    "Eric S. Raymond" <esr@thyrsus.com> writes:

    > The Red Hat installation manual claims that the size of the
    > swap partition should be twice the size of physical memory,
    > but no more than 128MB.
    > 
    > Should I believe the above formula?

You give two statements. The 128 MB bound was claimed by Microsoft
and we screamed loudly that that was a lie - now it is claimed
by both SuSE and RedHat. Funny.
No, the bound is not 128 MB. See mkswap(8).

    With respect to swap partitions the current limit is about 64Gig.
    You can actually make a larger swap partition but the kernel on x86
    only uses 24 offset bits into that partition.  The 128MB partition
    existed but was removed long ago.

Long ago I wrote in mkswap(8) that the max on i386 is about 2 GiB.
I seem to recall that at some point in time the swap size in
bytes had to fit in a signed long, and indeed, 2.1.117 has
        if (p->max >= 0x7fffffffL/PAGE_SIZE ...
2.2.0pre9 changed this into
        if (p->max >= SWP_OFFSET(SWP_ENTRY(0,~0UL)))
deleting this restriction.
If it is no longer there, I suppose I should change mkswap.c.
Stephen, can you confirm?

Andries

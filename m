Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289662AbSAOUpu>; Tue, 15 Jan 2002 15:45:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290280AbSAOUpl>; Tue, 15 Jan 2002 15:45:41 -0500
Received: from hera.cwi.nl ([192.16.191.8]:25573 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S289662AbSAOUpi>;
	Tue, 15 Jan 2002 15:45:38 -0500
From: Andries.Brouwer@cwi.nl
Date: Tue, 15 Jan 2002 20:44:55 GMT
Message-Id: <UTC200201152044.UAA324996.aeb@cwi.nl>
To: hch@caldera.de, torvalds@transmeta.com
Subject: Re: [linux-lvm] Re: [RFLART] kdev_t in ioctls
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
        linux-lvm@sistina.com, viro@math.psu.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


    On Mon, 14 Jan 2002, Christoph Hellwig wrote:
    >
    > I know - still it makes Linus' suggestion not work on ~90% of the
    > systems.

    It doesn't matter if user-land compilation breaks. As long as old binaries
    work (and they will), we're fine.

    User-land was _already_ broken. By virtue of using a type that it should
    NOT have used.

    If you want to use __kernel_dev_t, go ahead.

            Linus

Yes. As everyone knows, one should not use kernel includes.
On the other hand, having local copies of everything is also
a bad habit, to be avoided when possible.
With Linux it is generally impossible to avoid going to local
copies, but so far losetup survived with the construction

% cat loop.h
#include <linux/posix_types.h>
#undef dev_t
#define dev_t __kernel_dev_t
#include <linux/loop.h>
#undef dev_t
%

Yecch.

(This is terribly ugly, but the alternative may be even worse:
lots of #ifdef's testing architecture etc.)

It is a pity that dev_t, a type that is not used anywhere in the
kernel except at the interface with user space, is a different
type from what user space uses.

Andries

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131591AbQKXGD0>; Fri, 24 Nov 2000 01:03:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131837AbQKXGDR>; Fri, 24 Nov 2000 01:03:17 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:15538 "EHLO math.psu.edu")
        by vger.kernel.org with ESMTP id <S131591AbQKXGDI>;
        Fri, 24 Nov 2000 01:03:08 -0500
Date: Fri, 24 Nov 2000 00:32:55 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Neil Brown <neilb@cse.unsw.edu.au>
cc: "Mohammad A. Haque" <mhaque@haque.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Tigran Aivazian <tigran@veritas.com>
Subject: Re: ext2 filesystem corruptions back from dead? 2.4.0-test11
In-Reply-To: <14877.53881.182935.597766@notabene.cse.unsw.edu.au>
Message-ID: <Pine.GSO.4.21.0011240006040.12702-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 24 Nov 2000, Neil Brown wrote:

> I ran my test script, which builds a variety of raid5 arrays with
> varying numbers of drives and chunk sizes, and runs mkfs/bonnie/dbench
> on each array, and it got through about 8 file systems but choked on
> the 9th by trying to allocate lots of blocks in the system zone (after
> running for about an hour). 

Bloody interesting. I don't see anything recent that could affect the
areas in question. Intersting versions to check: 11-pre5 and 11-pre6.
It smells like buffer cache corruption, but I don't see anything
relevant. __generic_unplug_device() change loock pretty innocent,
ditto for bh_kmap() ones in raid5 and on ext2 side we had two obviously
equivalent replacements (pre5->pre6). No buffer.c changes, no VM ones.
Urgh.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129415AbQKZGv6>; Sun, 26 Nov 2000 01:51:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129659AbQKZGvs>; Sun, 26 Nov 2000 01:51:48 -0500
Received: from lsb-catv-1-p021.vtxnet.ch ([212.147.5.21]:18193 "EHLO
        almesberger.net") by vger.kernel.org with ESMTP id <S129415AbQKZGvj>;
        Sun, 26 Nov 2000 01:51:39 -0500
Date: Sun, 26 Nov 2000 07:21:10 +0100
From: Werner Almesberger <Werner.Almesberger@epfl.ch>
To: Andries Brouwer <aeb@veritas.com>
Cc: Tigran Aivazian <tigran@veritas.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] removal of "static foo = 0"
Message-ID: <20001126072110.G599@almesberger.net>
In-Reply-To: <20001125211939.A6883@veritas.com> <Pine.LNX.4.21.0011252205500.768-100000@penguin.homenet> <20001126023239.B7049@veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20001126023239.B7049@veritas.com>; from aeb@veritas.com on Sun, Nov 26, 2000 at 02:32:39AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries Brouwer wrote:
> On Sat, Nov 25, 2000 at 10:27:15PM +0000, Tigran Aivazian wrote:

I think it's a bad sign if people like the two of you start flaming
each other ...

On the issue of  static int foo = 0;  vs.  static int foo;  I'd agree
with Andries' view. It's a common enough idiom that it is useful to
convey the intentions of the programmer.

On "optimizing" changes: there are plenty of very ugly things you can
do to a C program to make source or object code smaller (e.g. use only
one-character identifiers for smaller code; re-use variables as much
as possible, maybe with casts for smaller stack footprint, etc.). We
usually avoid these too, so a few extra initializations in the source
shouldn't hurt.

On the .data segment size: if all the energy that went into this
thread would have gone into implementing a gcc option to move all-zero
.data objects to .bss, the technical side of the problem would be
solved already ;-)

> Does the kernel contain a bug? Panic!  I don't think my alpha would
> have gotten an uptime of 1198 days under that paradigm.
> (I don't think you were serious, but still..)

Hmm, sometimes a panic _is_ the right answer, though. If a critical
subsystem just politely returns an error to user space and tries to
continue, it may take a while until somebody realizes that there's
something wrong at all ...

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, ICA, EPFL, CH           Werner.Almesberger@epfl.ch /
/_IN_N_032__Tel_+41_21_693_6621__Fax_+41_21_693_6610_____________________/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

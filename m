Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262436AbRENTuW>; Mon, 14 May 2001 15:50:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262437AbRENTuM>; Mon, 14 May 2001 15:50:12 -0400
Received: from penguin.engin.umich.edu ([141.213.33.36]:51465 "EHLO
	penguin.engin.umich.edu") by vger.kernel.org with ESMTP
	id <S262436AbRENTtx>; Mon, 14 May 2001 15:49:53 -0400
Date: Mon, 14 May 2001 15:49:51 -0400 (EDT)
From: Chris Wing <wingc@engin.umich.edu>
To: "Khachaturov, Vassilii" <Vassilii.Khachaturov@comverse.com>
cc: linux-kernel@vger.kernel.org
Subject: RE: uid_t and gid_t vs. __kernel_uid_t and __kernel_gid_t
In-Reply-To: <6B1DF6EEBA51D31182F200902740436802678EC4@mail-in.comverse-in.com>
Message-ID: <Pine.LNX.4.21.0105141541020.30715-100000@penguin.engin.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vassilii:

> I am trying to understand what's the cleanest coding that would allow
> 1) user code to just use uid/gid for interfacing the driver control
> structures
> 2) driver code to read/write the corresponding structure fields with minimum
> awareness of the actual difference between kernel and user uid_t/gid_t
> layout.

Just define a structure like:

struct user-to-kernel {
	unsigned int	uid;
	unsigned int	gid;
	...
}

and copy the header into your user space program. The alignments may
differ between different Linux architectures, but that won't matter.
You aren't going to be running a program compiled on a sparc on an i386
anyway...

If you are writing a filesystem or sending data over the network directly
via the kernel (without going through the user space program), then you
will need to decide upon a fixed byte order and alignment. (but this
doesn't seem to be the case for you, right?)

-Chris
wingc@engin.umich.edu


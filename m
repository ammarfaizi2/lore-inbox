Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132547AbRD1PBL>; Sat, 28 Apr 2001 11:01:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132557AbRD1PBB>; Sat, 28 Apr 2001 11:01:01 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:15516 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S132547AbRD1PAs>;
	Sat, 28 Apr 2001 11:00:48 -0400
Date: Sat, 28 Apr 2001 11:00:46 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Martin Dalecki <dalecki@evision-ventures.com>
cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cleanup for fixing get_super() races
In-Reply-To: <3AEAD138.5B9D188F@evision-ventures.com>
Message-ID: <Pine.GSO.4.21.0104281049350.23302-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 28 Apr 2001, Martin Dalecki wrote:

> I think in the context you are inventig the proposed function, 
> the drivers has allways an inode at hand. And contrary to what Linus

Read the patch. Almost all cases are of the "loop over partitions of foo"
kind.

> says, drivers not just know about the devices they handle, they 
> know about the data they should get - at least in the context
> of block devices. And then you could as well pass the inode, which
> is already containing a refference to the corresponding sb and
> save the whole get_super linear array lookup 8-). I think

No, you don't. Moreover, inode of device (even if you had it) _doesn't_
contain a reference to sb of filesystem mounted from that device.

> the less kdev_t the better! It's overused already anyway, like
> for example in the whole SCSI code, where the functions in reality only
> want to pass the minor number to differentiate they behaviour...
> 
> If you are gogin to flag the behaviour of the function,
> then please use a bitpattern of well definded flags as a parameter,
> in a similiar way like it's done for example in many GUI libraries
> (GTK, Motif and so on). This would make it far more readabel.

/me looks at From:
OK, Albert, what have you done with real Martin?

OK, whoever you are - no, "expandable" interfaces of that sort are
rotten idea. What we really need is to replace sync_dev with fsync_dev -
it _is_ correct in such context. That's it - 1 bit of information, no
bitmaps needed.

/me is still boggled by the idea of somebody refereing to GTK as an
example of style...


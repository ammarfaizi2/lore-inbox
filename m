Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135764AbRD2Mle>; Sun, 29 Apr 2001 08:41:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135765AbRD2MlX>; Sun, 29 Apr 2001 08:41:23 -0400
Received: from [195.63.194.11] ([195.63.194.11]:44041 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S135764AbRD2MlL>; Sun, 29 Apr 2001 08:41:11 -0400
Message-ID: <3AEC0906.D1C13A54@evision-ventures.com>
Date: Sun, 29 Apr 2001 14:28:54 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17-14 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cleanup for fixing get_super() races
In-Reply-To: <Pine.GSO.4.21.0104281049350.23302-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:
> 
> On Sat, 28 Apr 2001, Martin Dalecki wrote:
> 
> > I think in the context you are inventig the proposed function,
> > the drivers has allways an inode at hand. And contrary to what Linus
> 
> Read the patch. Almost all cases are of the "loop over partitions of foo"
> kind.
> 
> > says, drivers not just know about the devices they handle, they
> > know about the data they should get - at least in the context
> > of block devices. And then you could as well pass the inode, which
> > is already containing a refference to the corresponding sb and
> > save the whole get_super linear array lookup 8-). I think
> 
> No, you don't. Moreover, inode of device (even if you had it) _doesn't_
> contain a reference to sb of filesystem mounted from that device.

Ohhh sorry right, I just did forget to have an checking look at the code
before actual rammbling... It must had been some reminiscent from
some other expermient with the kernel code I did recently that confused
me.
Sorry again...

> > the less kdev_t the better! It's overused already anyway, like
> > for example in the whole SCSI code, where the functions in reality only
> > want to pass the minor number to differentiate they behaviour...

This however I still hold up...

> > If you are gogin to flag the behaviour of the function,
> > then please use a bitpattern of well definded flags as a parameter,
> > in a similiar way like it's done for example in many GUI libraries
> > (GTK, Motif and so on). This would make it far more readabel.
> 
> /me looks at From:
> OK, Albert, what have you done with real Martin?
> 
> OK, whoever you are - no, "expandable" interfaces of that sort are
> rotten idea. What we really need is to replace sync_dev with fsync_dev -
> it _is_ correct in such context. That's it - 1 bit of information, no
> bitmaps needed.
> 
> /me is still boggled by the idea of somebody refereing to GTK as an
> example of style...

Ehm, only for the waythe flags get passed, not the rest of it.
You know if I see some parameter, taking possible values 0, 1, 2
then I mostly think that there should be some concrete names given to
them :-).

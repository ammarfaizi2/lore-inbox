Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132934AbRD1ObB>; Sat, 28 Apr 2001 10:31:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133012AbRD1Oav>; Sat, 28 Apr 2001 10:30:51 -0400
Received: from [195.63.194.11] ([195.63.194.11]:3854 "EHLO mail.stock-world.de")
	by vger.kernel.org with ESMTP id <S132934AbRD1Oar>;
	Sat, 28 Apr 2001 10:30:47 -0400
Message-ID: <3AEAD138.5B9D188F@evision-ventures.com>
Date: Sat, 28 Apr 2001 16:18:32 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17-14 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cleanup for fixing get_super() races
In-Reply-To: <Pine.GSO.4.21.0104272127390.21109-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:
> 
> On Fri, 27 Apr 2001, Alexander Viro wrote:
> 
> > Fine with me. Actually in _all_ cases execept cdrom.c it's preceded by
> > either sync_dev() or fsync_dev(). What do you think about pulling that
> > into the same function? Actually, that's what I've done in namespace
> > patch (name being invalidate_dev(), BTW ;-) The only problem I see
> > here is the argument telling whether we want sync or fsync (or nothing).
> > OTOH, I seriously suspect that we ought replace all sync_dev() cases
> > with fsync_dev() anyway... Your opinion?
> >                                                               Al
> 
> PS: last time I've separated that part of patch was a couple months
> ago. See if something similar to the variant below would be OK with
> you (I'll rediff it):

I think in the context you are inventig the proposed function, 
the drivers has allways an inode at hand. And contrary to what Linus
says, drivers not just know about the devices they handle, they 
know about the data they should get - at least in the context
of block devices. And then you could as well pass the inode, which
is already containing a refference to the corresponding sb and
save the whole get_super linear array lookup 8-). I think
the less kdev_t the better! It's overused already anyway, like
for example in the whole SCSI code, where the functions in reality only
want to pass the minor number to differentiate they behaviour...

If you are gogin to flag the behaviour of the function,
then please use a bitpattern of well definded flags as a parameter,
in a similiar way like it's done for example in many GUI libraries
(GTK, Motif and so on). This would make it far more readabel.

-- just my two euro-cent's...

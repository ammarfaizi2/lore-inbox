Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278673AbRKFIyM>; Tue, 6 Nov 2001 03:54:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278690AbRKFIyC>; Tue, 6 Nov 2001 03:54:02 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:27155 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S278673AbRKFIxu>; Tue, 6 Nov 2001 03:53:50 -0500
Message-ID: <3BE7A3DD.D98400FB@zip.com.au>
Date: Tue, 06 Nov 2001 00:48:29 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.14-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [Ext2-devel] disk throughput
In-Reply-To: <E1611lE-00086H-00@the-village.bc.nu> <Pine.GSO.4.21.0111060334590.27713-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:
> 
> On Tue, 6 Nov 2001, Alan Cox wrote:
> 
> > Surely the answer if you want short term write speed and long term balancing
> > is to use ext3 not ext2 and simply ensure that the relevant stuff goes to
> > the journal (which will be nicely ordered) first. That will give you some
> > buffering at least.
> 
> Alan, the problem is present in ext3 as well as in all other FFS derivatives
> (well, FreeBSD had tried to deal that stuff this Spring).
> 

Yep.  Once we're seek-bound on metadata and data, the occasional
seek-and-squirt into the journal won't make much difference, and
the other write patterns will be the same.

Interestingly, current ext3 can do a 600 meg write in fifty
seconds, whereas ext2 takes seventy.  This will be related to the
fact that ext3 just pumps all the buffers into submit_bh(), 
whereas ext2 fiddles around with all the write_locked_buffers()
stuff.  I think.  Or the intermingling of indirects with data
is tripping ext2 up.  The additional seeking is audible.

-

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262340AbREUSgg>; Mon, 21 May 2001 14:36:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262342AbREUSg0>; Mon, 21 May 2001 14:36:26 -0400
Received: from waste.org ([209.173.204.2]:26160 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S262340AbREUSgU>;
	Mon, 21 May 2001 14:36:20 -0400
Date: Mon, 21 May 2001 13:37:48 -0500 (CDT)
From: Oliver Xymoron <oxymoron@waste.org>
To: Alexander Viro <viro@math.psu.edu>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: no ioctls for serial ports? [was Re: LANANA: To Pending DeviceNum
In-Reply-To: <Pine.GSO.4.21.0105211407281.12245-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.30.0105211322580.17263-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 May 2001, Alexander Viro wrote:

> On Mon, 21 May 2001, Oliver Xymoron wrote:
>
> > If you've got side channels that are of a packet nature (aka commands),
> > then they can all happily coexist on one device. If you've got channels
> > that are streams or intended for mmap, those ought to be different
> > devices.
>
> Since you've been refering to -9 - care to take a look at the contents of
> uart(3)? Or lpt(3). Or draw(3), for that matter.

K - so what? I'm guessing what you want me to see is that these
implement multiple channels. Is there a reason that eia001stat couldn't be
implemented as

 f=open("/dev/eia001ctl",O_RDWR);
 write(f,"stat\n");
 status=read(f); /* returns "stat foo\n" */

We don't want to implement a separate device node for every OOB ioctl that
returns data, do we? Why should stat be any different?

/dev/draw is interesting but largely irrelevant. And again, colormap and
refresh - why are they not part of ctl? You've got to select on refresh
anyway, might as well accept asynchronous messages through ctl.

--
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."


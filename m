Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id <S132587AbRC1Vdz>; Wed, 28 Mar 2001 16:33:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id <S132572AbRC1Vbg>; Wed, 28 Mar 2001 16:31:36 -0500
Received: from [195.63.194.11] ([195.63.194.11]:44299 "EHLO mail.stock-world.de") by vger.kernel.org with ESMTP id <S132582AbRC1VbQ>; Wed, 28 Mar 2001 16:31:16 -0500
Message-ID: <3AC2550D.1D9F3355@evision-ventures.com>
Date: Wed, 28 Mar 2001 23:18:05 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linus Torvalds <torvalds@transmeta.com>, "H. Peter Anvin" <hpa@transmeta.com>, Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org, tytso@MIT.EDU
Subject: Re: Larger dev_t
References: <E14i1ln-0004Tn-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > high-end-disks. Rather the reverse. I'm advocating the SCSI layer not
> > hogging a major number, but letting low-level drivers get at _their_
> > requests directly.
> 
> A major for 'disk' generically makes total sense. Classing raid controllers
> as 'scsi' isnt neccessarily accurate. A major for 'serial ports' would also
> solve a lot of misery

And IDE disk ver CD-ROM f and block vers. raw devices
and so so at perpetuum. Those are the reaons why the
density of majros ver. minors is exactly
revers in solaris with respect to the proposal of Linus..

And then we have all those VERY SPARSE static arrays of
major versus minor devices information (if you look at which cells
from those arrays are used on a running system which maybe about
6-8 devices actually attached!)

The main  sheer practical problem to changing kdev_t is
the HUGE number of in fact entierly differnt drivers sharing the same
major
and splitting up the minor number space and then hooking
devices with differnt block sizes and such on the same major.
Many things in the block device layer handling could
be simplefied significalty if one could assume for
example that all the devices on one single major
have the same block size and so on...

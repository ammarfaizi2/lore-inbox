Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262720AbREOKFD>; Tue, 15 May 2001 06:05:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262719AbREOKEx>; Tue, 15 May 2001 06:04:53 -0400
Received: from draco.cus.cam.ac.uk ([131.111.8.18]:57245 "EHLO
	draco.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S262718AbREOKEb>; Tue, 15 May 2001 06:04:31 -0400
Message-Id: <5.1.0.14.2.20010515105633.00a22c10@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 15 May 2001 11:04:30 +0100
To: Linus Torvalds <torvalds@transmeta.com>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: Getting FS access events
Cc: Richard Gooch <rgooch@ras.ucalgary.ca>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.21.0105142357220.23955-100000@penguin.transmeta
 .com>
In-Reply-To: <200105150649.f4F6nwD22946@vindaloo.ras.ucalgary.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 08:13 15/05/01, Linus Torvalds wrote:
>On Tue, 15 May 2001, Richard Gooch wrote:
> > So what happens if I dd from the block device and also from a file on
> > the mounted FS, where that file overlaps the bnums I dd'ed? Do we get
> > two copies in the page cache? One for the block device access, and one
> > for the file access?
>
>Yup. And never the two shall meet.
>
>Why should they? Why would you ever do something like that, or care about
>the fact?

They shouldn't, but maybe some stupid utility or a typo will do it creating 
two incoherent copies of the same block on the device. -> Bad Things can 
happen.

Can't we simply stop people from doing it by say having mount lock the 
device from further opens (and vice versa of course, doing a "dd" should 
result in lock of device preventing a mount during the duration of "dd"). - 
Wouldn't this be a good thing, guaranteeing that problems cannot happen 
while not incurring any overhead except on device open/close? Or is this a 
matter of "give the user enough rope"? - If proper rw locking is 
implemented it could allow simultaneous -o ro mount with a dd from the 
device but do exclusive write locking, for example, for maximum flexibility.

Just my 2p.

Anton


-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://sourceforge.net/projects/linux-ntfs/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/


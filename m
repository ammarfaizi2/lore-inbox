Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316385AbSEOOyv>; Wed, 15 May 2002 10:54:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316387AbSEOOyu>; Wed, 15 May 2002 10:54:50 -0400
Received: from [212.18.235.99] ([212.18.235.99]:47373 "EHLO street-vision.com")
	by vger.kernel.org with ESMTP id <S316385AbSEOOyt>;
	Wed, 15 May 2002 10:54:49 -0400
From: Justin Cormack <kernel@street-vision.com>
Message-Id: <200205151454.g4FEsh419684@street-vision.com>
Subject: Re: Initrd or Cdrom as root
To: tigran@veritas.com (Tigran Aivazian)
Date: Wed, 15 May 2002 15:54:42 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0205151523500.2461-100000@einstein.homenet> from "Tigran Aivazian" at May 15, 2002 03:28:17 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> On Wed, 15 May 2002, Dead2 wrote:
> > So, I now have a new problem I hope someone can help me out with.
> > It now mounts the cdrom as root like it should, but then gives me the error:
> > "Warning: unable to open an initial console."
> >
> > I have checked everything I can think of, but if someone could point me to
> > exactly generates this error, I would be forever grateful.
> 
> Yes, that is well-known.
> 
> Unix root filesystem cannot be readonly in its entirety. Linux is much
> better, but even Linux is not perfect.
> 
> So, what I do is --- I prepare the /var, /home, /etc, /dev in a tar.gz
> file and place it on CD. Then, from rc.sysinit I mount tmpfs on those
> points and unpack the tar.gz from / --- thus ending up with readwrite /var
> /home /etc and /dev. (you could avoid /dev issue by using devfs but then
> you will have other little problems to deal with :)

no this is not true. I use busybox plus devfs and it works perfecly read
only. Or you can run the entire system out of an initrd which you can
of course write to if you want to write (it makes some things a little
easier). You can always mount /tmp with tmpfs if you want some write space.

Unable to open an initial console sounds to me like dev is not populated.
Have you got /dev/console and /dev/tty0? I do recommend devfs for this
type of thing, as it makes scripting your initial installer easier (you
can loop over /dev/hd* and so on).

Justin




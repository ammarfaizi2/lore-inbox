Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265295AbTIJRPI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 13:15:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265337AbTIJRPI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 13:15:08 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:57744 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S265295AbTIJRO6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 13:14:58 -0400
Date: Wed, 10 Sep 2003 19:14:37 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: viro@parcelfarce.linux.theplanet.co.uk
cc: Stephen Hemminger <shemminger@osdl.org>, jffs-dev@axis.com,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] fix type mismatch in jffs.
In-Reply-To: <20030910024010.GN454@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.GSO.4.21.0309101913561.1390-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Sep 2003 viro@parcelfarce.linux.theplanet.co.uk wrote:
> On Tue, Sep 09, 2003 at 02:44:20PM -0700, Stephen Hemminger wrote:
> > On 2.6.0-test5 jffs generates a warning about type mismatch because it casting a short
> > to a pointer.  Look like an obvious typo.
> 
> Which it is.  Thanks for spotting.  Linux, please apply.
>  
> > Builds clean, not tested on real hardware.
> > 
> > diff -Nru a/fs/jffs/inode-v23.c b/fs/jffs/inode-v23.c
> > --- a/fs/jffs/inode-v23.c	Tue Sep  9 14:41:53 2003
> > +++ b/fs/jffs/inode-v23.c	Tue Sep  9 14:41:53 2003
> > @@ -1734,7 +1734,7 @@
> >  		   the device should be read from the flash memory and then
> >  		   added to the inode's i_rdev member.  */
> >  		u16 val;
> > -		jffs_read_data(f, (char *)val, 0, 2);
> > +		jffs_read_data(f, (char *)&val, 0, 2);
> >  		init_special_inode(inode, inode->i_mode,
> >  			old_decode_dev(val));
> >  	}

Is this endian-safe?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


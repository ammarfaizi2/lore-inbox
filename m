Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316649AbSG3VeU>; Tue, 30 Jul 2002 17:34:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316604AbSG3Vdn>; Tue, 30 Jul 2002 17:33:43 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:57812 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S316662AbSG3Vc0>;
	Tue, 30 Jul 2002 17:32:26 -0400
Date: Tue, 30 Jul 2002 23:35:42 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Greg KH <greg@kroah.com>, Vojtech Pavlik <vojtech@suse.cz>,
       linux-kernel@vger.kernel.org, linuxconsole-dev@lists.sourceforge.net
Subject: Re: [patch] Input cleanups for 2.5.29 [2/2]
Message-ID: <20020730233542.A23181@ucw.cz>
References: <20020730210938.GA16657@kroah.com> <Pine.LNX.4.33.0207301417190.2051-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0207301417190.2051-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Tue, Jul 30, 2002 at 02:20:36PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2002 at 02:20:36PM -0700, Linus Torvalds wrote:

> On Tue, 30 Jul 2002, Greg KH wrote:
> 
> > On Tue, Jul 30, 2002 at 03:23:42PM +0200, Vojtech Pavlik wrote:
> > > -#include <asm/types.h>
> > > +#include <stdint.h>
> > 
> > Why?  I thought we were not including any glibc (or any other libc)
> > header files when building the kernel?
> 
> Indeed. This is unacceptable.
> 
> Especially as the standard types are total crap, and the u8 etc are a lot 
> more readable. People should realize:
> 
>  - the "int" is superfluous. Of _course_ it's an integer. If it was a 
>    floating point number, it would be fp16/fp32/fp64/fp80/whatever.
>  - the "_t" is there only for namespace collisions, sane people can chose 
>    to ignore it.
> 
> What do you have left after you have removed the crap? Yup. u8, u16, etc. 
> And if you want to share with user space, there's the long-accepted 
> namespace collision avoidance of prepending two underscores.
> 
> Fix it, Vojtech.
> 
> 		Linus

I will, and will do so happily. I don't like the uint*_t types as well.
This change was pushed very heavily for by Brad Hards, based on a
conclusion of a rather lengthy discussion (I think on linux-usb) on
which types should be used.

Now the question remaining is how to fix that? You can just skip the
patch. I've tried a 'bk undo', but that complains about unmerged leaves
in that case (though really nothing depends on those changes). Or should
I just make another cset on top of all the previous?

-- 
Vojtech Pavlik
SuSE Labs

Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317256AbSFKX4A>; Tue, 11 Jun 2002 19:56:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317257AbSFKXz7>; Tue, 11 Jun 2002 19:55:59 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:22286 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S317256AbSFKXz5>;
	Tue, 11 Jun 2002 19:55:57 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.21: kbuild changes broke filenames with commas 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 12 Jun 2002 09:55:48 +1000
Message-ID: <16120.1023839748@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 11 June 2002 18:31, Russell King wrote:
> On Tue, Jun 11, 2002 at 06:08:22PM +0200, Daniel Phillips wrote:
> So now we have two places where the same yucky substing of commas to
> something more palettable happens.

So what?  Users want filenames with ',' in them, the build system
should cope with it.  Restricting what the user is allowed to do to
what the build system can handle is the wrong approach.  The build
system already has to replace '-' with '_', changing comma as well is
not a problem.  Or are you going to say that '-' is not allowed in
filenames either?

>Now, what if we had:
> 
> 	foo,bar.c
> 
> and
> 
> 	foo_bar.c
> 
> in the same directory?  The kbuild system goes wrong, destroying dependency
> information, using the wrong KBUILD_BASENAME.  Oops.  I guess we papered
> over a bug by allowing commas in filenames.

Not in kbuild 2.5.  I handle this case correctly for the -MD dependency
filename.  Try it and see.

KBUILD_BASENAME and KBUILD_OBJECTNAME could suffer from name
collisions.  BASENAME is only used inside objects so duplicate
basenames are not a problem.

OBJECTNAME is externally visible, it is used in Rusty's rationalization
of boot and module parameters.  The only time that OBJECTNAME collision
would be a problem is when there are two modules called foo,bar and
foo_bar.  Having two modules that differ by a single character in the
middle of the name is going to cause more problems than just option
collision.  BTW, the existing build system does not support
KBUILD_OBJECTNAME so Rusty's code cannot go in.

> Both kbuild-2.5 and the existing kernel build make heavy use of the
> "$(*F)" notation.  Should we really be putting semi-obsolete features
> into either of the kernel build system?

That would be worth changing, it is just a textual change with no
effect on the code.


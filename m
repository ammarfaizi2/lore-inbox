Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262190AbTAVRQn>; Wed, 22 Jan 2003 12:16:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262201AbTAVRQn>; Wed, 22 Jan 2003 12:16:43 -0500
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:51073 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S262190AbTAVRQm>; Wed, 22 Jan 2003 12:16:42 -0500
Date: Wed, 22 Jan 2003 11:25:28 -0600 (CST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Mikael Pettersson <mikpe@csd.uu.se>
cc: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
       <linux-kernel@vger.kernel.org>, <rusty@rustcorp.com.au>
Subject: Re: kernel param and KBUILD_MODNAME name-munging mess
In-Reply-To: <15918.28753.632988.981832@harpo.it.uu.se>
Message-ID: <Pine.LNX.4.44.0301221112580.9969-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Jan 2003, Mikael Pettersson wrote:

> Ingo Oeser writes:
>  > On Mon, Jan 20, 2003 at 02:41:03PM +0100, Mikael Pettersson wrote:
>  > > Booting kernel 2.5.59 with the "-s" kernel boot parameter
>  > > doesn't get you into single-user mode like it should.
>  > 
>  > Try using "s" instead. This works since ever. I didn't even know,
>  > that the other option exists, too.
> 
> That's a workaround for this particular case, but the name-munging
> is still wrong and broken.
> 
> With "foo-bar=fie-fum" passed to the kernel, "foo_bar=fie-fum" is
> what's put into init's environment. (I checked.)

I agree that the current behavior is unexpected and probably should be 
fixed. There's basically two ways:
o Pass KBUILD_MODNAME as a string without munging
o Change the setup code to not alter the command line (either use a
  special version of strcmp which knows about "-,_", or work on a 
  temporary copy)

KBUILD_BASENAME needs to be an un-stringified symbol following 
certain conventions to make it possible to use it e.g. in 
include/linux/spinlock.h, that's why '-' and ',' are escaped to '_'.

However, for all I can tell, this is not true for KBUILD_MODNAME, since
that seems to be only used for constructing an actual string, which of 
course can contain all kinds of characters. So I think using the first 
approach would be somewhat nicer, as it gets rid of the unintuitive 
"ide-cd" -> "ide_cd" munging on the kernel command line.

Just needs to be done, of course ;)

--Kai



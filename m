Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317561AbSFRTNY>; Tue, 18 Jun 2002 15:13:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317565AbSFRTNW>; Tue, 18 Jun 2002 15:13:22 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:266 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S317561AbSFRTMd>;
	Tue, 18 Jun 2002 15:12:33 -0400
Date: Tue, 18 Jun 2002 21:16:39 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: kai@tp1.ruhr-uni-bochum.de, linux-kernel@vger.kernel.org
Subject: Re: Various kbuild problems in 2.5.22
Message-ID: <20020618211639.A2659@mars.ravnborg.org>
References: <200206181710.KAA00594@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200206181710.KAA00594@baldur.yggdrasil.com>; from adam@yggdrasil.com on Tue, Jun 18, 2002 at 10:10:59AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2002 at 10:10:59AM -0700, Adam J. Richter wrote:
> 
> 	The standard for make is that if you name the target, it
> builds the target.  If I want to make bzImage and modules, I should type
> "make bzImage modules".
As it is in 2.5.22 make bzImage compares to make installable in kbuild-2.5.
What about combining best of both worlds?

Let
make bzImage	-> Build bzImage
make modules	-> Build modules

And the new member of the family:
make kernel	-> Build selected binary and modules.

So "make kernel" is similar to kbuild-2.5 "make installable" a name 
that I dislike. Obviously "make kernel" requires support for selecting
the appropriate binary utilising make *config.

That would solve your concerns about the semantics - or?

> 
>       I agree with making the common case easier to build, but I would
> happy to have "make bzImage modules" be activatable by "make all" or
> "make" (or both).
"make all" I dislike.
"make all" is for me everything that can be maked, including doc's etc.
make with no argument should in my opinion be equal to "make kernel" -
so we agree there.

>        If I want to the kernel to build to continue even when a module
> fails to compile, I should be able to do that by just using "-k".  Not
> being able to build include/linux/modversions.h prevents me from doing
> that.
>From a conceptual point I disagree here. I would like make to
avoid completion in case an error is flagged.
My prediction is that the new behaviour may result in more errors being
corrected, due to the incentitive to do it. Today you ignore it
and hardly cannot spot it in all the noise generated during the build
process.
By the way - anyone having feedback on the "make KBUILD_VERBOSE=0"
mode. Why not make it default?

	Sam

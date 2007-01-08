Return-Path: <linux-kernel-owner+w=401wt.eu-S1751482AbXAHLm2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751482AbXAHLm2 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 06:42:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750695AbXAHLm2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 06:42:28 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:12679 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751482AbXAHLm1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 06:42:27 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=L0pZTCAqjhpT4zCD7wlyCpzGVf2Q4YHjjOPmTguUyesfDyamgG/r+rF+RONCCXiSKWsip7x6ny0kcGJvJA0CTiwkKs3XS5ggAsvhlexDZH10MwfsGUKuHIhBeQlEXP5iDULyE0EwTfJ9Zi/s8faiya8azPChe2tjlCjrQ3p0lJA=
Message-ID: <47ed01bd0701080342k2670abf2x2a09f02296c023f5@mail.gmail.com>
Date: Mon, 8 Jan 2007 06:42:25 -0500
From: "Dylan Taft" <d13f00l@gmail.com>
Subject: Re: Gaming Interface
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <a06230924c1c7d795429a@192.168.2.101>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <45A22D69.3010905@gmx.net>
	 <3d57814d0701080243n745fcddg8eaace0093e88a38@mail.gmail.com>
	 <45A2356B.5050208@gmx.net> <a06230924c1c7d795429a@192.168.2.101>
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think this is a little bit overkill as well.  Gaming APIs can exist
outside the kernel, in fact, they should.  The problem here is not
that developers don't have access to gaming APIs available for linux,
it's that there's too many, but that's both the burden and blessing of
an open, "free" source environment.

There is one annoying thing though I recently came across.
Calibrating gamepads and joysticks in Linux, it seems there's no
universal way to do this.  There is libjsw, which some programs use,
and SDL, which I believe uses the /dev/* interfaces directly.  jscal
and jscalibrator both only apply to programs that use libjsw(I
believe)

In the end, joystick calibration code is often added directly to
applications that use joysticks, instead of being determined at a
lower level.  If anything, perhaps there should be a way to set null
zones, dead zones, and so on through the input interfaces?  I recently
had to edit gens' source code, for example.  My axis on my gamepad
outputs values from -32767 to +32767.  Values +-3000 are basically
garbage.  The controller is _WAY_ too sensitive.  Gens only throws out
values +-500, so there's a problem.  The gamepad was being so
sensitive that I could not properly define gamepad buttons for gens,
because every time I hit a button the analog sticks would vibrate and
fly to values +-3000 or so, and there is no universally way to
calibrate joysticks that I'm aware of.

Maybe something like _THIS_ should be added to the kernel?  Or is
there already, and I'm just being ignorant?

On 1/8/07, Jay Vaughan <jv@access-music.de> wrote:
> At 13:13 +0100 8/1/07, Dirk wrote:
> >Trent Waddington wrote:
> >  > Call me crazy, but game manufacturers want directx right?  You aint
> >  > running that in the kernel.
> >They want something like DirectX that changes it's API less frequent
> >than DirectX and that compiles as a module because you don't want to run
> >it in the kernel.
> >
>
> Whats wrong with just using SDL/OpenGL?  Thousands of games are made
> with SDL/OpenGL, and there are realms of Linux usage where this works
> just fine, especially for games (GP2X, etc).  In case you didn't
> notice, plenty of pro Game Developers use SDL/OpenGL just fine for
> their needs, and get the job done without grumbling and groaning
> about needing to have their hands held through the process.
>
> I fail to see the reason this requirement has to be a 'kernel'
> interface, other than pure sheer laziness and inability to grok on
> the part of the so-called professional Game Developers.  Gaming is
> only *one* kind of application for the Linux kernel - shall we burden
> the kernel with everything everyone wants just because people fail to
> understand the proper way to assemble a Linux-based kit for their
> specific application needs?  (Hint: work with the distro builders.)
>
> Just my .2c, but anyone suggesting that API's be crowbar'ed into the
> kernel "just to make it easier to get what you want from a single
> source" is probably not as familiar with the underlying technology,
> nor the reasons for its structured organization, as they ought to be
> before making such suggestions ..
>
> --
>
> ;
>
> Jay Vaughan
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

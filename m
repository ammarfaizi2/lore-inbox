Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263948AbRF1TKg>; Thu, 28 Jun 2001 15:10:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263906AbRF1TK0>; Thu, 28 Jun 2001 15:10:26 -0400
Received: from mail203.mail.bellsouth.net ([205.152.58.143]:19698 "EHLO
	imf03bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S264007AbRF1TKP> convert rfc822-to-8bit; Thu, 28 Jun 2001 15:10:15 -0400
Date: Thu, 28 Jun 2001 15:11:22 -0400 (EDT)
From: volodya@mindspring.com
Reply-To: volodya@mindspring.com
To: Stelian Pop <stelian@alcove.fr>
cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.4.5-ac12] New Sony Vaio Motion Eye camera driver
In-Reply-To: <E15A7os-0003e9-00@come.alcove-fr>
Message-ID: <Pine.LNX.4.20.0106281504570.1132-100000@node2.localnet.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Sorry for replying a couple of weeks late - I don't check linux-kernel
that often.

On Wed, 13 Jun 2001, Stelian Pop wrote:

> > I got just the YUV code from Gatos, and a few months ago it took less than
> > an hour to merge just that part (and most of that was compiling and
> > testing).
> 
> Me too. After some days playing with it it seems that the Rage Mobility
> Card (from the Vaio Picturebook C1VE <- that's where we started the
> discussion):
> 	- has almost no acceleration in XFree, including the 4.1.0 release
> 	- has Xv YUV->RGB acceleration in Gatos (but that's all, no direct
> 	  video input etc).

it has, but it is disabled as normally notebooks don't have video in. 
Well, some do but this is a grey area. ATI says there supposed to be a
multimedia table that says if you have a decoder on board - but some
manufacturers don't include it. In this case the driver cannot know
whether the decoder is present and disables the interface to avoid
lockups.

I imagine it is either using ZV port or VIP/MPP connector - I'll be happy
to help you to get it to work, provided you know the part that produces
video stream.

> 
> > The rest of Gatos is obviously more experimental, but the YUV code looks
> > quite sane.
> 
> Well, not quite... I've had several X lockups while using the YUV 
> acceleration code. Let's say one lockup per half an hour.

That's not supposed to happen - let me know what causes it.. what you are
using, etc..

> 
> Even the performances are controversial: with 320x240, I achieve 
> great performance with xawtv/meye driver, I can even use the hardware
> scaling facilities (well, the xawtv sources need a little hacking for
> that), but in 640x480 the framerate achieved with Xv is below the
> one I get by converting YUV->RGB in software...

You have to be careful here - you can't write to the framebuffer without 
waiting for engine to go idle. Otherwise it'll lockup.

> 
> But the main question remains: does the MotionEye camera support
> overlay or not ? It could be that it is connected to the feature
> connector of the ATI board for doing direct video input/output
> (but no X driver recognizes this connector today). The motion jpeg
> chip this camera is based on definately has a video output.

I can help you get this to work.

> 
> Or it could just be the application who gets YUV data from the chip
> then send it directly to the video board. Today this works, almost
> (because we need a patched X - read gatos - and a patched xawtv - in
> order to do scaling).

Try using xv_stream from ati_xv branch on gatos.

                           Vladimir Dergachev

> 
> Stelian.
> -- 
> Stelian Pop <stelian.pop@fr.alcove.com>
> |---------------- Free Software Engineer -----------------|
> | Alcôve - http://www.alcove.com - Tel: +33 1 49 22 68 00 |
> |------------- Alcôve, liberating software ---------------|
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 



Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265807AbRF2JaM>; Fri, 29 Jun 2001 05:30:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265803AbRF2J3w>; Fri, 29 Jun 2001 05:29:52 -0400
Received: from smtp.alcove.fr ([212.155.209.139]:4365 "EHLO smtp.alcove.fr")
	by vger.kernel.org with ESMTP id <S265802AbRF2J3m>;
	Fri, 29 Jun 2001 05:29:42 -0400
Date: Fri, 29 Jun 2001 11:29:04 +0200
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: volodya@mindspring.com
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.4.5-ac12] New Sony Vaio Motion Eye camera driver
Message-ID: <20010629112903.B30190@come.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
In-Reply-To: <E15A7os-0003e9-00@come.alcove-fr> <Pine.LNX.4.20.0106281504570.1132-100000@node2.localnet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.4i
In-Reply-To: <Pine.LNX.4.20.0106281504570.1132-100000@node2.localnet.net>; from volodya@mindspring.com on Thu, Jun 28, 2001 at 03:11:22PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2001 at 03:11:22PM -0400, volodya@mindspring.com wrote:

> I imagine it is either using ZV port or VIP/MPP connector - I'll be happy
> to help you to get it to work, provided you know the part that produces
> video stream.

This part is described in the chip's doc here:
	http://va.samba.org/picturebook/72002_E_.pdf

Look at the page 9 where the connections between the chip and
the video bus are described. The problem is that there are 2 possible
modes (ZV-port or Digital YC), and I'm not sure which one Sony
chose to use...

> > Well, not quite... I've had several X lockups while using the YUV 
> > acceleration code. Let's say one lockup per half an hour.
> 
> That's not supposed to happen - let me know what causes it.. what you are
> using, etc..

The lockups happen upon closing xawtv (used with xv output). Let's
say one time in ten runs... Then the X server is dead, but I can
still log in using the network and do whatever I want. But if I kill
the X server the whole system freezes hard.

> > but in 640x480 the framerate achieved with Xv is below the
> > one I get by converting YUV->RGB in software...
> 
> You have to be careful here - you can't write to the framebuffer without 
> waiting for engine to go idle. Otherwise it'll lockup.

??? That's not me, it's xawtv, through the XV facilities of the 
X server which writes to the framebuffer... Or maybe I don't 
understand the question...

Anyway, I've retested it with the latest ati.2 binaries and how
the 640x480 xv speed seems to have improved (or something in
my configuration changed, of course :-) ).

> > (but no X driver recognizes this connector today). The motion jpeg
> > chip this camera is based on definately has a video output.
> 
> I can help you get this to work.

I'd like to, thanks.

> > Or it could just be the application who gets YUV data from the chip
> > then send it directly to the video board. Today this works, almost
> > (because we need a patched X - read gatos - and a patched xawtv - in
> > order to do scaling).
> 
> Try using xv_stream from ati_xv branch on gatos.

It won't work out of the box either (it uses only v4l read calls and
doesn't support mmap, it assumes a capture size of 352x288 which this
camera does not support etc). But it should be easy to patch it and
make it work with this camera, just like I did with xawtv.

Stelian.

PS: this hasn't much to do with the kernel anymore, I suggest we
take this discussion off list now. I'm not sure neither if Linus
is really interested in getting a copy of this. :-)
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
|---------------- Free Software Engineer -----------------|
| Alcôve - http://www.alcove.com - Tel: +33 1 49 22 68 00 |
|------------- Alcôve, liberating software ---------------|

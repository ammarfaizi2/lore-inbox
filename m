Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269989AbUJVOP0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269989AbUJVOP0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 10:15:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269976AbUJVOOG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 10:14:06 -0400
Received: from smtp13.wxs.nl ([195.121.6.27]:41109 "EHLO smtp13.wxs.nl")
	by vger.kernel.org with ESMTP id S269962AbUJVONn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 10:13:43 -0400
Date: Fri, 22 Oct 2004 16:22:58 +0200
From: "Ronald S. Bultje" <rbultje@ronald.bitfreak.net>
Subject: Re: Linux 2.6.9-ac3
In-reply-to: <20041022133327.GD16963@sd291.sivit.org>
To: Luc Saillard <luc@saillard.org>
Cc: Xavier Bestel <xavier.bestel@free.fr>,
       Luca Risolia <luca.risolia@studio.unibo.it>,
       linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Message-id: <1098454978.2735.31.camel@tux.lan>
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2)
Content-type: text/plain
Content-transfer-encoding: 7BIT
References: <20041022101335.6dcf247a.luca.risolia@studio.unibo.it>
 <20041022092102.GA16963@sd291.sivit.org>
 <20041022143036.462742ca.luca.risolia@studio.unibo.it>
 <1098448494.31003.37.camel@gonzales> <20041022133327.GD16963@sd291.sivit.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luc,

On Fri, 2004-10-22 at 15:47, Luc Saillard wrote:
> I try gstreamer with amarok to play sound using alsa, and this does't work
> (segfault). Gstreamer seems too big to be the default for every applications,
> think that you can put a webcam on a top appliance, with little memory, space
> disk, and NO XML :-)

That is all possible. I understand that you don't want XML and such in
your embedded devices, and you don't want loadable modules, and you
basically want no bloat at all. To some extent, including all of the
above-mentioned, that is already possible using GStreamer. Some of us
(yes, I'm a GStreamer developer otherwise I wouldn't care to reply) have
worked on this in the past, and some of us are still working on
GStreamer-based solutions in embedded devices.

> > Luc Saillard <luc@saillard.org> wrote:
> > > I know this problem, but without a user API like ALSA, each driver need to
> > > implement the decompression module. When the driver will support v4l2, we can
> > > return the compressed stream to the user land. I want a v4l3, which is
> > > designed as ALSA does for soundcard, with a API for userland and kernelland.

It works for ALSA because audio is as simple as it gets. As soon as you
throw in some soundcard with no PCM support but only
my_nice_media_audio_format, it doesn't work. So seriously, tell me what
you'd need to make this work for video (and specifically all those
brands of webcams)?

* since webcams have custom compression algos, you need dynamically
loadable libraries and extendable type systems. OK, so since we're in
for embedded, we'll also need a very powerful system that can help us do
all this but suited for embedded.
* since people will want to touch every single detail, you will need a
lowlevel API which is basically a userspace wrapper around POSIX.
Doubtful.
* and of course a nice highlevel API for us weenies that don't get it.
* And because of the combination of the above taken (too bloated)
together with the fact that v4l2 is actually documented, pretty much
nobody will use it.
* so nobody will write plugins for his custom webcam format and well,
from here on you get the point: it won't work.
* did I mention how good fragmentation is for our public image to the
corporate world? :).

For more fun, read the video4linux-list@redhat.com archives. It's fun to
re-read flamewars from the past. Let's not redo them, it's a waste of
time.

Now, of course, you want a solution that will work for your particular
case, which appears to be some kind fo embedded thing with your specific
cam. So just use v4l2, implement a custom module in your embedded
application that decodes from the cam-format in userspace and you're
done! Oh, you want to use the cam in Gnome-Meeting? Then let's go for
the GStreamer-approach anyway, I don't think Gnome-Meeting cares about
XML. :).

Ronald

PS v4l3? Let's first port the remaining drivers (e.g. zr36120, qc-usb)
to v4l2, ok? :).

-- 
Ronald S. Bultje <rbultje@ronald.bitfreak.net>


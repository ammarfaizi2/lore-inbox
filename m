Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288174AbSBIXcx>; Sat, 9 Feb 2002 18:32:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288308AbSBIXco>; Sat, 9 Feb 2002 18:32:44 -0500
Received: from pD9EB697D.dip.t-dialin.net ([217.235.105.125]:135 "EHLO
	oenone.homelinux.org") by vger.kernel.org with ESMTP
	id <S288174AbSBIXcf>; Sat, 9 Feb 2002 18:32:35 -0500
Message-Id: <200202100032.g1A0WGX06570@oenone.homelinux.org>
Content-Type: text/plain; charset=US-ASCII
From: Oliver Neukum <oliver@neukum.org>
To: Gerd Knorr <kraxel@bytesex.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH/RFC] videodev.[ch] redesign
Date: Sun, 10 Feb 2002 01:32:15 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <20020209194602.A23061@bytesex.org> <200202092053.g19KrSN05200@oenone.homelinux.org> <slrna6b2gn.nnn.kraxel@bytesex.org>
In-Reply-To: <slrna6b2gn.nnn.kraxel@bytesex.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 09 February 2002 21:44, Gerd Knorr wrote:
> > > It also provides a ioctl wrapper function which handles copying the
> > > ioctl args from/to userspace, so we have this at one place can drop all
> > > the copy_from/to_user calls within the v4l device driver ioctl
> > > handlers.
> >
> >  That is a large improvement.
> >  But you don't include a lock against reentry, which is bad.
>
> I don't want to handle the wrapper function too much.  IMHO it is the
> job of the driver to do locking if needed.  For some read-only ioctls
> like VIDIOCGCAP you don't need locking at all.

OK.

> > > Comments?
> >
> >  Could you make a helper for open like for ioctl ?
>
> video_open does call video_device[minor]->fops->open(), isn't that
> enought?

I'd prefer seeing exclusive opening handeled in the helper initially.

> >  And please don't use a pointer to the device descriptor
> >  in the file structure. It makes live for USB devices much harder.
>
> Sorry, I don't understand.  What exactly do you mean?
> file->private_data?  videodev.c doesn't touch it ...

But the skeleton driver you provide does so.

	Regards
		Oliver

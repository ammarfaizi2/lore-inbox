Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289369AbSBJJKa>; Sun, 10 Feb 2002 04:10:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289385AbSBJJKW>; Sun, 10 Feb 2002 04:10:22 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:6157 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP
	id <S289369AbSBJJKE>; Sun, 10 Feb 2002 04:10:04 -0500
X-Envelope-From: news@bytesex.org
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Gerd Knorr <kraxel@bytesex.org>
Newsgroups: lists.linux.kernel
Subject: Re: [PATCH/RFC] videodev.[ch] redesign
Date: 10 Feb 2002 08:34:09 GMT
Organization: SuSE Labs, =?ISO-8859-1?Q?Au=DFenstelle?= Berlin
Message-ID: <slrna6cc41.ret.kraxel@bytesex.org>
In-Reply-To: <20020209194602.A23061@bytesex.org> <200202092053.g19KrSN05200@oenone.homelinux.org> <slrna6b2gn.nnn.kraxel@bytesex.org> <200202100032.g1A0WGX06570@oenone.homelinux.org>
NNTP-Posting-Host: localhost
X-Trace: bytesex.org 1013330049 28164 127.0.0.1 (10 Feb 2002 08:34:09 GMT)
User-Agent: slrn/0.9.7.1 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > >  Could you make a helper for open like for ioctl ?
> >
> > video_open does call video_device[minor]->fops->open(), isn't that
> > enought?
>  
>  I'd prefer seeing exclusive opening handeled in the helper initially.

Ok, I see what you mean.  That was another issue I was thinking about.
Current videodev.c allows one open at a time only, the new code removes
that restriction (intentionally).

Should videodev.c provide a way to ask for exclusive opens to maintain
backward compatibility, using some flag in struct video_device maybe?
Is there some sane way to do this without having to hook into
fops->release?  Checking inode->i_count maybe?

> > Sorry, I don't understand.  What exactly do you mean?
> > file->private_data?  videodev.c doesn't touch it ...
>  
>  But the skeleton driver you provide does so.

Thats just some sample code, a dummy driver which does nothing but print
some messages to the log.  If you want allow multiple applications
access the driver at the same you need some way to disturgish the file
handles, and skeleton.c demonstrates how this can be done using
file->private_data.

usb drivers are free to do with file->private_data whatever they want
(like skeleton.c does), videodev.c doesn't use it.

  Gerd

-- 
#define	ENOCLUE 125 /* userland programmer induced race condition */

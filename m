Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287840AbSBIWAP>; Sat, 9 Feb 2002 17:00:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287908AbSBIWAG>; Sat, 9 Feb 2002 17:00:06 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:18698 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP
	id <S287895AbSBIWAE>; Sat, 9 Feb 2002 17:00:04 -0500
X-Envelope-From: news@bytesex.org
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Gerd Knorr <kraxel@bytesex.org>
Newsgroups: lists.linux.kernel
Subject: Re: [PATCH/RFC] videodev.[ch] redesign
Date: 9 Feb 2002 20:44:07 GMT
Organization: SuSE Labs, =?ISO-8859-1?Q?Au=DFenstelle?= Berlin
Message-ID: <slrna6b2gn.nnn.kraxel@bytesex.org>
In-Reply-To: <20020209194602.A23061@bytesex.org> <200202092053.g19KrSN05200@oenone.homelinux.org>
NNTP-Posting-Host: localhost
X-Trace: bytesex.org 1013287447 24328 127.0.0.1 (9 Feb 2002 20:44:07 GMT)
User-Agent: slrn/0.9.7.1 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > It also provides a ioctl wrapper function which handles copying the
> > ioctl args from/to userspace, so we have this at one place can drop all
> > the copy_from/to_user calls within the v4l device driver ioctl handlers.
>  
>  That is a large improvement.
>  But you don't include a lock against reentry, which is bad.

I don't want to handle the wrapper function too much.  IMHO it is the
job of the driver to do locking if needed.  For some read-only ioctls
like VIDIOCGCAP you don't need locking at all.

> > Comments?
>  
>  Could you make a helper for open like for ioctl ?

video_open does call video_device[minor]->fops->open(), isn't that
enought?

>  And please don't use a pointer to the device descriptor
>  in the file structure. It makes live for USB devices much harder.

Sorry, I don't understand.  What exactly do you mean?
file->private_data?  videodev.c doesn't touch it ...

  Gerd

-- 
#define	ENOCLUE 125 /* userland programmer induced race condition */

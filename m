Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293749AbSB1U6w>; Thu, 28 Feb 2002 15:58:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293745AbSB1U5Y>; Thu, 28 Feb 2002 15:57:24 -0500
Received: from gate.perex.cz ([194.212.165.105]:32261 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id <S293740AbSB1U5M>;
	Thu, 28 Feb 2002 15:57:12 -0500
Date: Thu, 28 Feb 2002 21:56:09 +0100 (CET)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: <perex@pnote.perex-int.cz>
To: Roman Zippel <zippel@linux-m68k.org>
cc: Pavel Machek <pavel@suse.cz>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Patch - sharing RTC timer between kernel and user space
In-Reply-To: <Pine.LNX.4.21.0202281535380.24187-100000@serv>
Message-ID: <Pine.LNX.4.33.0202282155450.543-100000@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Feb 2002, Roman Zippel wrote:

> Hi,
> 
> On Thu, 28 Feb 2002, Jaroslav Kysela wrote:
> 
> > Using the RTC timer is optional. The default timer is system timer, of 
> > course.
> 
> Who is setting up this timer? This patch can also be done in userspace:
> 
> 	fd = open("/dev/rtc",...);
> 	ioctl(alsafd, RTCFD, fd);
> 
> in the alsa driver you can do:
> 
> 	file = fget(fd);
> 	...
> 	if (file->f_op && file->f_op->ioctl)
> 		file->f_op->ioctl(file->f_dentry->d_inode, file, cmd, arg);
> 	...
> 	fput(file);

We need also a callback called at interrupt time.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com


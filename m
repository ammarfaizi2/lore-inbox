Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293206AbSB1OtJ>; Thu, 28 Feb 2002 09:49:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293354AbSB1Oqd>; Thu, 28 Feb 2002 09:46:33 -0500
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:55566 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S293349AbSB1OnM>; Thu, 28 Feb 2002 09:43:12 -0500
Date: Thu, 28 Feb 2002 15:43:05 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
To: Jaroslav Kysela <perex@suse.cz>
cc: Pavel Machek <pavel@suse.cz>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Patch - sharing RTC timer between kernel and user space
In-Reply-To: <Pine.LNX.4.33.0202281224030.539-100000@pnote.perex-int.cz>
Message-ID: <Pine.LNX.4.21.0202281535380.24187-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 28 Feb 2002, Jaroslav Kysela wrote:

> Using the RTC timer is optional. The default timer is system timer, of 
> course.

Who is setting up this timer? This patch can also be done in userspace:

	fd = open("/dev/rtc",...);
	ioctl(alsafd, RTCFD, fd);

in the alsa driver you can do:

	file = fget(fd);
	...
	if (file->f_op && file->f_op->ioctl)
		file->f_op->ioctl(file->f_dentry->d_inode, file, cmd, arg);
	...
	fput(file);

bye, Roman


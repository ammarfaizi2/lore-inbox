Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268129AbTBMWuR>; Thu, 13 Feb 2003 17:50:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268310AbTBMWtV>; Thu, 13 Feb 2003 17:49:21 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:1296 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S268311AbTBMWsp>; Thu, 13 Feb 2003 17:48:45 -0500
Date: Thu, 13 Feb 2003 14:54:54 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Davide Libenzi <davidel@xmailserver.org>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Synchronous signal delivery..
In-Reply-To: <Pine.LNX.4.50.0302131420200.1869-100000@blue1.dev.mcafeelabs.com>
Message-ID: <Pine.LNX.4.44.0302131452450.4232-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 13 Feb 2003, Davide Libenzi wrote:
> 
> It does not have necessarily to be just another ioctl/fcntl, it can be a
> write. About security, chages might be allowed only to the task that
> created the fd, if you're concerned. It's not that someone will starve
> w/out such functionality though.

I'd actually like to reserve writes to _sending_ signals. Especially if 
you have another process that listens in on the signals you get, it might 
want to also force the signals through.

> > One of the reasons for the "flags" field (which is not unused) was because
> > I thought it might have extensions for things like alarms etc.
> 
> I was thinking more like :
> 
> int timerfd(int timeout, int oneshot);

It could be a separate system call, but since the infrastructure is 
hopefully identical (most of the sigfd() code is actually creating the fs 
infrastructure to get an inode with the information), it should share a 
lot of the paths. Maybe even the system call.

		Linus


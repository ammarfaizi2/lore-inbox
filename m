Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290445AbSA3Sqg>; Wed, 30 Jan 2002 13:46:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290419AbSA3SpC>; Wed, 30 Jan 2002 13:45:02 -0500
Received: from nat-pool-meridian.redhat.com ([12.107.208.200]:12699 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S290309AbSA3SYW>; Wed, 30 Jan 2002 13:24:22 -0500
Date: Wed, 30 Jan 2002 13:24:22 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200201301824.g0UIOMO32639@devserv.devel.redhat.com>
To: raul@viadomus.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Why 'linux/fs.h' cannot be included? I *can*...
In-Reply-To: <mailman.1012391761.28301.linux-kernel2news@redhat.com>
In-Reply-To: <mailman.1012391761.28301.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>     The problem is that I don't want to copy the definitions I need
> from linux/fs.h, because this will lead to problems if those
> definitions change.

This is a common misconception. Traditional UNIX operates
this way, indeed. They do "make world" and build everything
in one go, so programs are automatically compatible with
the kernel (in theory, anyways). Once programs outside
of "make world" start to need access to these interfaces,
the scheme crumbles to the ground.

Linus (and thus Linux) consciously decided that this
so-called "souce compatibility" is a mirage. Only binary
compatibility matters. So, you must copy headers that
you wish to use, including linux/fs.h. Then, your program
is binary compatible with the kernel from which you took
them. New kernels may support your program by providing
the same interface, and they may have NO linux/fs.h
at all. If you included headers, you would not be
able to compile your program at all, but the old binary
would continue to work, and copied headers would continue
to work.

Those who come from UNIX background keep insisting to
include kernel headers, especially when they write
drivers with ioctl argument structures. But there is
no other way for them, but to educate themselves in
the Linux lore. Kernel headers are not to be included
in applications.

-- Pete

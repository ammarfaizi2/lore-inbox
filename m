Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267829AbUJTVcd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267829AbUJTVcd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 17:32:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268646AbUJTVah
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 17:30:37 -0400
Received: from h-68-165-86-241.dllatx37.covad.net ([68.165.86.241]:24637 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S267829AbUJTVWl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 17:22:41 -0400
Subject: Re: belkin usb serial converter (mct_u232), break not working
From: Paul Fulghum <paulkf@microgate.com>
To: Thomas Stewart <thomas@stewarts.org.uk>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200410201946.35514.thomas@stewarts.org.uk>
References: <200410201946.35514.thomas@stewarts.org.uk>
Content-Type: text/plain
Message-Id: <1098307331.2818.15.camel@deimos.microgate.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 20 Oct 2004 16:22:11 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-10-20 at 13:46, Thomas Stewart wrote:
> I'm having trouble with a Belkin USB serial adapter, I can't get it to send a 
> break down the serial cable to a console.
> 
> I made a quick program to send a break to a port (mostly ripped off from 
> minicom). 
> 
> porttest.c:
> #include <sys/fcntl.h>
> #include <sys/ioctl.h>
> main () {
>         int fd = open("/dev/ttyS0", O_RDWR|O_NOCTTY);
>         ioctl(fd, TCSBRK, 0);
>         close(fd);
> }
> 
> Both minicom and my program send a break fine to a regular pc serial port (eg 
> ttyS0). In this case it drops my sun box to an "ok" prompt.
> 
> However if I use the usb serial adapter both minicom and my program are unable 
> to send breaks, they just seem to get ignored.

I was too quick (and wrong!) on my previous response.
I was thinking of TIOCSBRK (turn on break and leave on),
not TCSBRK (turn on break for ~250ms).

My suggestion about timing may still be valid.

Try replacing ioctl(fd, TCSBRK, 0) with
ioctl(fd, TCSBRKP, duration)
duration is in 100ms units, so try 10 or 20.

Or you can use tcsendbreak(fd, duration);
I'm not sure of the units for this function on Linux
manpage says 'implementation defined',
a book I have says 250ms units in Linux.

-- 
Paul Fulghum
paulkf@microgate.com


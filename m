Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270564AbUJTU7k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270564AbUJTU7k (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 16:59:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270578AbUJTUyq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 16:54:46 -0400
Received: from h-68-165-86-241.dllatx37.covad.net ([68.165.86.241]:1852 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S269908AbUJTUsr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 16:48:47 -0400
Subject: Re: belkin usb serial converter (mct_u232), break not working
From: Paul Fulghum <paulkf@microgate.com>
To: Thomas Stewart <thomas@stewarts.org.uk>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200410201946.35514.thomas@stewarts.org.uk>
References: <200410201946.35514.thomas@stewarts.org.uk>
Content-Type: text/plain
Message-Id: <1098305293.2818.2.camel@deimos.microgate.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 20 Oct 2004 15:48:13 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-10-20 at 13:46, Thomas Stewart wrote:
> Hi,
> 
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

Could this be a simple matter of timing?

The Sun box may require a break for a certain period
which by chance is met on a standard UART but not
the USB serial adapter.

Try adding a sleep() after the ioctl call to delay
before clearing the break condition.

-- 
Paul Fulghum
paulkf@microgate.com


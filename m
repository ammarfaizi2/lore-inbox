Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269083AbUIXSx0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269083AbUIXSx0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 14:53:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269090AbUIXSxZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 14:53:25 -0400
Received: from h-68-165-86-241.dllatx37.covad.net ([68.165.86.241]:3688 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S269083AbUIXSxV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 14:53:21 -0400
Subject: Re: 2.6.9-rc2-mm3
From: Paul Fulghum <paulkf@microgate.com>
To: James Morris <jmorris@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <Xine.LNX.4.44.0409241210220.8009-100000@thoron.boston.redhat.com>
References: <Xine.LNX.4.44.0409241210220.8009-100000@thoron.boston.redhat.com>
Content-Type: text/plain
Message-Id: <1096051977.1938.5.camel@deimos.microgate.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 24 Sep 2004 13:52:57 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-09-24 at 11:16, James Morris wrote:
> On Fri, 24 Sep 2004, James Morris wrote:
> 
> > I'm getting what looks like a deadlock during boot with this kernel, 
> > .config, bootlog and sysrq output attached.  Looks like it may be related 
> > to the serial/tty code?
> 
> Backing these out lets me boot again:
> 
> +tty-driver-take-4-try-2.patch
> +tty-locking-build-fix.patch
...
>  [<c026b3a4>] tty_termios_baud_rate+0x11/0x67
>  [<c027f485>] uart_get_baud_rate+0x53/0xd4
>  [<c0283af1>] serial8250_set_termios+0x8d/0x348
>  [<c027f580>] uart_change_speed+0x4a/0x64
>  [<c0280664>] uart_set_termios+0x4f/0x162
>  [<c026e94f>] change_termios+0x1b3/0x21a
>  [<c026ea40>] set_termios+0x8a/0xf9
>  [<c026ad15>] tty_ioctl+0x152/0x44f
>  [<c0169687>] sys_ioctl+0x231/0x282
>  [<c0105d09>] sysenter_past_esp+0x52/0x71

I am seeing this deadlock also.

tty_termios_lock is acquired in change_termios(), tty_ioctl.c

change_termios() calls the driver set_termios callback
which in turn calls tty_termios_baud_rate(), tty_io.c
which tries to acquire the lock again.

-- 
Paul Fulghum
paulkf@microgate.com


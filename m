Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268026AbUHKLZR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268026AbUHKLZR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 07:25:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268024AbUHKLZR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 07:25:17 -0400
Received: from chaos.analogic.com ([204.178.40.224]:26257 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S268026AbUHKLZJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 07:25:09 -0400
Date: Wed, 11 Aug 2004 07:24:42 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Erik Mouw <erik@harddisk-recovery.com>
cc: Paul Jackson <pj@sgi.com>, Eric Masson <cool_kid@future-ericsoft.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Fork and Exec a process within the kernel
In-Reply-To: <20040811095139.GA10047@harddisk-recovery.com>
Message-ID: <Pine.LNX.4.53.0408110721540.15879@chaos>
References: <4117E68A.4090701@future-ericsoft.com> <20040809161003.554a5de1.pj@sgi.com>
 <4118E822.3000303@future-ericsoft.com> <20040810092116.7dfe118c.pj@sgi.com>
 <Pine.LNX.4.53.0408101456260.13579@chaos> <20040811095139.GA10047@harddisk-recovery.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Aug 2004, Erik Mouw wrote:

> On Tue, Aug 10, 2004 at 03:03:08PM -0400, Richard B. Johnson wrote:
> > /dev/console is a symlink to /dev/tty0.
>
> Please don't mislead newbies, Richard. /dev/console is NOT a link to
> /dev/tty0, it's a completely different device:
>
> erik@abra2:~ >ls -l /dev/console
> crw-------    1 root     tty        5,   1 Apr  7 09:13 /dev/console
> erik@abra2:~ >ls -l /dev/tty0
> crw-------    1 root     tty        4,   0 Feb 10  2000 /dev/tty0
>

Bullshit. I know how to use `file`.

Script started on Wed Aug 11 07:21:39 2004
# file /dev/console
/dev/console: symbolic link to /dev/tty0
# exit
Script done on Wed Aug 11 07:21:51 2004


> On x86 desktop systems console output usually comes on the virtual
> terminals, but you can also use serial console. My embedded StrongARM
> board only has serial console.
>

Then that's your problem.


> >     struct termios term;
> >
> >     tcgetattr(0, &term);	// Get old terminal characteristics
> >     (void)close(0);		// Close old terminal(s)
> >     (void)close(1);
> >     (void)close(2);
> >     fd = open("/dev/console", O_RDWR);
>
> And what happens when you have console on a device that's not a serial
> port like a line printer?
>
>
> Erik
>

It will still work but there is no input and it can't be turned
into a "controlling terminal".


Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5570.56 BogoMips).
            Note 96.31% of all statistics are fiction.



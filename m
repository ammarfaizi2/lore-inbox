Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268034AbUHKL4f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268034AbUHKL4f (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 07:56:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268033AbUHKL4d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 07:56:33 -0400
Received: from chaos.analogic.com ([204.178.40.224]:29841 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S268032AbUHKL43
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 07:56:29 -0400
Date: Wed, 11 Aug 2004 07:55:52 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Erik Mouw <erik@harddisk-recovery.com>
cc: Paul Jackson <pj@sgi.com>, Eric Masson <cool_kid@future-ericsoft.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Fork and Exec a process within the kernel
In-Reply-To: <20040811114100.GB10047@harddisk-recovery.nl>
Message-ID: <Pine.LNX.4.53.0408110743020.15953@chaos>
References: <4117E68A.4090701@future-ericsoft.com> <20040809161003.554a5de1.pj@sgi.com>
 <4118E822.3000303@future-ericsoft.com> <20040810092116.7dfe118c.pj@sgi.com>
 <Pine.LNX.4.53.0408101456260.13579@chaos> <20040811095139.GA10047@harddisk-recovery.com>
 <Pine.LNX.4.53.0408110721540.15879@chaos> <20040811114100.GB10047@harddisk-recovery.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Aug 2004, Erik Mouw wrote:

> On Wed, Aug 11, 2004 at 07:24:42AM -0400, Richard B. Johnson wrote:
> > On Wed, 11 Aug 2004, Erik Mouw wrote:
> > > Please don't mislead newbies, Richard. /dev/console is NOT a link to
> > > /dev/tty0, it's a completely different device:
> > >
> > > erik@abra2:~ >ls -l /dev/console
> > > crw-------    1 root     tty        5,   1 Apr  7 09:13 /dev/console
> > > erik@abra2:~ >ls -l /dev/tty0
> > > crw-------    1 root     tty        4,   0 Feb 10  2000 /dev/tty0
> > >
> >
> > Bullshit. I know how to use `file`.
> >
> > Script started on Wed Aug 11 07:21:39 2004
> > # file /dev/console
> > /dev/console: symbolic link to /dev/tty0
>
> It might be a symlink on your machine, but that doesn't mean it's the
> right way. For almost 7 years, /dev/console is a separate device, not a
> symlink. Here's the relevant section from Documentation/devices.txt:
>
>   The console device, /dev/console, is the device to which system
>   messages should be sent, and on which logins should be permitted in
>   single-user mode.  Starting with Linux 2.1.71, /dev/console is managed
>   by the kernel; for previous versions it should be a symbolic link to
>   either /dev/tty0, a specific virtual console such as /dev/tty1, or to
>   a serial port primary (tty*, not cu*) device, depending on the
>   configuration of the system.
>
> Linux-2.1.71 was released on December 4, 1997. In your signature you
> claim to run linux-2.4.26. Please update your system.
>
>
> Erik

RedHat is NOT Linux. The MAJOR-MINOR 5.1 used in RedHat for the
console has a very serious problem for anybody doing development
work. If there are any kernel messages, they go to __all__ open
terminals. This means that the only "quiet" terminals that may be
available to kill off a runaway process are available iff you can
log in over the network.

Most everybody I know, who does serious development work, and
certainly those who want to control where the %*)&$#!@ kernel
messages go, will make sure they go to the "ALT-F1" as I have
shown. The original query was about how to make kernel messages
go to where, i.e., what VT do they come from. I have shown
how you can control where they go.

Now, if you look at the kernel source, you will note that
just prior to attempting to exec /sbin/init, /dev/console
is opened. This means that you can properly use whatever
you want if you continue to use a sym-link.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5570.56 BogoMips).
            Note 96.31% of all statistics are fiction.



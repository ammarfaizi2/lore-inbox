Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262667AbUCOX1a (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 18:27:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262649AbUCOX1a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 18:27:30 -0500
Received: from chaos.analogic.com ([204.178.40.224]:21388 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262667AbUCOXXA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 18:23:00 -0500
Date: Mon, 15 Mar 2004 18:26:35 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Kevin Leung <sac98993@hotmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: your mail
In-Reply-To: <Law9-F89Xsn2Yf0scL90004e4c8@hotmail.com>
Message-ID: <Pine.LNX.4.53.0403151813590.2223@chaos>
References: <Law9-F89Xsn2Yf0scL90004e4c8@hotmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Mar 2004, Kevin Leung wrote:

> Hello All,
>
> I am very new to Linux and am working on a project. The nature of the
> project is to essentially record all process/thread scheduling activity for
> use in a later application. I wanted to know if any experts out there knew
> of any libraries that could essentially "monitor" or "listen" for any
> scheduling changes made. For instance if the kernel decides to set process A
> from "sleeping" to "running" and process B from "running" to "sleeping", I
> wanted to know if there was a function that could generate an immediate
> notification of this event.

No. FYI, there are hundreds-of-thousands of such "events" per second
of operation! Basically, any time some task is waiting for I/O its
CPU is taken away and given to somebody else. This is what "sleeping"
usually means. Once the I/O completes, the task gets the CPU
again and that's what "running" means. If you were to instrument
these two state-changes for all tasks, it would certainly leave
only a new percent of CPU available for the tasks. This would
royally screw up the meaning of anything you were trying to
instrument.

> Priority change information is also desireable.

If you mean the dynamic priority that keeps changing until
the task is executed, no. If you mean priority like
'nice', you can instrument the sys-call.

> The more aspects which trigger notificaiton, the better. As a first attempt,

There is a kernel logging daemon that writes 'printk' messages. This
works by having a user-mode daemon open and read /proc/kmsg. You can
make a similar communications interface, using the existing daemon
as a template, that will instrument anything you want.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.



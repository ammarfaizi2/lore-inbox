Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261899AbTDIAyY (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 20:54:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261903AbTDIAyY (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 20:54:24 -0400
Received: from chaos.analogic.com ([204.178.40.224]:10373 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261899AbTDIAyW (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Apr 2003 20:54:22 -0400
Date: Tue, 8 Apr 2003 21:10:01 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Dan Kegel <dank@kegel.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: fsync() on unix domain sockets?
In-Reply-To: <3E934DB7.1000503@kegel.com>
Message-ID: <Pine.LNX.4.53.0304082101020.26881@chaos>
References: <3E934DB7.1000503@kegel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Apr 2003, Dan Kegel wrote:

> Let's say someone had written a win32 emulator that
> ran in userspace, and was using unix domain sockets
> to emulate win32 named pipes.  (Yes, this is how
> Wine does it at the moment, but it's a poor fit,
> and they're thinking of switching to emulating them 100%
> in userspace so they can get the semantics right.)
>

[SNIPPED...]

What problem are you attempting to fix? You will never find
any unflushed buffers in Unix Domain sockets because you need
an active reader before the write will succeed. The writer will
block until the reader has all the data. That's why they are
used for synchronization. Of course you don't know that the
reader has actually used the data, that's why you use semiphores
or other synchronizing elements. Unlike network sockets, where
the kernel just promises it will eventually get the data to a
connected socket, Unix domain sockets don't return control to
the writer until the reader has read the data.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.


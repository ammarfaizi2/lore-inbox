Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267125AbUBMQtP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 11:49:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267126AbUBMQtP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 11:49:15 -0500
Received: from chaos.analogic.com ([204.178.40.224]:1152 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S267125AbUBMQtH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 11:49:07 -0500
Date: Fri, 13 Feb 2004 11:48:57 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: RANDAZZO@ddc-web.com
cc: linux-kernel@vger.kernel.org
Subject: Re: spinlocks dont work
In-Reply-To: <89760D3F308BD41183B000508BAFAC4104B16F6F@DDCNYNTD>
Message-ID: <Pine.LNX.4.53.0402131137180.488@chaos>
References: <89760D3F308BD41183B000508BAFAC4104B16F6F@DDCNYNTD>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Feb 2004 RANDAZZO@ddc-web.com wrote:

> On my uniprocessor system, I have two LKM's
>
> driver1 takes hold of the spinlock....but does not release it...
> driver2 attempts to take hold, and is allowed!!!!
> how come spin locks don't work?????
> how can I restrict access (to hardware) to only one driver at a time???
> should I use semaphores,  etc...
>

Spin-locks do work. However, you need to use the same lock-object
for each execution path. A common error is to do:

static spinlock_t device_lock;

... in one file, and...

static spinlock_t device_lock;

... in another...

There is also a possibility that the kernel you are using does not
impliment spin-locks if it's not compiled for SMP. To make sure,
compile your uniprocessor machine for SMP.

Basically, you use semaphores when the particular execution path
can sleep, and spin-locks when they can't. You can never sleep
in an ISR, so you need to use spin-lock protection where something
could change as a result of an interrupt.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.



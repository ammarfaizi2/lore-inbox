Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262111AbUKJTk7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262111AbUKJTk7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 14:40:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262114AbUKJTk7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 14:40:59 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:64977 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262111AbUKJTi5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 14:38:57 -0500
Subject: Re: 2.4 virtual terminal timing
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Tom Schouten <doelie@zzz.kotnet.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041110125828.GB15767@zzz.i>
References: <20041110125828.GB15767@zzz.i>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1100111756.20556.21.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 10 Nov 2004 18:35:58 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2004-11-10 at 12:58, Tom Schouten wrote:
> i am trying to find out if there is a direct path in 2.4.x from
> keyboard interrupt, through console/tty stuff to process wakeup,
> for a 2 thread process with one thread blocking on tty read, 
> running SCHED_FIFO, or a single thread process with async IO.
> 

You hit the keyboard. A microcontroller with a brain the size of a pea
sits around for a bit works out what you hit and we get an interrupt.
After
that it sends it slowly over a serial link to the PC.

The tty driver figures out the characters and sends them down to the
line discipline layer. The line discipline will wake the user process
from that event.

At least in 2.6 the tty driver isn't doing batching for keyboard
commands that I can see so it ought to be reasonably quick.


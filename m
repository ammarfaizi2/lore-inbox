Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261939AbTKHS3C (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Nov 2003 13:29:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261959AbTKHS3C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Nov 2003 13:29:02 -0500
Received: from fw.osdl.org ([65.172.181.6]:37534 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261939AbTKHS3B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Nov 2003 13:29:01 -0500
Date: Sat, 8 Nov 2003 10:28:34 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Denis <vda@port.imtp.ilyichevsk.odessa.ua>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       George Anzinger <george@mvista.com>
Subject: Re: 2.6-test6: nanosleep+SIGCONT weirdness
In-Reply-To: <200311081946.28808.vda@port.imtp.ilyichevsk.odessa.ua>
Message-ID: <Pine.LNX.4.44.0311081022030.2240-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 8 Nov 2003, Denis wrote:
>
> I observe some strange behaviour in 2.6-test6 with this small program:

Good catch.

That nanosleep restart seems to be broken, and quite frankly, looking at 
the mess in kernel/posix-timers.c I'm not all that surprised. The code is 
total and absolute crap. I have no idea how it's even supposed to work.

I suspect that it might just work right if you disable the nanosleep stuff 
by undefining FOLD_NANO_SLEEP_INTO_CLOCK_NANO_SLEEP in <linux/signal.h>. 
Because unlike the "folded" version in posix-timers.c, the original 
version at least looks sane.

		Linus


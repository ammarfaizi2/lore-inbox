Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262212AbSJAShw>; Tue, 1 Oct 2002 14:37:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262213AbSJAShw>; Tue, 1 Oct 2002 14:37:52 -0400
Received: from mx2.elte.hu ([157.181.151.9]:26332 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S262212AbSJAShv>;
	Tue, 1 Oct 2002 14:37:51 -0400
Date: Tue, 1 Oct 2002 20:52:07 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] Workqueue Abstraction, 2.5.40-H7
In-Reply-To: <3D99E3C0.5010604@pobox.com>
Message-ID: <Pine.LNX.4.44.0210012022150.13515-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 1 Oct 2002, Jeff Garzik wrote:

> I still think that schedule_work() should have void* cookie passed to it
> directly, instead of at INIT_WORK time [and possibly changing it by hand
> in the driver, immediately before schedule_work() is called]

i dont think this is a good idea, this pretty much forces the argument 
passing upon every user of the interface - which argument would be put 
into the worqueue-entry struct anyway.

the code behaves just right when only PREPARE_WORK() is used - the
completion code leaves the entry in a restartable state. A full 
INIT_WORK() is only needed at init time. (or if DECLARE_WORK() was used 
then no INIT_WORK() is needed.) And this is all intentional.

> For drivers that pass an interface pointer like struct net_device*,
> INIT_WORK-time, the current scheme is fine, but when the cookie
> fluctuates more, it makes a lot more sense to pass void* to
> schedule_work() itself.

these places should use PREPARE_WORK().

	Ingo


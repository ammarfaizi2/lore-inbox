Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136665AbREAROI>; Tue, 1 May 2001 13:14:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136666AbREARN6>; Tue, 1 May 2001 13:13:58 -0400
Received: from chiara.elte.hu ([157.181.150.200]:58888 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S136665AbREARNu>;
	Tue, 1 May 2001 13:13:50 -0400
Date: Tue, 1 May 2001 19:12:16 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Fabio Riccardi <fabio@chromium.com>
Cc: <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Christopher Smith <x@xman.org>, Andrew Morton <andrewm@uow.edu.au>,
        "Timothy D. Witham" <wookie@osdlab.org>, <David_J_Morse@Dell.com>
Subject: Re: X15 alpha release: as fast as TUX but in user space
In-Reply-To: <3AEEEE1D.F0C4F1F6@chromium.com>
Message-ID: <Pine.LNX.4.33.0105011906420.2202-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 1 May 2001, Fabio Riccardi wrote:

> This is actually a bug in the current X15, I know how to fix it (with
> negligible overhead) but I've been lazy :)

yep, i think it's pretty straightforward: you have a cache of open file
descriptors (like Squid i think), and you can start a background 'cache
synchronization thread' that does a stat() on every open file's real VFS
path, every second or so. This should have small overhead (the number of
file descriptors cached should be limited anyway via some sort of LRU),
and guarantees 'practical coherency', without having the overhead of
immediate coherency. [total coherency is pointless anyway, not even the
kernel guarantees it to all parallel VFS users.]

	Ingo


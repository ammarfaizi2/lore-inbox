Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263740AbUECPGe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263740AbUECPGe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 11:06:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263702AbUECPGe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 11:06:34 -0400
Received: from firewall.conet.cz ([213.175.54.250]:43158 "EHLO conet.cz")
	by vger.kernel.org with ESMTP id S263740AbUECPGa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 11:06:30 -0400
Date: Mon, 3 May 2004 17:06:06 +0200
From: Libor Vanek <libor@conet.cz>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Read from file fails
Message-ID: <20040503150606.GB6411@Loki>
References: <20040503000004.GA26707@Loki> <Pine.LNX.4.53.0405030852220.10896@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0405030852220.10896@chaos>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I will explain for the Nth time. The kernel is a bunch of code
> that performs functions on behalf of a process. It does that in
> the context of that process. A file descriptor is a number that
> belongs to a process. It is worthless without a process with which
> to associate. If the kernel were to open a file, who owns the
> file descriptor? The kernel isn't a process, it's a big LIBRARY!

OK - speaking of this I just want call one public (exported) function of library from another.

> So, if you are lucky, you can steal the context from another
> unknowing process. This works unless there was a context-switch or
> if the process was asleep so it didn't access any files of
> its own. It leaves the kernel in a bad state because there
> is a wild file-descriptor that nobody owns that will never be
> closed because when your cludge closes that file-descriptor, you
> probably end up closing STDOUT_FILENO of some important task
> that you haven't discovered yet.
> 
> The cludges that work involve creating a "kernel thread" which
> has a process context. That thread does the file I/O. However,
> it's certainly easier to create a user-mode task (program) that
> opens your module and, using an ioctl(), sends it anything from
> anywhere in the known universe. You can get data from a file or
> from anywhere.

OK - so speaking of kernel thread - what function should I use? Or do you think that only the difference of having process context and pid will cause read to work? (I'm willing to believe it ;-) - I'll try it later)

I think there are reasons (speed, speed, speed...)  why some things should be done kernel-space. And I think that this is one of them. I know that I'll never want to "send data from anywhere in the known universe" (famous last words?) - I just need to create backup copy of file.


Libor




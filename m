Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261484AbTJ1UQc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 15:16:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261692AbTJ1UQc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 15:16:32 -0500
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:6919 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S261484AbTJ1UQa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 15:16:30 -0500
Subject: Re: [pm] fix time after suspend-to-*
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Pavel Machek <pavel@suse.cz>
Cc: Patrick Mochel <mochel@osdl.org>, George Anzinger <george@mvista.com>,
       John stultz <johnstul@us.ibm.com>,
       kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20031028172818.GB2307@elf.ucw.cz>
References: <Pine.LNX.4.44.0310271535160.13116-100000@cherise>
	 <1067329994.861.3.camel@teapot.felipe-alfaro.com>
	 <20031028093233.GA1253@elf.ucw.cz>
	 <1067351431.1358.11.camel@teapot.felipe-alfaro.com>
	 <20031028172818.GB2307@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1067372182.864.11.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-5) 
Date: Tue, 28 Oct 2003 21:16:23 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-10-28 at 18:28, Pavel Machek wrote:

> You are not asking userspace whether to reboot or not, and you should
> not ask them about suspend, either.

OK, so how should the system behave when a real-time-like process is
running? I talked about the CD burning example. Should the kernel simply
ignore the process and suspend?

> > 1. Network connections must be reestablished. A userspace program can't
> > try to automatically reestablish a broken TCP connection for no apparent
> > reason. A broken TCP connection could be the cause of an overloaded or
> > broken server/service. If we do not inform userspace processes that the
> > system is going to sleep (or that the system has been brought up from
> > standby), they will blindly try to restore TCP connections back, even
> > when the remote server is broken, generating a lot of unnecesary
> > traffic.
> 
> gettimeofday(), if I slept for too long, oops, something strange
> happened (maybe there was heavy io load and I was swapped out? or
> suspend? Did machine sleep for 20 minutes in cli?) try to reconnect.

Does "gettimeofday()" have into account the effect of adjusting the time
twice a year, once to make time roll forward one hour and another one to
roll it back?


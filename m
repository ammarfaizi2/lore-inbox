Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264047AbTJ1R2f (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 12:28:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264048AbTJ1R2f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 12:28:35 -0500
Received: from gprs192-228.eurotel.cz ([160.218.192.228]:59267 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S264047AbTJ1R2b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 12:28:31 -0500
Date: Tue, 28 Oct 2003 18:28:18 +0100
From: Pavel Machek <pavel@suse.cz>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Cc: Patrick Mochel <mochel@osdl.org>, George Anzinger <george@mvista.com>,
       John stultz <johnstul@us.ibm.com>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [pm] fix time after suspend-to-*
Message-ID: <20031028172818.GB2307@elf.ucw.cz>
References: <Pine.LNX.4.44.0310271535160.13116-100000@cherise> <1067329994.861.3.camel@teapot.felipe-alfaro.com> <20031028093233.GA1253@elf.ucw.cz> <1067351431.1358.11.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1067351431.1358.11.camel@teapot.felipe-alfaro.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Not sure... We do not want applications to know. Certainly we can't
> > send a signal; SIGPWR already has some meaning and it would be bad to
> > override it.
> 
> OK, maybe using SIGPWR is not a good idea, but some userspace
> applications need to know when the system is going to sleep. Even more,
> userspace apps should be able to tell the kernel whether suspending the
> system at a given moment is a good idea or not.

You are not asking userspace whether to reboot or not, and you should
not ask them about suspend, either.

> Examples:
> 
> 1. Network connections must be reestablished. A userspace program can't
> try to automatically reestablish a broken TCP connection for no apparent
> reason. A broken TCP connection could be the cause of an overloaded or
> broken server/service. If we do not inform userspace processes that the
> system is going to sleep (or that the system has been brought up from
> standby), they will blindly try to restore TCP connections back, even
> when the remote server is broken, generating a lot of unnecesary
> traffic.

gettimeofday(), if I slept for too long, oops, something strange
happened (maybe there was heavy io load and I was swapped out? or
suspend? Did machine sleep for 20 minutes in cli?) try to reconnect.

> 2. Sound: I've been unable to suspend via APM with the Yamaha YMFPCI
> driver loaded. I need to unload it, but I can't unload it if there is
> some app using the sound driver. Before going to sleep, sound-aware apps
> could be informed that the system is being put to sleep so that they
> stop playing sound gracefully. Thus, the sound driver could be
> unloaded.

Fix the driver.

								Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]

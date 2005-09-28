Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965227AbVI1BT2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965227AbVI1BT2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 21:19:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965241AbVI1BT2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 21:19:28 -0400
Received: from tantale.fifi.org ([64.81.251.130]:51862 "EHLO tantale.fifi.org")
	by vger.kernel.org with ESMTP id S965227AbVI1BT1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 21:19:27 -0400
To: Simon Kirby <sim@netnation.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Strangeness with signals
References: <20050927232034.GC6833@netnation.com>
Mail-Copies-To: nobody
From: Philippe Troin <phil@fifi.org>
Date: 27 Sep 2005 18:19:24 -0700
In-Reply-To: <20050927232034.GC6833@netnation.com>
Message-ID: <87hdc6htur.fsf@ceramic.fifi.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Simon Kirby <sim@netnation.com> writes:

> Hi folks,
> 
> I'm not sure if this is buggy, strange or just perfectly normal
> behaviour.  I was trying to write an application that does some simple
> network performance polling with setitimer() and also keeps a look out
> for SIGWINCH to see if the window size changes.  I was interested to
> find out that when I resized the window, the signal was never noticed.
> Even more interesting is the fact that if I run it in strace or even
> GDB to figure out what's going on, it works!
> 
> I've simplified the program to this simple test case which will show
> clearly that (both on 2.4 and 2.6), SIGALRM and SIGHUP are received as
> expected but that without setting a special sa_sigaction handler,
> SIGWINCH and SIGCHLD don't appear to wake up sigwaitinfo().  Also,
> applying a sigaction() to all signals won't change the situation unless
> an sa_sigaction is set; sa_handler does not appear to change anything.
> 
> Some people mentioned blocked and ignored signals, but as can be seen in
> this example, differing behaviour can be seen across signals even with
> all signals blocked and ignored.

The SIGWINCH and SIGCHLD signals are not generated if their
disposition is set to SIG_DFL.  I believe SIGCONT and SIGURG also
behave similarly.  If you want to see them from your application, you
have to establish a (potentially empty) signal handler.

Phil.


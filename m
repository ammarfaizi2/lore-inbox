Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269447AbUJLEQ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269447AbUJLEQ4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 00:16:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269445AbUJLEQz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 00:16:55 -0400
Received: from fw.osdl.org ([65.172.181.6]:38609 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269447AbUJLEQl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 00:16:41 -0400
Date: Mon, 11 Oct 2004 21:14:34 -0700
From: Andrew Morton <akpm@osdl.org>
To: Petri Kaukasoina <kaukasoi@elektroni.ee.tut.fi>
Cc: roland@redhat.com, joshk@triplehelix.org, linux-kernel@vger.kernel.org
Subject: Re: Weirdness with suspending jobs in 2.6.9-rc3
Message-Id: <20041011211434.66bacb0e.akpm@osdl.org>
In-Reply-To: <20041012035121.GA665@elektroni.ee.tut.fi>
References: <20041010211507.GB3316@triplehelix.org>
	<200410112055.i9BKt5LI031359@magilla.sf.frob.com>
	<20041012033934.GA275@elektroni.ee.tut.fi>
	<20041011204512.6c67333c.akpm@osdl.org>
	<20041012035121.GA665@elektroni.ee.tut.fi>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Petri Kaukasoina <kaukasoi@elektroni.ee.tut.fi> wrote:
>
> > What command are you actually running to demonstrate this?  Full details,
>  > please.
> 
>  First 'make' while the Makefile is this
> 
>  all:
>  	sleep 40
>  	echo Hi
>  	sleep 5
> 
>  and then in a different window 'ps ux' and then 'strace -p PID'. If
>  CONFIG_REGPARM if off then the strace starts:
> 
>  Process 324 attached - interrupt to quit
>  wait4(-1, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], 0, NULL) = 325
>  --- SIGCHLD (Child exited) @ 0 (0) ---
>  sigreturn()                             = ? (mask now [])
>  write(1, "echo Hi\n", 8)                = 8
> 
>  if CONFIG_REGPARM=Y then it starts:
> 
>  Process 14226 attached - interrupt to quit
>  wait4(-1073750328, NULL, 0, NULL)       = -1 ECHILD (No child processes)
>  write(2, "make: *** ", 10)              = 10
>  write(2, "wait: No child processes", 24) = 24
>  write(2, ".  Stop.\n", 9)               = 9
>  write(2, "make: ", 6)                   = 6

eww, OK, happens here too.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269429AbUJLDv1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269429AbUJLDv1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 23:51:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269435AbUJLDv1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 23:51:27 -0400
Received: from elektroni.ee.tut.fi ([130.230.131.11]:2432 "HELO
	elektroni.ee.tut.fi") by vger.kernel.org with SMTP id S269429AbUJLDvW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 23:51:22 -0400
Date: Tue, 12 Oct 2004 06:51:21 +0300
From: Petri Kaukasoina <kaukasoi@elektroni.ee.tut.fi>
To: Andrew Morton <akpm@osdl.org>
Cc: roland@redhat.com, joshk@triplehelix.org, linux-kernel@vger.kernel.org
Subject: Re: Weirdness with suspending jobs in 2.6.9-rc3
Message-ID: <20041012035121.GA665@elektroni.ee.tut.fi>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>, roland@redhat.com,
	joshk@triplehelix.org, linux-kernel@vger.kernel.org
References: <20041010211507.GB3316@triplehelix.org> <200410112055.i9BKt5LI031359@magilla.sf.frob.com> <20041012033934.GA275@elektroni.ee.tut.fi> <20041011204512.6c67333c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041011204512.6c67333c.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 11, 2004 at 08:45:12PM -0700, Andrew Morton wrote:
> Petri Kaukasoina <kaukasoi@elektroni.ee.tut.fi> wrote:
> >
> > On Mon, Oct 11, 2004 at 01:55:05PM -0700, Roland McGrath wrote:
> > > > wait4(-1073750280, NULL, 0, NULL)       = -1 ECHILD (No child processes)
> > > 
> > > That is a clearly bogus argument.
> > 
> > Hi. I see it too:
> > 
> > wait4(-1073750328, NULL, 0, NULL)       = -1 ECHILD (No child processes)
> > 
> > But the whole problem goes away if I switch CONFIG_REGPARM off. To reproduce
> > it needs CONFIG_REGPARM=y.
> > 
> 
> Interesting.
> 
> What command are you actually running to demonstrate this?  Full details,
> please.

First 'make' while the Makefile is this

all:
	sleep 40
	echo Hi
	sleep 5

and then in a different window 'ps ux' and then 'strace -p PID'. If
CONFIG_REGPARM if off then the strace starts:

Process 324 attached - interrupt to quit
wait4(-1, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], 0, NULL) = 325
--- SIGCHLD (Child exited) @ 0 (0) ---
sigreturn()                             = ? (mask now [])
write(1, "echo Hi\n", 8)                = 8

if CONFIG_REGPARM=Y then it starts:

Process 14226 attached - interrupt to quit
wait4(-1073750328, NULL, 0, NULL)       = -1 ECHILD (No child processes)
write(2, "make: *** ", 10)              = 10
write(2, "wait: No child processes", 24) = 24
write(2, ".  Stop.\n", 9)               = 9
write(2, "make: ", 6)                   = 6

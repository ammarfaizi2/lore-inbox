Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261867AbUEEAjW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261867AbUEEAjW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 20:39:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261891AbUEEAjW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 20:39:22 -0400
Received: from pop.gmx.net ([213.165.64.20]:38529 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261867AbUEEAjV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 20:39:21 -0400
X-Authenticated: #271361
Date: Wed, 5 May 2004 02:38:52 +0200
From: Edgar Toernig <froese@gmx.de>
To: Steve Beaty <beaty@emess.mscd.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: sigaction, fork, malloc, and futex
Message-Id: <20040505023852.509f5fe3.froese@gmx.de>
In-Reply-To: <200405042015.i44KFb0R001900@emess.mscd.edu>
References: <200405042015.i44KFb0R001900@emess.mscd.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steve Beaty wrote:
>
>... the signal handler fork another child.

Uhh... just read that POSIX actually allows that.  Evil!
I guess you're entering undiscovered land...

> void sig_handler (int signum)
> {
> 	int     child;
> 
> 	fprintf (stderr, "Process %d received a SIGALRM signal\n", getpid());
> 	if ((child = fork ()) == 0)
> 	{
> 		fprintf (stderr, "%d exiting\n", getpid());
> 		exit (0);
> 	}
> 	fprintf (stderr, "%d waiting for %d\n", getpid(), child);
> 	waitpid (child, NULL, 0);
> }

No fprintf and exit in a signal handler!  Use write and _exit instead.

> 	if ((child = fork ()) == 0)
> 	{
> 		fprintf (stderr, "%d sending SIGALRM to %d\n", getpid(), parent);
> 		if (kill (parent, SIGALRM) == -1) perror ("kill 1");
> 		fprintf (stderr, "%d exiting\n", getpid());
> 		exit (0);
> 	}

This exit is dubious too.  _exit is better.

Good luck, you may need it - ET.

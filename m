Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272234AbTGYRok (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 13:44:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272235AbTGYRok
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 13:44:40 -0400
Received: from smtp808.mail.sc5.yahoo.com ([66.163.168.187]:17012 "HELO
	smtp808.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S272234AbTGYRoh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 13:44:37 -0400
Subject: Re: forkpty with streams
From: Andrew Barton <andrevv@users.sourceforge.net>
To: aebr@win.tue.nl
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030725152751.GA606@win.tue.nl>
References: <1059089316.8596.14.camel@localhost>
	 <20030725152751.GA606@win.tue.nl>
Content-Type: text/plain
Organization: 
Message-Id: <1059130744.13184.11.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2-3mdk 
Date: 25 Jul 2003 10:59:04 +0000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-07-25 at 15:27, Andries Brouwer wrote:
> On Thu, Jul 24, 2003 at 11:28:36PM +0000, Andrew Barton wrote:
> 
> > I've got the 2.4 kernel, and I'm trying to use the forkpty() system call
> 
> forkpty is not a system call
> 
> > with the standard I/O stream functions. The calls to forkpty() and
> > fdopen() and fprintf() all return successfully, but the data never seems
> > to get to the child process.
> 
> > 	pid = forkpty (&fd, 0, 0, 0);
> > 	if (pid == 0) {
> > 		execlp ("sh", "sh", (void *)0);
> > 	} else {
> > 		F = fdopen (fd, "w");
> > 		fprintf (F, "exit\n");
> > 		fflush (F);
> > 		wait (0);
> > 	}
> 
> Let me see. Your sh gets input from this pseudotty and sends its
> output there again. But you never read that filedescriptor.
> No doubt things will improve if you let the parent read from fd.
> 
> Andries

Before I tried using streams, I just used write() to communicate with
the ptty, but I had the same problem. I found that if I put a read()
call before and after the write(), it worked. But why? Is this some kind
of I/O voodoo? How does the reading affect the writing?

You mentioned that things would improve if I let the parent read from
fd. Will this work using streams? I have tried opening fd in "r+" mode,
but in that case I end up reading my own data. Do I need to lay an
fflush() somewhere inbetween? What is it exactly that causes the data to
be sent to the parent?

I appreciate the help.


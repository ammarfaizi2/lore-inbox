Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272142AbTGYPMw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 11:12:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272138AbTGYPMw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 11:12:52 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:269 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S272145AbTGYPMn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 11:12:43 -0400
Date: Fri, 25 Jul 2003 17:27:51 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Andrew Barton <andrevv@users.sourceforge.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: forkpty with streams
Message-ID: <20030725152751.GA606@win.tue.nl>
References: <1059089316.8596.14.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1059089316.8596.14.camel@localhost>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 24, 2003 at 11:28:36PM +0000, Andrew Barton wrote:

> I've got the 2.4 kernel, and I'm trying to use the forkpty() system call

forkpty is not a system call

> with the standard I/O stream functions. The calls to forkpty() and
> fdopen() and fprintf() all return successfully, but the data never seems
> to get to the child process.

> 	pid = forkpty (&fd, 0, 0, 0);
> 	if (pid == 0) {
> 		execlp ("sh", "sh", (void *)0);
> 	} else {
> 		F = fdopen (fd, "w");
> 		fprintf (F, "exit\n");
> 		fflush (F);
> 		wait (0);
> 	}

Let me see. Your sh gets input from this pseudotty and sends its
output there again. But you never read that filedescriptor.
No doubt things will improve if you let the parent read from fd.

Andries


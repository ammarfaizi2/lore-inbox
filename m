Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266179AbUF3BZZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266179AbUF3BZZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 21:25:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266182AbUF3BZY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 21:25:24 -0400
Received: from mproxy.gmail.com ([216.239.56.244]:5212 "HELO mproxy.gmail.com")
	by vger.kernel.org with SMTP id S266179AbUF3BZX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 21:25:23 -0400
Message-ID: <8783be6604062918255d594d19@mail.gmail.com>
Date: Tue, 29 Jun 2004 21:25:22 -0400
From: Ross Biro <ross.biro@gmail.com>
To: David Ashley <dash@xdr.com>
Subject: Re: Cached memory never gets released
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200406291618.i5TGIQ8F028141@xdr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <200406291618.i5TGIQ8F028141@xdr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jun 2004 09:18:26 -0700, David Ashley <dash@xdr.com> wrote:
> 
> 
> In the thread this is made clear somewhat, but when I post new
> emails I don't summarize all that is known about the problem.

Sorry, I missed that part of the thread.


It does sounds like you may have a real problem, so the next step I
would do is instrument kswapd to explain why it's not freeing cache
when it's under demand.

The first step is to add something to kernel/sysctrl.c to create a
variable to turn the debugging code on or off.

Then add a bunch of printk's to mm/vmscan.c explaining why every page
is not being freed, but only when the sysctrl variable is set.

Then get the machine into the bad state and turn on the printks.

Run your program that can't allocate memory

Turn off the printks and analyze the logs.

I'll be happy to help you figure out where to put printks and go over
the logs, but you have to make sure you are really getting an OOM kill
with that much cache for the output to be useful.

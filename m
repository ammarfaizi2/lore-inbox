Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262306AbTIZPGX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 11:06:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262338AbTIZPGX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 11:06:23 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:16555 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S262306AbTIZPGW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 11:06:22 -0400
X-AuthUser: davidel@xmailserver.org
Date: Fri, 26 Sep 2003 08:01:37 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Maciej Zenczykowski <maze@cela.pl>
cc: Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Syscall security
In-Reply-To: <Pine.LNX.4.44.0309261611510.6080-100000@gaia.cela.pl>
Message-ID: <Pine.LNX.4.56.0309260746140.1924@bigblue.dev.mdolabs.com>
References: <Pine.LNX.4.44.0309261611510.6080-100000@gaia.cela.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Sep 2003, Maciej Zenczykowski wrote:

> > if this syscall activity is so low then it might be much more flexible to
> > control the binary via ptrace and reject all but the desired syscalls.
> > This will cause a context switch but if it's stdio only then it's not a
> > big issue. Plus this would work on any existing Linux kernel.
>
> Unfortunately sometimes the data transfer through stdio can be counted in
> hundreds of MB (or even in extreme cases a couple of GB), plus it is
> important to not slow down the execution of the code (we're timing and
> comparing execution speed of different approaches).  Would doing this via
> ptrace increase the runtime of the parent pid or of the child pid or both?
> ie. would this make any syscall costly timewise (stdio is either from a
> ram disk or piped to/from a generating/checking process) or would this be
> unnoticeable?

I beieve that what you're trying to do is a little bit more complicated
then simply blocking a few system calls. There are security softwares
doing this but they do more then blindly blocking system calls. Parameters
of the system call do matter in this scenario. For example you don't want
to block every write(), since the application you're trying to control
must be able to write on its own installation dir for example. They do
this by running the given application and "learning" system calls and
params to create a per-application policy. Every behaviour that violates
the policy trigger an event to the user running it (with a
"human readable" description of what is happening) and the user can either
accept it (by trainig the policy) or reject it.



- Davide


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262457AbTI1Lrt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 07:47:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262461AbTI1Lrt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 07:47:49 -0400
Received: from as3-1-8.ras.s.bonet.se ([217.215.75.181]:21142 "EHLO
	garbo.kenjo.org") by vger.kernel.org with ESMTP id S262457AbTI1Lrs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 07:47:48 -0400
Subject: Re: Syscall security
From: Kenneth Johansson <ken@kenjo.org>
To: Maciej Zenczykowski <maze@cela.pl>
Cc: Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0309261611510.6080-100000@gaia.cela.pl>
References: <Pine.LNX.4.44.0309261611510.6080-100000@gaia.cela.pl>
Content-Type: text/plain
Message-Id: <1064749134.2095.9.camel@tiger>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Sun, 28 Sep 2003 13:38:54 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-09-26 at 16:16, Maciej Zenczykowski wrote:
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

Depends how the application writes the data it's not the amount that is
the problem it's the frequency of the calls.

It should however be possible to meassure the overhead and remove that
from the result.

As far as I know it's not possible to abort a syscall with ptrace on
entry but you can change the syscall number to something harmless like
getpid and fix the return values on exit. But it is all very much arch
dependent code.


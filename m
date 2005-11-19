Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751355AbVKSEWp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751355AbVKSEWp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 23:22:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751345AbVKSEWp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 23:22:45 -0500
Received: from nevyn.them.org ([66.93.172.17]:55945 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S1751355AbVKSEWo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 23:22:44 -0500
Date: Fri, 18 Nov 2005 23:22:40 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Greg <gkurz@fr.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: sigsuspend() and ptrace()
Message-ID: <20051119042240.GA31395@nevyn.them.org>
Mail-Followup-To: Greg <gkurz@fr.ibm.com>, linux-kernel@vger.kernel.org
References: <436B228D.2000309@fr.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <436B228D.2000309@fr.ibm.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 04, 2005 at 09:57:49AM +0100, Greg wrote:
> Hi,
> 
> My program uses gdb to attach to a process and make it execute a specific
> function thanks to the gdb 'call' command. This works quite well unless the
> attached process is sleeping in sigsuspend(). I peeked into the kernel sources
> and saw that the typical sigsuspend() implementation is like this :
> 
> while (1) {
> 	schedule();
> 	if (do_signal())
> 		return -EINTR;
> }
> 
> When using ptrace attach, the target process receives a SIGSTOP but there
> isn't *of course* any handler to SIGSTOP. And no way for the process to return
> to userland... is it implemented that way on purpose ? How can I make suspending
> processes do some *alternative* work with gdb ?

Sorry, I'm a bit behind on lkml.

What's _supposed_ to happen is that sigsuspend should be interrupted by
the SIGSTOP even though there is no handler.  SIGSTOP can't be blocked.

You didn't say what kernel version or architecture you were having
trouble with; which is it?  It looks right in current 2.6 for i386 and
ppc, which were the only ones I checked.

-- 
Daniel Jacobowitz
CodeSourcery, LLC

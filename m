Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262349AbUKKSBJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262349AbUKKSBJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 13:01:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262354AbUKKR4M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 12:56:12 -0500
Received: from nevyn.them.org ([66.93.172.17]:47286 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S262293AbUKKRpX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 12:45:23 -0500
Date: Thu, 11 Nov 2004 12:45:12 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Blaisorblade <blaisorblade_spam@yahoo.it>
Cc: Chris Wedgwood <cw@f00f.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Fixing UML against NPTL (was: Re: [uml-devel] [PATCH] UML: Use PTRACE_KILL instead of SIGKILL to kill host-OS processes (take #2))
Message-ID: <20041111174512.GA27809@nevyn.them.org>
Mail-Followup-To: Blaisorblade <blaisorblade_spam@yahoo.it>,
	Chris Wedgwood <cw@f00f.org>, LKML <linux-kernel@vger.kernel.org>
References: <20041103113736.GA23041@taniwha.stupidest.org> <200411040113.27747.blaisorblade_spam@yahoo.it> <20041104003943.GB17467@taniwha.stupidest.org> <200411040531.29596.blaisorblade_spam@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411040531.29596.blaisorblade_spam@yahoo.it>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 04, 2004 at 05:31:21AM +0100, Blaisorblade wrote:
> 2) getpid() on a child clone returns the process's pid when run with a 
> NPTL-enabled glibc, while it returns the thread pid with a LinuxThreads one; 
> this causes tons of problems with UML, which uses signals as inter-thread and 
> intra-thread communication.
> 
> Note UML is not using pthread_create() to create the threads, where this 
> behaviour is an improvement. I'm using a plain clone() call without the 
> CLONE_THREAD flag (which is not even added in by glibc, according to strace).
> 
> I've not yet checked if glibc is hijacking getpid() or not, but that would be 
> strange anyway.

Glibc caches the PID.  If you're going to use clone directly, use the
gettid/getpid syscall directly.  It's kind of rude that glibc breaks
getpid in this way; I recommend filing a bug in the glibc bugzilla at
sources.redhat.com.

-- 
Daniel Jacobowitz

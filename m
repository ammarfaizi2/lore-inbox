Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262364AbUKKSuG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262364AbUKKSuG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 13:50:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262353AbUKKSsL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 13:48:11 -0500
Received: from nevyn.them.org ([66.93.172.17]:23224 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S262347AbUKKSpr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 13:45:47 -0500
Date: Thu, 11 Nov 2004 13:45:23 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Christophe Saout <christophe@saout.de>
Cc: Blaisorblade <blaisorblade_spam@yahoo.it>, Chris Wedgwood <cw@f00f.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Fixing UML against NPTL (was: Re: [uml-devel] [PATCH] UML: Use PTRACE_KILL instead of SIGKILL to kill host-OS processes (take #2))
Message-ID: <20041111184523.GA11578@nevyn.them.org>
Mail-Followup-To: Christophe Saout <christophe@saout.de>,
	Blaisorblade <blaisorblade_spam@yahoo.it>,
	Chris Wedgwood <cw@f00f.org>, LKML <linux-kernel@vger.kernel.org>
References: <20041103113736.GA23041@taniwha.stupidest.org> <200411040113.27747.blaisorblade_spam@yahoo.it> <20041104003943.GB17467@taniwha.stupidest.org> <200411040531.29596.blaisorblade_spam@yahoo.it> <20041111174512.GA27809@nevyn.them.org> <1100197911.11951.1.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1100197911.11951.1.camel@leto.cs.pocnet.net>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 11, 2004 at 07:31:51PM +0100, Christophe Saout wrote:
> Am Donnerstag, den 11.11.2004, 12:45 -0500 schrieb Daniel Jacobowitz:
> 
> > Glibc caches the PID.  If you're going to use clone directly, use the
> > gettid/getpid syscall directly.  It's kind of rude that glibc breaks
> > getpid in this way; I recommend filing a bug in the glibc bugzilla at
> > sources.redhat.com.

... but, thinking about it, they'll probably close it as INVALID.

> If glibc insists on caching the pid, it could also simply invalidate the
> pid cache in the clone function.

It currently does this for vfork, but not clone.  Basically, you can't
call into glibc at all if you use clone.  If you aren't using POSIX
threads, then the POSIX-compliant library is going to fall to pieces
around you.  For instance, all the file locking will break, and
anything else that, like the PID cache, relies on either global or
per-_thread_ data.

-- 
Daniel Jacobowitz

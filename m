Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262419AbUKLAf2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262419AbUKLAf2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 19:35:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262422AbUKLAdr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 19:33:47 -0500
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32]:57252 "HELO
	smtp001.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S262431AbUKLA2z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 19:28:55 -0500
From: Blaisorblade <blaisorblade_spam@yahoo.it>
To: Daniel Jacobowitz <dan@debian.org>
Subject: Re: Fixing UML against NPTL (was: Re: [uml-devel] [PATCH] UML: Use PTRACE_KILL instead of SIGKILL to kill host-OS processes (take #2))
Date: Fri, 12 Nov 2004 01:09:02 +0100
User-Agent: KMail/1.7.1
Cc: Christophe Saout <christophe@saout.de>, Chris Wedgwood <cw@f00f.org>,
       LKML <linux-kernel@vger.kernel.org>
References: <20041103113736.GA23041@taniwha.stupidest.org> <1100197911.11951.1.camel@leto.cs.pocnet.net> <20041111184523.GA11578@nevyn.them.org>
In-Reply-To: <20041111184523.GA11578@nevyn.them.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411120109.03149.blaisorblade_spam@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 11 November 2004 19:45, Daniel Jacobowitz wrote:
> On Thu, Nov 11, 2004 at 07:31:51PM +0100, Christophe Saout wrote:
> > Am Donnerstag, den 11.11.2004, 12:45 -0500 schrieb Daniel Jacobowitz:
> > > Glibc caches the PID.  If you're going to use clone directly, use the
> > > gettid/getpid syscall directly.  It's kind of rude that glibc breaks
> > > getpid in this way; I recommend filing a bug in the glibc bugzilla at
> > > sources.redhat.com.
>
> ... but, thinking about it, they'll probably close it as INVALID.
>
> > If glibc insists on caching the pid, it could also simply invalidate the
> > pid cache in the clone function.

> It currently does this for vfork, but not clone.  Basically, you can't
> call into glibc at all if you use clone.  If you aren't using POSIX
> threads, then the POSIX-compliant library is going to fall to pieces
> around you.  For instance, all the file locking will break, and
> anything else that, like the PID cache, relies on either global or
> per-_thread_ data.

Yes, in fact I guess that the problem is for any _thread variable. And as 
fork() is not a raw syscall, so clone() shouldn't be.

I'll file a bugreport when I have time to do it properly - I don't want to 
hear that "if I go into dirty things using clone(), I get to keep the pieces 
and setup a different TLS for the new process"
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729

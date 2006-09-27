Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751124AbWI0LwR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751124AbWI0LwR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 07:52:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751129AbWI0LwR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 07:52:17 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:51464 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1751124AbWI0LwP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 07:52:15 -0400
Date: Wed, 27 Sep 2006 11:51:34 +0000
From: Pavel Machek <pavel@ucw.cz>
To: David Wagner <daw-usenet@taverner.cs.berkeley.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] remove MNT_NOEXEC check for PROT_EXEC mmaps
Message-ID: <20060927115134.GC4296@ucw.cz>
References: <45150CD7.4010708@aknet.ru> <4516C9D0.3080606@aknet.ru> <ef6ldq$uup$1@taverner.cs.berkeley.edu> <20060925105355.GA4390@elf.ucw.cz> <ef9i4q$emc$1@taverner.cs.berkeley.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef9i4q$emc$1@taverner.cs.berkeley.edu>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Mon 25-09-06 21:36:26, David Wagner wrote:
> Pavel Machek  wrote:
> >> I'm curious about this, too.  ld-linux.so is a purely unprivileged
> >> program.  It isn't setuid root.  Can you write a variant of ld-linux.so
> >> that reads an executable into memory off of a partition mounted noexec and
> >> then begins executing that code?  (perhaps by using anonymous mmap
> >> with
> >
> >Yes, you can, but to execute your ld-linux-ignore-noexec.so variant,
> >you need to put it somewhere with exec permissions, right?
> 
> Well, yes, if you write it as a binary executable -- but not if you're
> more clever.  For instance, you can write a ld-linux-ignore-noexec.so.pl
> Perl script, store the Perl script on the noexec partition, and execute
> it via "/usr/bin/perl ld-linux-ignore-noexec.so.pl" (since I think
> Perl scripts can execute all of the system calls you'd need to use to
> write your own loader, since it's pretty well guaranteed that /usr/bin
> will live on a partition that is not marked noexec).  Note that Perl

Ok, you are right. For noexec to be effective, interpretters need to
be well-behaved, and perl is not. Maybe we should forget about
noexec, and maybe we should fix perl, I do not know.
-- 
Thanks for all the (sleeping) penguins.

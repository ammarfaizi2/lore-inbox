Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262075AbVCIXbm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262075AbVCIXbm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 18:31:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262092AbVCIX36
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 18:29:58 -0500
Received: from fire.osdl.org ([65.172.181.4]:39072 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262132AbVCIX2w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 18:28:52 -0500
Date: Wed, 9 Mar 2005 15:28:37 -0800
From: Chris Wright <chrisw@osdl.org>
To: Ulrich Drepper <drepper@redhat.com>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: Re: process file descriptor limit handling
Message-ID: <20050309232837.GI5389@shell0.pdx.osdl.net>
References: <3FBD1BD2.908@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FBD1BD2.908@redhat.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Ulrich Drepper (drepper@redhat.com) wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> The current kernel (and all before as far as I can see) have a problem
> with the file system limit handling.  The behavior does not conform to
> the current POSIX spec.
<snip>
> It might also be that some wording is getting in the specification which
> will allow the current kernel behavior to continue to exist.  More
> through a loophole, but still.

This seems the case.  SuS v3 says:

setrlimit
RLIMIT_NOFILE
    This is a number one greater than the maximum value that the system
    may assign to a newly-created descriptor. If this limit is exceeded,
    functions that allocate a file descriptor shall fail with errno set
    to [EMFILE]. This limit constrains the number of file descriptors
    that a process may allocate.

open
[EMFILE]
    {OPEN_MAX} file descriptors are currently open in the calling process.
 
limits.h
{OPEN_MAX}
    Maximum number of files that one process can have open at any one time.
    Minimum Acceptable Value: {_POSIX_OPEN_MAX}

So, one view says your test program is within the spec, since the new fd
is still one less than the current rlimit.

Anyway, here's a simple patch that would fail the second setrlimit, as you
suggested.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net

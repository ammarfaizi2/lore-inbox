Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263008AbTKKK1s (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 05:27:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263014AbTKKK1s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 05:27:48 -0500
Received: from vladimir.pegasys.ws ([64.220.160.58]:10253 "EHLO
	vladimir.pegasys.ws") by vger.kernel.org with ESMTP id S263008AbTKKK1q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 05:27:46 -0500
Date: Tue, 11 Nov 2003 02:27:42 -0800
From: jw schultz <jw@pegasys.ws>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: OT: why no file copy() libc/syscall ??
Message-ID: <20031111102742.GC17240@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux-kernel mailing list <linux-kernel@vger.kernel.org>
References: <1068512710.722.161.camel@cube> <20031110205011.R10197@schatzie.adilger.int> <1068523406.4156.7.camel@localhost> <200311110414.hAB4EZA8007309@turing-police.cc.vt.edu> <20031110230055.S10197@schatzie.adilger.int> <20031111085806.GC11435@deneb.enyo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031111085806.GC11435@deneb.enyo.de>
User-Agent: Mutt/1.3.27i
X-Message-Flag: This message is may contain confidential information.  Unauthorised disclosure will be prosecuted to the fullest extent of the law.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 11, 2003 at 09:58:06AM +0100, Florian Weimer wrote:
> Andreas Dilger wrote:
> 
> > > This is fast turning into a creeping horror of aggregation.  I defy anybody
> > > to create an API to cover all the options mentioned so far and *not* have it
> > > look like the process_clone horror we so roundly derided a few weeks ago.
> > 
> > 	int sys_copy(int fd_src, int fd_dst)

That sounds a lot like a sendfile with a file as the
destination.  Useful but still happening on the local system.
My understanding was that this was to be sent to a remote
system where the file descriptors might not be open.

> 
> Doesn't work.  You have to set the security attributes while you open
> fd_dst.

That would have been done with open().

To operate on paths so it could be sent to a fileserver it
would need the same arguments as open() with the addition of
the newpath.

	int sys_copy(const char *oldpath, const char *oldpath,
	    int flags, mode_t mode);

O_TRUNC		replace an existing file.
O_EXCL		prevent replacing an existing file.
O_APPEND	concatenate (useful feature creep).
O_NDELAY/O_NONBLOCK	return and ignore ENOSPACE condition, ick!
O_SYNC		if O_SYNC supported for open
O_NOFOLLOW	don't follow symlink (no need for a lcopy())

EXDEV (see link(2)) seems a better error code for cases
where the source and destination are on different servers.
Otherwise the error codes would conform to open(2).

I've long thought a file copy syscall was missing from unix
but until you start networking it isn't an issue.



-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt

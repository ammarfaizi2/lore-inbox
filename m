Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262898AbVCJR4L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262898AbVCJR4L (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 12:56:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262808AbVCJRxB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 12:53:01 -0500
Received: from mx02.qsc.de ([213.148.130.14]:18578 "EHLO mx02.qsc.de")
	by vger.kernel.org with ESMTP id S262729AbVCJRmk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 12:42:40 -0500
Date: Thu, 10 Mar 2005 18:42:19 +0100
From: Gunnar Ritter <Gunnar.Ritter@pluto.uni-freiburg.de>
Organization: Privat.
To: Nick Stoughton <nick@usenix.org>, Andries Brouwer <aebr@win.tue.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: link(2) and symlinks
Message-ID: <423086fb.nR9LluzfPxF0FN86%Gunnar.Ritter@pluto.uni-freiburg.de>
References: <1110410075.18359.384.camel@collie>
 <20050310015535.GB4044@pclin040.win.tue.nl>
In-Reply-To: <20050310015535.GB4044@pclin040.win.tue.nl>
User-Agent: nail 11.22pre 3/5/05
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries Brouwer <aebr@win.tue.nl> wrote:

> On Wed, Mar 09, 2005 at 03:14:36PM -0800, Nick Stoughton wrote:
> > Most Unix implementations behave in the manner specified by POSIX.  One
> > notable exception is Solaris 8 (I don't know about later Solarises). 

It's still the same on Solaris 10. /usr/bin/ln behaves like Linux, and
/usr/xpg4/bin/ln behaves like POSIX.

> > Would a patch to provide POSIX conforming behavior under some
> > conditional case (e.g. if /proc/sys/posix has value 1) ever be accepted?
> It sounds like a bad idea to have name resolution semantics dependent
> upon some external variable. The result would be that nobody could be
> sure anymore what the link() system call will do.

I second that.

> (Also, POSIX does not describe the kernel interface - it describes
> a C interface. It would be possible for a libc to arrange that a
> different link() routine was used.
> Use of personality(2) does not sound like a good idea.)

The Solaris implementation of the POSIX behavior is done mostly
in userspace, as running truss with /usr/xpg4/bin/ln shows. The
actual link system call seems to be always the same one, with a
Linux-like behavior. /usr/xpg4/bin/ln only invokes resolvepath()
(a realpath()-like system call) first.

> ((Maybe it would be beter to change POSIX here. Submit a defect report
> and make the result of hard-linking to a symlink unspecified.
> Since Linux and Solaris are non-POSIX here, programmers of portable
> programs cannot rely on POSIX anyway.

In the standards sense of portability, they can; the formally conforming
Solaris environment behaves as POSIX specifies, and Linux has never been
formally conforming to POSIX.1-2001 anyway.

> Moreover, the Linux/Solaris behaviour sounds entirely reasonable,
> preferable in fact above the POSIX behaviour.))

I personally agree, but I doubt our opinion matters much.

	Gunnar

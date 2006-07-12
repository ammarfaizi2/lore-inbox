Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932472AbWGLXol@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932472AbWGLXol (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 19:44:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932473AbWGLXol
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 19:44:41 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:12235 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932472AbWGLXok (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 19:44:40 -0400
In-Reply-To: <20060712232414.GI9040@thunk.org>
Subject: Re: [PATCH] Use uname not sysctl to get the kernel revision
To: Theodore Tso <tytso@mit.edu>, libc-alpha@sourceware.org,
       linux-kernel@vger.kernel.org
Cc: Andi Kleen <ak@suse.de>, akpm@osdl.org,
       Arjan van de Ven <arjan@infradead.org>,
       Ulrich Drepper <drepper@redhat.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       "Randy.Dunlap" <rdunlap@xenotime.net>
X-Mailer: Lotus Notes Release 7.0 HF144 February 01, 2006
Message-ID: <OF1343C031.500862D1-ON862571A9.00817A27-862571A9.00826BED@us.ibm.com>
From: Steve Munroe <sjmunroe@us.ibm.com>
Date: Wed, 12 Jul 2006 18:44:33 -0500
X-MIMETrack: Serialize by Router on D27mc103/27/M/IBM(Release 7.0.1|January 17, 2006) at
 07/12/2006 06:44:36 PM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Theodore Tso <tytso@mit.edu> wrote on 07/12/2006 06:24:14 PM:

> On Wed, Jul 12, 2006 at 11:42:47AM -0600, Eric W. Biederman wrote:
> > Unless a darn good reason for keeping it is found, sys_sysctl won't be
> > in the kernel several months from now.  And uname is faster by a large
> > margin than /proc.
>
> Um, if glibc is using sys_sysctl, then that's a pretty good reason.
> Once we remove it from the kernel, then people will be forced to
> upgrade glibc's before they can install a newer kernel.  Can we please
> give people some time for an version of glibc with this change to make
> it out to most deployed systems, first?  It's really annoying when
> it's not possible to install a stock kernel.org kernel on a system,
> and often upgrading glibc is not a trivial thing to do on a
> distribution userspace, especially if there is a concern for ISV
> compatibility.  (Especially if C++ code is involved, unfortunately.)
>
We will need an implementation that will fall back to sys_sysctl for older
kernels. This is already common practice in glibc. I don't really
understand the performance concern because it seems to me that
_is_smp_system() is only called once per process.

But isn't this the kind of thing that the Aux Vector is for? I like vDSO
too, but I think it is best deployed for information of a more dynamic
nature and performance sensitive.




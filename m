Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312959AbSCZGzO>; Tue, 26 Mar 2002 01:55:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312960AbSCZGzE>; Tue, 26 Mar 2002 01:55:04 -0500
Received: from SNAP.THUNK.ORG ([216.175.175.173]:21011 "EHLO snap.thunk.org")
	by vger.kernel.org with ESMTP id <S312959AbSCZGy4>;
	Tue, 26 Mar 2002 01:54:56 -0500
Date: Tue, 26 Mar 2002 01:54:40 -0500
From: Theodore Tso <tytso@mit.edu>
To: Andrew Morton <akpm@zip.com.au>
Cc: Theodore Tso <tytso@mit.edu>, "H . J . Lu" <hjl@lucon.org>,
        linux-mips@oss.sgi.com, linux kernel <linux-kernel@vger.kernel.org>,
        GNU C Library <libc-alpha@sources.redhat.com>
Subject: Re: Does e2fsprogs-1.26 work on mips?
Message-ID: <20020326015440.A12162@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Andrew Morton <akpm@zip.com.au>, "H . J . Lu" <hjl@lucon.org>,
	linux-mips@oss.sgi.com, linux kernel <linux-kernel@vger.kernel.org>,
	GNU C Library <libc-alpha@sources.redhat.com>
In-Reply-To: <20020323140728.A4306@lucon.org> <3C9D1C1D.E30B9B4B@zip.com.au> <20020323221627.A10953@lucon.org> <3C9D7A42.B106C62D@zip.com.au> <20020324012819.A13155@lucon.org> <20020325003159.A2340@thunk.org> <3C9EB8F6.247C7C3B@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 24, 2002 at 09:43:18PM -0800, Andrew Morton wrote:
> Theodore Tso wrote:
> > 
> > And just to be clear ---- although in the past I've been really
> > annoyed when glibc has made what I've considered to be arbitrary
> > changes which have screwed ABI, compile-time, or link-time
> > compatibility, and have spoken out against it --- in this particular
> > case, I consider the fault to be purely the fault of the kernel
> > developers, so there's no need having the glibc folks get all
> > defensive....
> 
> So... Does the kernel need fixing? If so, what would you
> recommend?

1) Created a new syscall for the unsinged setrlimit, not just for
getrlimit.  This should have been done from the very beginning, IMHO.

2) If the old value of RLIM_INFINITY is passed to the old setrlimit,
translate it to the new value of RLIM_INFINITY.  (This would not have
been strictly necessary of glibc wasn't playing RLIM_INIFITY capping
games; as it turns out, if you pass the "new" version of RLIM_INIFITY
to an "old" 2.2 kernel, the right thing happens.  So there really is
no need for glibc to cap the limit of RLIM_INFINITY to the old value.)

3)  RLIMIT_FILESIZE should not apply to block devices!!!

							- Ted


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266576AbSK1Rua>; Thu, 28 Nov 2002 12:50:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266578AbSK1Rua>; Thu, 28 Nov 2002 12:50:30 -0500
Received: from mons.uio.no ([129.240.130.14]:29895 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S266576AbSK1Ru3>;
	Thu, 28 Nov 2002 12:50:29 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15846.22809.438838.989047@charged.uio.no>
Date: Thu, 28 Nov 2002 18:57:45 +0100
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>,
       Ext2 devel <ext2-devel@lists.sourceforge.net>,
       NFS maillist <nfs@lists.sourceforge.net>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [Ext2-devel] Re: [NFS] htree+NFS (NFS client bug?)
In-Reply-To: <20021128170924.F2362@redhat.com>
References: <1038354285.1302.144.camel@sherkaner.pao.digeo.com>
	<shsptsrd761.fsf@charged.uio.no>
	<1038387522.31021.188.camel@ixodes.goop.org>
	<20021127150053.A2948@redhat.com>
	<15845.10815.450247.316196@charged.uio.no>
	<20021127205554.J2948@redhat.com>
	<shslm3e4or2.fsf@charged.uio.no>
	<20021128164143.D2362@redhat.com>
	<15846.19228.868861.629722@charged.uio.no>
	<20021128170924.F2362@redhat.com>
X-Mailer: VM 7.00 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Stephen C Tweedie <sct@redhat.com> writes:

     > Right.  But marking the fact can be done in the inode.  We do
     > that for regular files, after all --- we have an i_size field
     > which marks the value of f_pos which represents EOF.  And
     > _that_ is what I'm suggesting for the NFS case --- record in
     > the inode the cookie which represents EOF, so that in future
     > reads from cache, we still know when we've got to the end of
     > the stream.

That wouldn't really help much here, since that scheme also has a
uniqueness assumption on the cookie. I agree that it would cause a
more graceful failure, since we'd end up truncating the readdir rather
than endlessly looping, but as far as the user is concerned, it's
still wrong behaviour.

The real solution here would be to augment the cookie information in
the struct file with something like a filename in order to define
where we are in the readdir stream.
That doesn't work too well with telldir/seekdir though, and glibc
(grr....) relies heavily on using those in order in their 'heuristic'
that corrects for dirent being larger than the kernel dirent.

Cheers,
  Trond

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266359AbSK1RhF>; Thu, 28 Nov 2002 12:37:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266552AbSK1RhF>; Thu, 28 Nov 2002 12:37:05 -0500
Received: from mons.uio.no ([129.240.130.14]:48326 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S266359AbSK1RhE>;
	Thu, 28 Nov 2002 12:37:04 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15846.21999.949270.354293@charged.uio.no>
Date: Thu, 28 Nov 2002 18:44:15 +0100
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>,
       Ext2 devel <ext2-devel@lists.sourceforge.net>,
       NFS maillist <nfs@lists.sourceforge.net>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [Ext2-devel] Re: [NFS] htree+NFS (NFS client bug?)
In-Reply-To: <20021128171324.G2362@redhat.com>
References: <1038354285.1302.144.camel@sherkaner.pao.digeo.com>
	<shsptsrd761.fsf@charged.uio.no>
	<1038387522.31021.188.camel@ixodes.goop.org>
	<20021127150053.A2948@redhat.com>
	<15845.10815.450247.316196@charged.uio.no>
	<20021127205554.J2948@redhat.com>
	<20021128164439.E2362@redhat.com>
	<20021128171324.G2362@redhat.com>
X-Mailer: VM 7.00 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Stephen C Tweedie <sct@redhat.com> writes:

     > We're only using 31-bit hashes right now.  Trond, how will
     > other NFS clients react if we return an NFS cookie 32-bits
     > wide?  We could easily use something like 0x80000000 as an
     > f_pos to represent EOF in the Linux side of things, but will
     > that cookie work if passed over the wire on NFSv2?

For all other NFS clients that I know of, this is perfectly
acceptable. As far as the Linux kernel goes, it is quite OK, but when
you get to userland, glibc-2.2 and above will insist that this is an
illegal value (they like to sign extend 32-bit values). Causes no end
of trouble, since XFS tends to use '0xffffffff' as the EOF cookie.

I have a patch that hacks the values of such cookies so that glibc
will accept them. That hack will never go in to the official kernel,
so it would be nice if ext2/ext3 could avoid the need for it.

     > The alternative is to hack in a special case so that (for
     > example) we consider a major htree hash of 0x7fffffff to map to
     > an f_pos of 0x7ffffffe and just consider that a possible
     > collision, so that 0x7fffffff is a unique EOF for the htree
     > tree walker.

That would be fine.

Cheers,
  Trond

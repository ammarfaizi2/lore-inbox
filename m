Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265865AbSK1Qux>; Thu, 28 Nov 2002 11:50:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265939AbSK1Qux>; Thu, 28 Nov 2002 11:50:53 -0500
Received: from mons.uio.no ([129.240.130.14]:9669 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S265865AbSK1Quv>;
	Thu, 28 Nov 2002 11:50:51 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15846.19228.868861.629722@charged.uio.no>
Date: Thu, 28 Nov 2002 17:58:04 +0100
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>,
       Ext2 devel <ext2-devel@lists.sourceforge.net>,
       NFS maillist <nfs@lists.sourceforge.net>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [Ext2-devel] Re: [NFS] htree+NFS (NFS client bug?)
In-Reply-To: <20021128164143.D2362@redhat.com>
References: <1038354285.1302.144.camel@sherkaner.pao.digeo.com>
	<shsptsrd761.fsf@charged.uio.no>
	<1038387522.31021.188.camel@ixodes.goop.org>
	<20021127150053.A2948@redhat.com>
	<15845.10815.450247.316196@charged.uio.no>
	<20021127205554.J2948@redhat.com>
	<shslm3e4or2.fsf@charged.uio.no>
	<20021128164143.D2362@redhat.com>
X-Mailer: VM 7.00 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Stephen C Tweedie <sct@redhat.com> writes:

    >> We could possibly cache the EOF status by overloading some
    >> other field in the struct file. f_version comes to mind as a
    >> useful candidate, since it automatically gets reset by llseek.

     > If you want it to be preserved in cache, it needs to be in the
     > inode, not in the file.

You misunderstand the problem. It isn't that the page cache has an
incorrect representation of the stream: the page cache is indeed
stopping filling as soon as it hits the EOF marker.

The problem is that we are stuffing the server-supplied cookies into
file->f_pos and using them to reconstruct where we are in the readdir
stream.
As there is no reserved 'EOF cookie' defined by the protocol that we
might use, we must either rely on the server giving us a unique cookie
also for the EOF case, or else mark the fact that filp->f_pos points
to EOF in some other way.

Cheers,
  Trond

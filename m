Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264885AbSK0Wgu>; Wed, 27 Nov 2002 17:36:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264889AbSK0Wgu>; Wed, 27 Nov 2002 17:36:50 -0500
Received: from mons.uio.no ([129.240.130.14]:28809 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S264885AbSK0Wgt>;
	Wed, 27 Nov 2002 17:36:49 -0500
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>,
       Ext2 devel <ext2-devel@lists.sourceforge.net>,
       NFS maillist <nfs@lists.sourceforge.net>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [Ext2-devel] Re: [NFS] htree+NFS (NFS client bug?)
References: <1038354285.1302.144.camel@sherkaner.pao.digeo.com>
	<shsptsrd761.fsf@charged.uio.no>
	<1038387522.31021.188.camel@ixodes.goop.org>
	<20021127150053.A2948@redhat.com>
	<15845.10815.450247.316196@charged.uio.no>
	<20021127205554.J2948@redhat.com>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 27 Nov 2002 23:44:01 +0100
In-Reply-To: <20021127205554.J2948@redhat.com>
Message-ID: <shslm3e4or2.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Stephen C Tweedie <sct@redhat.com> writes:

    >> If glibc issued a new readdir request (which is what I suspect
    >> has happened here), the NFS client has no idea what the
    >> previous reply was

     > Well, glibc will *always* issue another readdir, because the
     > only way we can ever tell glibc that we're at EOF on the
     > directory is when we eventually return 0 from getdents.  The
     > question about client behaviour is, if we've already been told
     > that the stream is at EOF, should the client simply discard
     > that info and keep reading regardless, or should it cache the
     > EOF status?

We could possibly cache the EOF status by overloading some other field
in the struct file. f_version comes to mind as a useful candidate,
since it automatically gets reset by llseek.

Cheers,
  Trond

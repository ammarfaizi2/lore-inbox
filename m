Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264755AbSK0USu>; Wed, 27 Nov 2002 15:18:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264749AbSK0USu>; Wed, 27 Nov 2002 15:18:50 -0500
Received: from pat.uio.no ([129.240.130.16]:51087 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S264755AbSK0USa>;
	Wed, 27 Nov 2002 15:18:30 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15845.10815.450247.316196@charged.uio.no>
Date: Wed, 27 Nov 2002 21:25:35 +0100
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>,
       Ext2 devel <ext2-devel@lists.sourceforge.net>,
       NFS maillist <nfs@lists.sourceforge.net>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [Ext2-devel] Re: [NFS] htree+NFS (NFS client bug?)
In-Reply-To: <20021127150053.A2948@redhat.com>
References: <1038354285.1302.144.camel@sherkaner.pao.digeo.com>
	<shsptsrd761.fsf@charged.uio.no>
	<1038387522.31021.188.camel@ixodes.goop.org>
	<20021127150053.A2948@redhat.com>
X-Mailer: VM 7.00 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Stephen C Tweedie <sct@redhat.com> writes:

     > So I suspect that this is a root a client problem --- the
     > client has repeated a READDIR despite being told that the
     > previous reply was EOF

I disagree. As far as the client is concerned, it has just been asked
to read the entry that corresponds to that particular cookie.  If
glibc issued a new readdir request (which is what I suspect has
happened here), the NFS client has no idea what the previous reply
was, or even where it was positioned within the page cache (the latter
may have been cleared). All it can do is look up the cookie afresh and
start reading from there.

IOW: A cookie should *always* be unique. There are no exceptions to
this rule.

Cheers,
  Trond

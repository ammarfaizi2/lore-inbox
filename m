Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285048AbRLLCP5>; Tue, 11 Dec 2001 21:15:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285051AbRLLCPs>; Tue, 11 Dec 2001 21:15:48 -0500
Received: from mons.uio.no ([129.240.130.14]:42631 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S284933AbRLLCP2>;
	Tue, 11 Dec 2001 21:15:28 -0500
To: torvalds@transmeta.com (Linus Torvalds)
Cc: linux-kernel@vger.kernel.org
Subject: Re: knfsd and FS_REQUIRES_DEV
In-Reply-To: <Pine.LNX.4.33.0112111810160.541-100000@devserv.devel.redhat.com>
	<20011211.162011.21927662.davem@redhat.com>
	<9v69ci$5e1$1@penguin.transmeta.com>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 12 Dec 2001 03:15:19 +0100
In-Reply-To: <9v69ci$5e1$1@penguin.transmeta.com>
Message-ID: <shszo4p18w8.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Linus Torvalds <torvalds@transmeta.com> writes:

     > Well, that actually could work with things like /proc, which
     > actually has meaningful inode numbers. They may not be stable
     > across reboots, of course, nor even really stable in general,
     > but in _theory_ there's nothing to keep us from exporting /proc
     > files and potentially other virtual filesystems.

I'd be really interested in seeing an NFS client caching protocol that
could cope with this...

For /proc you don't even *want* stability across reboots. That said,
even if you did, the current VFS API is quite sufficient to allow you
to create a protocol that will satisfy those stability
requirements.

The important thing as far as NFS filehandles are concerned is that
the actual information you put in is invariant over reboots, and that
it suffices to locate a file uniquely. With the current API, that
means that we need at least one unique number to identify the actual
'super_operations->fh_to_dentry()' method to be used. Beyond
that, it is entirely up to the fs how it wants to interpret the rest
of the filehandle...

Cheers,
   Trond

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266689AbSKOUqK>; Fri, 15 Nov 2002 15:46:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266690AbSKOUqK>; Fri, 15 Nov 2002 15:46:10 -0500
Received: from mons.uio.no ([129.240.130.14]:53465 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S266689AbSKOUqJ>;
	Fri, 15 Nov 2002 15:46:09 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15829.24239.643774.231548@helicity.uio.no>
Date: Fri, 15 Nov 2002 21:53:03 +0100
To: Christoph Hellwig <hch@infradead.org>
Cc: Petr Vandrovec <VANDROVE@vc.cvut.cz>, linux-kernel@vger.kernel.org,
       richard@bouska.cz
Subject: Re: NFS mountned  directory  and apache2 (2.5.47)
In-Reply-To: <20021115202649.A18706@infradead.org>
References: <79A23782BB8@vcnet.vc.cvut.cz>
	<15829.22032.166977.73195@helicity.uio.no>
	<20021115202649.A18706@infradead.org>
X-Mailer: VM 7.00 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


    >> I disagree. Sendfile can *always* be emulated using the
    >> standard file 'read' method.

     > Linus removed that in early 2.5 because it led to kmap()
     > deadlocks.  sendfile can fail with EINVAL and userspace must
     > not rely on it working on any object.

Fair enough. The kernel may not be the appropriate place for providing
such an emulation, but there's no reason why glibc shouldn't be able
to do so for the case where sendfile returns EINVAL.

However none of this changes the matter of the NFS client. The latter
*does* support a pagecache, and so the one-line patch is appropriate.

Cheers,
  Trond

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268861AbRIDUDp>; Tue, 4 Sep 2001 16:03:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268856AbRIDUDf>; Tue, 4 Sep 2001 16:03:35 -0400
Received: from mons.uio.no ([129.240.130.14]:13262 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S268848AbRIDUD2>;
	Tue, 4 Sep 2001 16:03:28 -0400
To: David Rees <dbr@greenhydrant.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NFS to Irix server broken again in 2.4.9
In-Reply-To: <15253.1002.189305.674221@barley.abo.fi>
	<20010904120737.A17459@greenhydrant.com>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 04 Sep 2001 22:03:43 +0200
In-Reply-To: David Rees's message of "Tue, 4 Sep 2001 12:07:37 -0700"
Message-ID: <shswv3eena8.fsf@charged.uio.no>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == David Rees <dbr@greenhydrant.com> writes:

     > Previous 2.4.X kernels didn't require the 32bitclients option
     > on the IRIX server for some reason.

That was because prior to 2.4.9 the kernel would automatically
truncate the getdents() offsets to 32 bits. We now have true 64 bit
offsets, and they actually get passed back to userland.

glibc-2.x's 32 bit version of readdir() still assumes that
getdents64() syscall returns some an offset (rather than a cookie) and
that the offset fits into 32bits on ordinary directories.
Using '32bitclients' on these older IRIX servers sort of shoehorns
them into the glibc assumptions in the same way the 32 bit truncation
in kernels 2.4.[0-8] did.

Cheers,
   Trond

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264804AbSJPOLG>; Wed, 16 Oct 2002 10:11:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264972AbSJPOLG>; Wed, 16 Oct 2002 10:11:06 -0400
Received: from mons.uio.no ([129.240.130.14]:37841 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S264804AbSJPOLF>;
	Wed, 16 Oct 2002 10:11:05 -0400
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org, peter@chubb.wattle.id.au
Subject: Re: statfs64 missing
References: <20021016140658.GA8461@averell>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 16 Oct 2002 16:16:33 +0200
In-Reply-To: <20021016140658.GA8461@averell>
Message-ID: <shs7kgipiym.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Andi Kleen <ak@muc.de> writes:

     > This problem already exists on 2.4. You can actually access NFS
     > servers which have more than 2TB of disk space. NFS uses the
     > local write size as block size. When you are lucky then
     > 0xfffffffff*wsize is bigger than what your NFS server
     > reports. If not you get wrong results.  The only workaround
     > currently is to increase wsize, but that has its limits too.

     > Fixing it properly probably requires statfs64(). Any reason why
     > this was not included in the sector_t patchkit ?

If fixing NFS is the main concern, and we're adding a new syscall,
could someone also add in an equivalent of the Solaris
etc. 'f_frsize'.

Reporting the underlying local filessystem block size can be of use
for some applications. On NFS this value usually differs from the
'optimal transfer block size' aka. f_bsize.

Cheers,
  Trond

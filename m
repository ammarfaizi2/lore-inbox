Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315619AbSGPXuN>; Tue, 16 Jul 2002 19:50:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315627AbSGPXuM>; Tue, 16 Jul 2002 19:50:12 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:12020 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S315619AbSGPXuL>; Tue, 16 Jul 2002 19:50:11 -0400
Subject: Re: close return value (was Re: [ANNOUNCE] Ext3 vs Reiserfs
	benchmarks)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Zack Weinberg <zack@codesourcery.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020716232225.GH358@codesourcery.com>
References: <20020716232225.GH358@codesourcery.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 17 Jul 2002 02:03:02 +0100
Message-Id: <1026867782.1688.108.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-07-17 at 00:22, Zack Weinberg wrote:
> Making use of the close return value is also never any good.

This is untrue

> Consider: There is no guarantee that close will detect errors.  Only
> NFS and Coda implement f_op->flush methods.  For files on all other
> file systems, sys_close will always return success (assuming the file
> descriptor was open in the first place); the data may still be sitting
> in the page cache.  If you need the data pushed to the physical disk,
> you have to call fsync.

close() checking is not about physical disk guarantees. It's about more
basic "I/O completed". In some future Linux only close() might tell you
about some kinds of I/O error. The fact it doesn't do it now is no
excuse for sloppy programming

> There's also an ugly semantic bind if you make close detect errors.
> If close returns an error other than EBADF, has that file descriptor
> been closed?  The standards do not specify.  If it has not been
> closed, you have a descriptor leak.  But if it has been closed, it is
> too late to recover from the error.  [As far as I know, Unix
> implementations generally do close the descriptor.]

If it bothers you close it again 8)

> The manpage that was quoted earlier in this thread is incorrect in
> claiming that errors will be detected by close; it should be fixed.

The man page matches the stsndard. Implementation may be a subset of the
allowed standard right now, but don't program to implementation
assumptions, it leads to nasty accidents


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284141AbSABUiY>; Wed, 2 Jan 2002 15:38:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286996AbSABUiE>; Wed, 2 Jan 2002 15:38:04 -0500
Received: from mail008.syd.optusnet.com.au ([203.2.75.232]:40114 "EHLO
	mail008.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id <S284141AbSABUh4>; Wed, 2 Jan 2002 15:37:56 -0500
Date: Thu, 3 Jan 2002 07:37:38 +1100
From: Andrew Clausen <clausen@gnu.org>
To: Christoph Hellwig <hch@caldera.de>, linux-kernel@vger.kernel.org,
        bug-parted@gnu.org, evms-devel@lists.sourceforge.net
Subject: Re: [Evms-devel] userspace discovery of partitions
Message-ID: <20020103073738.D922@gnu.org>
In-Reply-To: <20020102055735.C472@gnu.org> <20020102203438.A18445@caldera.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020102203438.A18445@caldera.de>; from hch@caldera.de on Wed, Jan 02, 2002 at 08:34:38PM +0100
X-Accept-Language: en,pt
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 02, 2002 at 08:34:38PM +0100, Christoph Hellwig wrote:
> On Wed, Jan 02, 2002 at 05:57:35AM +1100, Andrew Clausen wrote:
> > When partprobe/libparted are compiled with --enable-discover-only
> > --disable-nls etc (see README), it comes to about 73k (35k
> > compressed), not including libc or libuuid.  Unfortunately, this is
> > still quite large to be including in things like initramfs.  Is
> > it worth paying this price?
> 
> Nope - I'd much prefer aeb's small partx for the same job :)
> In fact it can be cut down even more than the current version. which is
> 30k dynamically linked against glibc.  In fact a striped down version
> wouldn't need a libc so this would be about the size.

If you compile with -Os, and run strip(1), it's 10112 bytes :)
(4868 gzipped).  About 4k of that is common code.

There is probably enough stuff on an initramfs to warrant a dynamic
diet libc?

> It supports dos, solaris, unixware and bsd partitions so far.

It looks like a small amount of work to add support for others too.
I'm convinced now it's better to maintain both partx and libparted
implementations of partition code: one for discovery, one for
editing.

OTOH, the "small" version of libparted is still useful for the Hurd,
so I'll probably keep this small option for libparted.

Thanks for pointing it out :)
Andrew


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965202AbVI1ASo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965202AbVI1ASo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 20:18:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751166AbVI1ASo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 20:18:44 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:57232 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751137AbVI1ASn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 20:18:43 -0400
Date: Wed, 28 Sep 2005 01:18:40 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Hirokazu Takata <takata@linux-m32r.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] m32r: set CHECKFLAGS properly
Message-ID: <20050928001840.GW7992@ftp.linux.org.uk>
References: <E1EJlNM-00059K-R8@ZenIV.linux.org.uk> <20050927.152325.424252181.takata.hirokazu@renesas.com> <Pine.LNX.4.58.0509270758040.3308@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0509270758040.3308@g5.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2005 at 08:00:03AM -0700, Linus Torvalds wrote:
> 
> 
> On Tue, 27 Sep 2005, Hirokazu Takata wrote:
> > 
> > Now, the endianness is to be determined by a (cross)compiler:
> > - For the big-endian, a compiler (m32r-linux-gcc or m32r-linux-gnu-gcc)
> >   provides a predefined macro __BIG_ENDIAN__.
> > - For little-endian, a compiler (m32rle-linux-gcc or m32rle-linux-gnu-gcc)
> >   provides a predefined macro __LITTLE_ENDIAN__.
> 
> Hmm.. You need to tell sparse _some_ way which one you use, since sparse 
> won't do it.
> 
> Picking one at random is fine, of course. It doesn't even have to match 
> the one you'll compile with, although that means that sparse will 
> obviously be testing a different configuration than the one you'd actually 
> compile.
> 
> So I think having -D__BIG_ENDIAN__ in the sparse flags is better than not
> having anything at all (since otherwise it won't be able to check
> anything). And having something that matches the compiler would be better
> still.

Really interesting question is why do we need two toolchains at all.
Note that little-endian m32r gcc at least appears to understand
-mbe/-mbig-endian and binutils handles both endianness just fine.

Does that really work and is there any reason why big-endian one
could not handle -mle the same way with minimal changes?  IOW, do
they have to differ in anything except the default target endianness?

Note that dependencies on "host endianness == target endianness" are
practically guaranteed to cause bugs in cross-compiler, so any of
those would very likely to be a bug in need of fixing anyway...

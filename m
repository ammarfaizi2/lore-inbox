Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270073AbRIAEXP>; Sat, 1 Sep 2001 00:23:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270075AbRIAEXG>; Sat, 1 Sep 2001 00:23:06 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:52374 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S270073AbRIAEWw>;
	Sat, 1 Sep 2001 00:22:52 -0400
Date: Sat, 1 Sep 2001 00:23:05 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Bryan Henderson <hbryan@us.ibm.com>
cc: linux-fsdevel@vger.kernel.org, linux-fsdevel-owner@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jean-Marc Saffroy <saffroy@ri.silicomp.fr>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [RFD] readonly/read-write semantics
In-Reply-To: <OF8E62B3C8.CD1E8E23-ON87256AB9.007E8B1A@boulder.ibm.com>
Message-ID: <Pine.GSO.4.21.0109010015380.15931-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 31 Aug 2001, Bryan Henderson wrote:

> 
> 1) I want to see files open for write have nothing to do with it.  Unix
> open/close is not a transaction, it's just a connection.  Some applications
> manage to use open/close as a transaction, but we're seeing less and less
> of that as more sophisticated facilities for transactions become available.
>
> How many times have we all been frustrated trying to remount read only when
> some log file that hasn't been written to for hours is open for write?
> 
> A file write is in progress when a write() system call hasn't returned, not
> when the file is open for write.

Uh-oh...  How about shared mappings?

> 2) I'd like to see a readonly mount state defined as "the filesystem will
> not change.  Period."  Not for system calls in progress, not for cache
> synchronization, not to set an "unmounted" flag, not for writes that are
> queued in the device driver or device.  (That last one may stretch
> feasability, but it's a worthy goal anyway).

It doesn't work.  Think of r/o mounting of remote filesystem.  Do you
suggest that it should make it impossible to change from other clients?


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261549AbSJPXzq>; Wed, 16 Oct 2002 19:55:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261557AbSJPXzq>; Wed, 16 Oct 2002 19:55:46 -0400
Received: from zero.aec.at ([193.170.194.10]:21257 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id <S261549AbSJPXzp>;
	Wed, 16 Oct 2002 19:55:45 -0400
Date: Thu, 17 Oct 2002 02:01:11 +0200
From: Andi Kleen <ak@muc.de>
To: Peter Chubb <peter@chubb.wattle.id.au>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>, Andi Kleen <ak@muc.de>,
       linux-kernel@vger.kernel.org
Subject: Re: statfs64 missing
Message-ID: <20021017000111.GA25054@averell>
References: <20021016140658.GA8461@averell> <shs7kgipiym.fsf@charged.uio.no> <15789.64263.606518.921166@wombat.chubb.wattle.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15789.64263.606518.921166@wombat.chubb.wattle.id.au>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2002 at 01:49:27AM +0200, Peter Chubb wrote:
>    2.  Change the in-kernel definition of struct statfs to use 64-bit
>        types, (if CONFIG_LBD) and convert at syscall time depending on
>        whether statfs or statfs64 is called (or even, allow glibc to
>        do it, but that's an externally-visible interface change)
> 
> Which is cleaner?  Personally I dislike multiplying interfaces for no
> good reason, so I lean to (2) --- keep the in-kernel paths 64-bit
> clean.

I prefer (2) too.

Regarding the new fields Trond proposed: there is the issue of 64bit
architectures. They already use 64bit block counts, so in theory they 
don't need a statfs64(). But if we wanted to add new fields patterned
after Solaris 64bit would need the new system call too.

So it boils down to if the new fields are important enough to justify
the pain they cause on 64bit.

(I ran into a similar issue with my nanosecond stat patchkit - 
alpha stat is 64bit clean, but doesn't have the padding for ns fields
added used in later ports)

-Andi

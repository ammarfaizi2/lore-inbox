Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314682AbSEKTs1>; Sat, 11 May 2002 15:48:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316269AbSEKTs0>; Sat, 11 May 2002 15:48:26 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:40711 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S314682AbSEKTsZ>;
	Sat, 11 May 2002 15:48:25 -0400
Date: Sat, 11 May 2002 20:48:20 +0100
From: Matthew Wilcox <willy@debian.org>
To: Andrew Morton <akpm@zip.com.au>
Cc: Dave Hansen <haveblue@us.ibm.com>, matthew@wil.cx,
        linux-kernel@vger.kernel.org
Subject: Re: fs/locks.c BKL removal
Message-ID: <20020511204820.N32414@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <3CDC4037.8040104@us.ibm.com> <3CDC45EF.9000506@us.ibm.com> <3CDC5509.DCAF336A@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 10, 2002 at 04:17:29PM -0700, Andrew Morton wrote:
> It was I who put the BKL back into locks.c, much to
> Matthew's disgust...

The disgust was targetted more at removing the abstraction of
locking scheme which I'd put in and having explicit lock_kernel() /
unlock_kernel() calls.  I'd used (iirc) acquire_lock() / release_lock()
macros which could have just been redefined.

> The problem was that replacing the BKL with a semaphore
> seriously damaged Apache thoughput on 8-way.  Apache
> was using flock()-based synchronisation and replacing
> a spin with a schedule just killed it.

Which says that our semaphores suck, because they don't try to spin for a
bit before scheduling.  Of course, your change back was the right thing
to do in the 2.3.late timeframe.

-- 
Revolutions do not require corporate support.

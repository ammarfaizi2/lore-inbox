Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312097AbSCQSfp>; Sun, 17 Mar 2002 13:35:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312096AbSCQSfd>; Sun, 17 Mar 2002 13:35:33 -0500
Received: from mark.mielke.cc ([216.209.85.42]:23307 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id <S312091AbSCQSfR>;
	Sun, 17 Mar 2002 13:35:17 -0500
Date: Sun, 17 Mar 2002 13:31:03 -0500
From: Mark Mielke <mark@mark.mielke.cc>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: Ken Hirsch <kenhirsch@myself.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: fadvise syscall?
Message-ID: <20020317133103.B16140@mark.mielke.cc>
In-Reply-To: <3C945635.4050101@mandrakesoft.com> <005301c1cdc6$5a26de80$0100a8c0@DELLXP1> <5.1.0.14.2.20020317170621.00abd980@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <5.1.0.14.2.20020317170621.00abd980@pop.cus.cam.ac.uk>; from aia21@cam.ac.uk on Sun, Mar 17, 2002 at 05:14:20PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 17, 2002 at 05:14:20PM +0000, Anton Altaparmakov wrote:
> At 15:13 17/03/02, Ken Hirsch wrote:
> >There is a posix_fadvise() syscall in the POSIX Advanced Realtime
> >specification
> >http://www.opengroup.org/onlinepubs/007904975/functions/posix_fadvise.html
> Posix or not I still don't see why one would want that. You know what you 
> are going to be using a file for at open time and you are not going to be 
> changing your mind later. If you can show me a single _real_world_ example 
> where one would genuinely want to change from one access pattern to another 
> without closing/reopening a particular file I would agree that fadvise is a 
> good idea but otherwise I think open(2) is the superior approach.

Also, at least in theory, open() can begin loading pages the moment it
completes (if the system is sufficiently idle). Calling madvise() "at
some later point" would allow a window during which the kernel could
already be loading the wrong pages, before it is *then* told "oh btw, I
really want *these* pages." As an example (assuming open() doesn't do this
already) I would be pleasantly surprised if open(O_RDONLY | O_SEQUENTIAL)
began loading at least the first page in the file the moment open() was
successful. Then, when we get control back to actually do a read() (we
may have been interrupted during open()) the page is already there.

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130614AbRCIR3T>; Fri, 9 Mar 2001 12:29:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130617AbRCIR3J>; Fri, 9 Mar 2001 12:29:09 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:11958 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S130614AbRCIR3F>;
	Fri, 9 Mar 2001 12:29:05 -0500
Date: Fri, 9 Mar 2001 12:28:18 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Chris Mason <mason@suse.com>
cc: linux-kernel@vger.kernel.org, alan@redhat.com
Subject: Re: 2.4.2-ac calls FS truncate w/o BKL
In-Reply-To: <890000000.984152461@tiny>
Message-ID: <Pine.GSO.4.21.0103091223560.14558-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 9 Mar 2001, Chris Mason wrote:

> 
> The added vmtruncate calls in the ac series trigger calls to the FS
> truncate without the BKL held.  Easy enough to fix on the reiserfs side,
> but if other filesystems care we might want to change vmtruncate to grab
> the lock before calling truncate (and update the Locking doc ;-)

Grr... Thanks for spotting - it's my fault. No, I don't think that
we should move BKL into filesystems right now. Should move it into
vmtruncate(), though...

Alan, could you put lock_kernel()/unlock_kernel() around the call of
->truncate() in vmtruncate()?
							Thanks,
								Al


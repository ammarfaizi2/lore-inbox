Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315553AbSEMEKj>; Mon, 13 May 2002 00:10:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315558AbSEMEKi>; Mon, 13 May 2002 00:10:38 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:47023 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S315553AbSEMEKi>;
	Mon, 13 May 2002 00:10:38 -0400
Date: Mon, 13 May 2002 00:10:37 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] devfs v212 available
In-Reply-To: <200205130236.g4D2aPX13250@vindaloo.ras.ucalgary.ca>
Message-ID: <Pine.GSO.4.21.0205130006570.27629-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 12 May 2002, Richard Gooch wrote:

> OK, I've had a look. There is indeed a race there. While it is safe
> against module unloading, it isn't safe against removal of entries
> from the directory. I'm considering some different options to fix this
> (one is simple and obvious, the other will be a little more
> efficient).
> 
> Question: can invalidate_device() and the bdops methods
> check_media_change() and revalidate() be called with a lock held?

Erm...  Depends on the nature of lock.  Spinlocks are out of question,
obviously (at the very least we reread partition table if disk had been
changed and you can't make that nonblocking ;-).  Semaphore might work,
but I would be very careful with deadlocks - the same rereading partition
table could add or remove devfs entries.

Could you describe what are you trying to achieve in the callers of
check_disc_changed()?  I'd been unable to deduce that from code and
some comments would be very welcome.


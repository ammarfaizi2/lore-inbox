Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261562AbRFGPeK>; Thu, 7 Jun 2001 11:34:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261628AbRFGPeA>; Thu, 7 Jun 2001 11:34:00 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:63121 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S261562AbRFGPdl>;
	Thu, 7 Jun 2001 11:33:41 -0400
Date: Thu, 7 Jun 2001 11:33:39 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Florian Weimer <Florian.Weimer@RUS.Uni-Stuttgart.DE>
cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: I/O system call never returns if file desc is closed
 in the
In-Reply-To: <tgk82obhoe.fsf@mercury.rus.uni-stuttgart.de>
Message-ID: <Pine.GSO.4.21.0106071119190.12650-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 7 Jun 2001, Florian Weimer wrote:

> There's a subtle difference: For malloc(), libc has a mutex (or
> whatever), but for open(), socket() etc., no locking is performed, and
> many libc functions create (and destroy) descriptors imlicitely.  

So? You don't have to close() descriptors you had not (to your code
knowledge) opened. End of story.

> I still don't see how you can write maintainable and reliable software
> with asynchronous close().  For example, if some select() call returns
> EBADF after an asynchronous close(), you would have to scan the
> descriptors to find the offending one, but in the meantime, it has
> been reused by another thread.  What do you do in this case?

You don't rely on EBADF. It's _your_ code that had closed the thing. Unless
you pass descriptors of unknown origin into select() (hardly a good idea)
you have all information you need to provide an exclusion.


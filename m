Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286451AbRLTW5a>; Thu, 20 Dec 2001 17:57:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286458AbRLTW5U>; Thu, 20 Dec 2001 17:57:20 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:48076 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S286451AbRLTW5M>;
	Thu, 20 Dec 2001 17:57:12 -0500
Date: Thu, 20 Dec 2001 17:56:37 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: torrey.hoffman@myrio.com, linux-kernel@vger.kernel.org,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: ramdisk corruption problems - was: RE: pivot_root and initrd 
 kern el panic woes
In-Reply-To: <200112201946.fBKJkNw01262@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0112201753170.15555-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 20 Dec 2001, Linus Torvalds wrote:

> The problem is that having buffers doesn't necessarily always mean that
> they are valid, nor that _all_ of them are valid.
> 
> Also, if the ramdisk "readpage" code is wrong, then so is the
> "prepare_write" code.  They share the same logic, which basically says
> that "if the page isn't up-to-date, then it is zero".  Which is always
> true for normal read/write accesses, but as you found out it's not true
> when parts of the page have been accessed by filesystems through the
> buffers. 

AFAICS, it's nastier than that.  What's to stop buffer_heads to be
freed under memory pressure?


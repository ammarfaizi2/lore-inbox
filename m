Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314413AbSESM7u>; Sun, 19 May 2002 08:59:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314411AbSESM7t>; Sun, 19 May 2002 08:59:49 -0400
Received: from mail.libertysurf.net ([213.36.80.91]:42791 "EHLO
	mail.libertysurf.net") by vger.kernel.org with ESMTP
	id <S314413AbSESM7s>; Sun, 19 May 2002 08:59:48 -0400
Date: Sun, 19 May 2002 14:58:35 +0200 (CEST)
From: Rui Sousa <rui.sousa@laposte.net>
X-X-Sender: rsousa@localhost.localdomain
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Rusty Russell <rusty@rustcorp.com.au>, <linux-kernel@vger.kernel.org>,
        <kernel-janitor-discuss@lists.sourceforge.net>
Subject: Re: AUDIT of 2.5.15 copy_to/from_user
In-Reply-To: <E179Q5T-0003jZ-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.44.0205191444200.18395-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 May 2002, Alan Cox wrote:

> > copy_to/from_user() --> will return the number of bytes that were _not_ 
> > copied. If one does not care about partially successes just use:
> > 
> > if (copy_to/from_user())
> > 	return -EFAULT;
> 
> Yes
> 
> > __copy_to/from_user() --> the same as above, but can they actually return 
> > anything other than 0? My assembler is no good and I'm not able to see if
> 
> They do the same things, but don't do any initial range checks that might
> be done by access_ok before hand

On the emu10k1 driver we use access_ok(VERIFY_READ) once at the beginning
of the write() routine to check we can access the user buffer. After that 
we always use __copy_from_user() and we trust it not to fail. Is this 
correct, or not?

Basically, where in copy_from_user() is it determined the function cannot
copy the entire user buffer? Is it in access_ok() only or also in 
__constant_copy_user_zeroing()?

Rui


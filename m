Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265806AbSKAWco>; Fri, 1 Nov 2002 17:32:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265808AbSKAWco>; Fri, 1 Nov 2002 17:32:44 -0500
Received: from air-2.osdl.org ([65.172.181.6]:28066 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S265806AbSKAWch>;
	Fri, 1 Nov 2002 17:32:37 -0500
Date: Fri, 1 Nov 2002 14:34:59 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Andrew Morton <akpm@digeo.com>
cc: Arnd Bergmann <arnd@bergmann-dalldorf.de>,
       <kernel-janitor-discuss@lists.sourceforge.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: might_sleep() in copy_{from,to}_user and friends?
In-Reply-To: <3DC25CA5.B15848E0@digeo.com>
Message-ID: <Pine.LNX.4.33L2.0211011431230.28320-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Nov 2002, Andrew Morton wrote:

| Arnd Bergmann wrote:
| >
| > I have been looking for more places in 2.5 that can be marked
| > might_sleep() and noticed that all the functions in asm/uaccess.h
| > are not marked although they sleep if the memory they access
| > has to be paged in.
| >
| > After adding might_sleep() in ten places in asm-i386/uaccess.h
| > and arch/i386/lib/usercopy.c, I have been running this kernel
| > for about two weeks.
|
| This is an excellent point.  If someone is holding a lock
| across a uaccess function and userspace has passed the address
| of a valid but not-present page we will hit the "atomic copy_user"
| path.  Userspace will be returned an EFAULT and will be left
| scratching its head, wondering what it did wrong.
|
| Or the kernel will deadlock, of course.
|
| I don't think we need to add the check to anything other than
| ia32.  That will pick up the great bulk of any problems, and
| arch-specific code won't be doing these copies much anyway.

Another thing to consider is that the rate-limiting in
__might_sleep() hides lots of instances being reported -- or at
least it did when I removed that rate-limiting and had to wait
for 2-3 minutes for all of that scrolling to finish.

I guess that if enough people test it and give feedback, we'll see
and fix all of them eventually...

-- 
~Randy
"I'm a healthy mushroom."


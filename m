Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267350AbSLEQyt>; Thu, 5 Dec 2002 11:54:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267351AbSLEQyt>; Thu, 5 Dec 2002 11:54:49 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:3347 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267350AbSLEQyr>; Thu, 5 Dec 2002 11:54:47 -0500
Date: Thu, 5 Dec 2002 09:03:03 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: george anzinger <george@mvista.com>
cc: Jim Houston <jim.houston@ccur.com>,
       Stephen Rothwell <sfr@canb.auug.org.au>,
       LKML <linux-kernel@vger.kernel.org>, <anton@samba.org>,
       "David S. Miller" <davem@redhat.com>, <ak@muc.de>, <davidm@hpl.hp.com>,
       <schwidefsky@de.ibm.com>, <ralf@gnu.org>, <willy@debian.org>
Subject: Re: [PATCH] compatibility syscall layer (lets try again)
In-Reply-To: <3DEF20E2.5AEE3E78@mvista.com>
Message-ID: <Pine.LNX.4.44.0212050846100.27298-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 5 Dec 2002, george anzinger wrote:
>
> I think this covers all the bases.  It builds boots and
> runs.  I haven't tested nano_sleep to see if it does the
> right thing yet...

Well, it definitely doesn't, since at least this test is the wrong way
around (as well as being against the coding style whitespace rules ;-p):

+       if ( ! current_thread_info()->restart_block.fun){
+               return current_thread_info()->restart_block.fun(&parm);

Also, I would suggest against having a NULL pointer, and instead just
initializing it with a function that sets it to an error return (don't use
ENOSYS, since the system call _does_ exist, and ENOSYS is what old kernels
would return if you do it by hand by mistake. I'd suggest -EINTR, since
that will "DoTheRightThing(tm)" if we somehow get confused).

		Linus


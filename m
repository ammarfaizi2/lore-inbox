Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283876AbRL3SgS>; Sun, 30 Dec 2001 13:36:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284200AbRL3SgI>; Sun, 30 Dec 2001 13:36:08 -0500
Received: from mnh-1-04.mv.com ([207.22.10.36]:57863 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S283876AbRL3Sfz>;
	Sun, 30 Dec 2001 13:35:55 -0500
Message-Id: <200112301956.OAA02630@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: Lennert Buytenhek <buytenh@gnu.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] global errno considered harmful 
In-Reply-To: Your message of "Sun, 30 Dec 2001 11:06:23 EST."
             <20011230110623.A17083@gnu.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 30 Dec 2001 14:56:21 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

buytenh@gnu.org said:
> Is there any particular reason we need a global errno in the kernel at
> all? (which, by the way, doesn't seem to be subject to any kind of
> locking)  

As far as I've been able to tell, no.

> It makes life for User Mode Linux somewhat more complicated
> than it could be, and it generally just seems a bad idea.

Yeah.  In order for -fno-common to not blow up the UML build (because of the
clash between libc errno and kernel errno), I had to add -Derrno=kernel_errno
to all the kernel file compiles.  It would be nice to get rid of that wart.

> Referenced patch deletes all mention of a global errno from the
> kernel

Awesome.  This definitely needs to happen.  If no one spots any breakage,
send it in...

> and fixes up callers where necessary.

I did some grepping and the only problem I noticed was UML's execve (heh)
converting a -errno return to a -1.

				Jeff


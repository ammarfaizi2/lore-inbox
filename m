Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267535AbTALVVO>; Sun, 12 Jan 2003 16:21:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267536AbTALVVO>; Sun, 12 Jan 2003 16:21:14 -0500
Received: from 5-116.ctame701-1.telepar.net.br ([200.193.163.116]:58603 "EHLO
	5-116.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S267535AbTALVVM>; Sun, 12 Jan 2003 16:21:12 -0500
Date: Sun, 12 Jan 2003 19:29:37 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Rob Wilkens <robw@optonline.net>
cc: Linus Torvalds <torvalds@transmeta.com>,
       Christoph Hellwig <hch@infradead.org>, Greg KH <greg@kroah.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       William Lee Irwin III <wli@holomorphy.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: any chance of 2.6.0-test*?
In-Reply-To: <1042401596.1209.51.camel@RobsPC.RobertWilkens.com>
Message-ID: <Pine.LNX.4.50L.0301121925140.26759-100000@imladris.surriel.com>
References: <Pine.LNX.4.44.0301121134340.14031-100000@home.transmeta.com>
 <1042401596.1209.51.camel@RobsPC.RobertWilkens.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Jan 2003, Rob Wilkens wrote:

> However, I have always been taught, and have always believed that
> "goto"s are inherently evil.  They are the creators of spaghetti code

If the main flow of the code is through a bunch of hard to trace
gotos and you choose to blame the tool instead of the programmer,
I guess you could blame goto.

However, the goto can also be a great tool to make the code more
readable.  The goto statement is, IMHO, one of the more elegant
ways to code exceptions into a C function; that is, dealing with
error situations that don't happen very often, in such a way that
the error handling code doesn't clutter up the main code path.

As an example, you could look at fs/super.c::do_kern_mount()

        mnt = alloc_vfsmnt(name);
        if (!mnt)
                goto out;
        sb = type->get_sb(type, flags, name, data);
        if (IS_ERR(sb))
                goto out_mnt;

Do you see how the absence of the error handling cleanup code
makes the normal code path easier to read ?

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".
http://www.surriel.com/		http://guru.conectiva.com/
Current spamtrap:  <a href=mailto:"october@surriel.com">october@surriel.com</a>

Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316209AbSEKLmo>; Sat, 11 May 2002 07:42:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316211AbSEKLmn>; Sat, 11 May 2002 07:42:43 -0400
Received: from meg.hrz.tu-chemnitz.de ([134.109.132.57]:11014 "EHLO
	meg.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S316209AbSEKLmn>; Sat, 11 May 2002 07:42:43 -0400
Date: Sat, 11 May 2002 13:42:39 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] BUG() disassembly tweak
Message-ID: <20020511134239.F635@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <Pine.LNX.4.21.0205102216160.3747-100000@localhost.localdomain> <Pine.LNX.4.33.0205101457120.22516-100000@penguin.transmeta.com> <20020511005115.N5262@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 11, 2002 at 12:51:15AM +0200, Dave Jones wrote:
> On Fri, May 10, 2002 at 03:10:04PM -0700, Linus Torvalds wrote:
>  > If it wants to be changed, I'd actually personally prefer it to be changed
>  > to take an explicit string instead of using the filename/linenr at all.
[...]
> Failing that, resurrecting the k_assert() idea someone proposed
> (jgarzik?) a few months back.

Oh? I remember many people having objections against assert.

Personally I like BUG_ON() as is and it helped me already
catching a lot of bugs in my own code and removed the need for
several conditions and cleanup code for situation, that happen only
with wrong arguments/corruption and are bugs instead of user
stupidity.

BUG() is usally used, when we need to print much more information
about the error (like dumping some variables, which have wrong
values). In these cases a BUG_PRINTK() would be much more
useful, since most users of BUG() use printk before and only want
to save cleanup code for "impossible" conditions.

Or at least have a variant of BUG(), which has only triggers the
code path aborting, without printing filename/line_no (because
our own debug statements did this already).

Regards

Ingo Oeser
-- 
Science is what we can tell a computer. Art is everything else. --- D.E.Knuth

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261672AbVGUH1D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261672AbVGUH1D (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 03:27:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261671AbVGUH1C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 03:27:02 -0400
Received: from mail.fh-wedel.de ([213.39.232.198]:40876 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S261663AbVGUH06 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 03:26:58 -0400
Date: Thu, 21 Jul 2005 09:26:53 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Jan Blunck <j.blunck@tu-harburg.de>
Cc: Chris Wedgwood <cw@f00f.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ramfs: pretend dirent sizes
Message-ID: <20050721072653.GB17431@wohnheim.fh-wedel.de>
References: <20050716003952.GA30019@taniwha.stupidest.org> <42DCC7AA.2020506@tu-harburg.de> <20050719161623.GA11771@taniwha.stupidest.org> <42DD44E2.3000605@tu-harburg.de> <20050719183206.GA23253@taniwha.stupidest.org> <42DD50FC.9090004@tu-harburg.de> <20050719191648.GA24444@taniwha.stupidest.org> <20050720112127.GC3890@wohnheim.fh-wedel.de> <20050720181101.GB11609@taniwha.stupidest.org> <42DE9C71.7090903@tu-harburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <42DE9C71.7090903@tu-harburg.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 July 2005 20:48:17 +0200, Jan Blunck wrote:
> 
> I don't want to tell where these are in general, I need an easy way to 
> seek to the m'th directory + offset position without reading every 
> single dirent. With i_sizes != 0 it is straight forward to use "the sum 
> of the m directory's i_sizes + offset" as the f_pos to seek to. For this 
> purpose it is not necessary to have a "honest" i_size as long as the 
> i_size is bigger than the offset of the last dirent in the directory.

So you use file->offset of the pseudo-directory representing the whole
union stack for two values:
1. level within the union stack we're currently at and
2. offset within the real directory at said level.

And you need a sane value for i_size at every level (but perhaps the
last) to break the converged file->offset apart into (level, offset)
again.  Right?

> >>Reopening the same directory may result in a formerly proper offset
> >>isn't anymore.
> 
> Which is a user problem again. Might be that you are opening a different 
> directory with the same name ... or even a regular file!

Yep.  Two consecutive open() on the "same file" are racy, so anything
could have happened in between.  That's a well-known proplem in
userspace.

Jörn

-- 
Linux is more the core point of a concept that surrounds "open source"
which, in turn, is based on a false concept. This concept is that
people actually want to look at source code.
-- Rob Enderle

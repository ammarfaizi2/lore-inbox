Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261353AbREWKBC>; Wed, 23 May 2001 06:01:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261369AbREWKAw>; Wed, 23 May 2001 06:00:52 -0400
Received: from horus.its.uow.edu.au ([130.130.68.25]:14043 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S261353AbREWKAd>; Wed, 23 May 2001 06:00:33 -0400
Message-ID: <3B0B8924.F0B78288@uow.edu.au>
Date: Wed, 23 May 2001 19:55:48 +1000
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Manas Garg <mls@chakpak.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: O_TRUNC problem on a full filesystem
In-Reply-To: <20010523114318.A8336@cygsoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manas Garg wrote:
> 
> I am not sure if it should be classified as a bug, that's why I am calling it a
> problem. Here is the description:
> 

It works fine with ext3 :)

That's because ext3 has per-file block preallocation
disabled.

When you truncated your file, the blocks remained preallocated
on behalf of the file, and were hence considered "used".  For
some reason, a subsequent attempt to allocate blocks for the
same file failed to use that file's preallocated blocks.

It's an arguable bug in ext2 and, as you've seen, the consequences
are bad.  Your applications _are_ a little bit buggy,
because they can't assume that just because they
truncated the file, that space will remain available to
them.

Maybe someone would like to wade through screenfuls of icky
single-char identifiers and fix it?

-

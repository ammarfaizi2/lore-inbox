Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293603AbSDIQj3>; Tue, 9 Apr 2002 12:39:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293632AbSDIQj2>; Tue, 9 Apr 2002 12:39:28 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:45072 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S293603AbSDIQj0>; Tue, 9 Apr 2002 12:39:26 -0400
Date: Tue, 9 Apr 2002 18:22:00 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@zip.com.au>
Cc: Andrey Nekrasov <andy@spylog.ru>, linux-kernel@vger.kernel.org
Subject: Re: BUG: 2.4.19-pre6aa1
Message-ID: <20020409182200.E15656@dualathlon.random>
In-Reply-To: <20020409084335.GA10890@spylog.ru> <3CB2B09C.DF1A0AC2@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 09, 2002 at 02:13:00AM -0700, Andrew Morton wrote:
> Andrey Nekrasov wrote:
> > 
> > ..
> > >>EIP; e0115c1c <out_of_line_bug+0/14>   <=====
> > Trace; e012069a <copy_page_range+1da/334>
> > Trace; e0114caa <copy_mm+222/2bc>
> > Trace; e01154b6 <do_fork+42e/744>
> > Trace; e0107270 <sys_fork+14/1c>
> 
> hmm.  That out-of-line stuff has obfuscated the trace
> a bit.  It died in kunmap_atomic or kmap_atomic, part
> of Andrea's pte-highmem additions.
> 
> I guess the out-of-line bug should be if !CONFIG_DEBUG_KERNEL.

I didn't complained yet but the whole point of the BUG() was to get such
a printk in the right place. Now the above report is trivial and the
debugging check triggered a false positive bugcheck due
CONFIG_DEBUG_HIGHMEM=y (I always compile with =n and that's why I didn't
triggered it here), but sometime it isn't that easy to find it out, in
particular when there are plenty of BUG()s in a row like in
page_alloc.c, so I disagree with the merger of the out_of_line_bug in
mainline.

I will the false positive bugcheck it in next -aa, for now you can
simply recompile the kernel with CONFIG_DEBUG_HIGHMEM=n (kernel hacking
menu) and you'll be just fine.

thanks for the feedback Andrey,

Andrea

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263411AbTIHPnX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 11:43:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263436AbTIHPnX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 11:43:23 -0400
Received: from ns.suse.de ([195.135.220.2]:52172 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263411AbTIHPmp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 11:42:45 -0400
To: Rolf Eike Beer <eike-kernel@sf-tec.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.4.23-pre3] Possible bug in fs/buffer.c
References: <200309081715.09657@bilbo.math.uni-mannheim.de>
From: Andreas Schwab <schwab@suse.de>
X-Yow: What a COINCIDENCE!  I'm an authorized ``SNOOTS OF THE STARS''
 dealer!!
Date: Mon, 08 Sep 2003 17:42:40 +0200
In-Reply-To: <200309081715.09657@bilbo.math.uni-mannheim.de> (Rolf Eike
 Beer's message of "Mon, 8 Sep 2003 17:15:09 +0200")
Message-ID: <je3cf7uw0f.fsf@sykes.suse.de>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rolf Eike Beer <eike-kernel@sf-tec.de> writes:

> This is __put_unused_buffer_head from fs/buffer.c, lines 1156 to 1171:
>
>
> static void __put_unused_buffer_head(struct buffer_head * bh)
> {
> 	if (unlikely(buffer_attached(bh)))
> 		BUG();
> 	if (nr_unused_buffer_heads >= MAX_UNUSED_BUFFERS) {
> 		kmem_cache_free(bh_cachep, bh);
> 	} else {
> 		bh->b_dev = B_FREE;
> ===>		bh->b_blocknr = -1;		<===
> 		bh->b_this_page = NULL;
>
> 		nr_unused_buffer_heads++;
> 		bh->b_next_free = unused_list;
> 		unused_list = bh;
> 	}
> }
>
> In include/linux/fs.h "struct buffer_head" is defined this way:
>
> struct buffer_head {
>         /* First cache line: */
>         struct buffer_head *b_next;     /* Hash queue list */
>         unsigned long b_blocknr;        /* block number */
> ...
>
> So this line (and line 1205, which is the same) is either ugly (and someone
> meant ~0UL or something similar) or completely bogus.

It's neither ugly, nor bogus.  The only 100% reliable way to assign the
maximum value to an unsigned integer is to use -1.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Deutschherrnstr. 15-19, D-90429 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."

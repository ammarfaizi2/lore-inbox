Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272837AbTHEQ2T (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 12:28:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272863AbTHEQ2T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 12:28:19 -0400
Received: from hera.cwi.nl ([192.16.191.8]:20934 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S272837AbTHEQ1K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 12:27:10 -0400
From: Andries.Brouwer@cwi.nl
Date: Tue, 5 Aug 2003 18:27:07 +0200 (MEST)
Message-Id: <UTC200308051627.h75GR7J08241.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, akpm@osdl.org
Subject: Re: i_blksize
Cc: aebr@win.tue.nl, linux-kernel@vger.kernel.org, torvalds@osdl.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Looks like I got myself confused

Yes. But nevertheless, now that you brought this up,
we might consider throwing out i_blksize.

I am not aware of anybody who actually uses this to give
per-file advice. So, it could be in the superblock.
There is no reason why it would be a power of two -
the case mentioned yesterday or so was cifs, with

        inode->i_blksize =
            (pTcon->ses->server->maxBuf - MAX_CIFS_HDR_SIZE) & 0xFFFFFE00;

I see no reason not to replace i_blksize by i_sb->s_optimal_io_size.

Any objections?

If sizeof(struct inode) decreases by 1% then we can keep 1% more inodes.

That reminds me - I threw out i_dev and i_cdev, but Al reintroduced i_cdev.
We should do as some comment says and make a union with i_bdev and i_pipe.
Another 8 bytes gone.

Andries


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272423AbTHEGJH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 02:09:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272454AbTHEGJH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 02:09:07 -0400
Received: from fw.osdl.org ([65.172.181.6]:43694 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S272423AbTHEGJF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 02:09:05 -0400
Date: Mon, 4 Aug 2003 23:10:26 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: i_blksize
Message-Id: <20030804231026.0d7251f2.akpm@osdl.org>
In-Reply-To: <20030805025846.GA4779@win.tue.nl>
References: <UTC200308040203.h7423rv14876.aeb@smtp.cwi.nl>
	<20030803192919.0d7d881c.akpm@osdl.org>
	<20030805025846.GA4779@win.tue.nl>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries Brouwer <aebr@win.tue.nl> wrote:
>
> You propose to remove i_blksize.
>  Yes, a good plan, half an hour's work.
>  It is used in stat only, so we have to produce some value for stat.
>  Do you want to replace
>  	inode->i_blksize
>  by
>  	inode->i_sb->s_optimal_io_size
>  ?

No, that's different.  You are referring to stat.st_blksize.  That is a
different animal, and we can leave that alone.

inode->i_blksize is equal to (1 << inode->i_blkbits) always, all the time. 
It is just duplicated nonsense and usually leads to poorer code -
multiplications instead of shifts.

It should be a pretty easy incremental set of patches to ease i_blksize out
of the kernel.


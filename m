Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267510AbUG2Wrf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267510AbUG2Wrf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 18:47:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267527AbUG2Woh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 18:44:37 -0400
Received: from fw.osdl.org ([65.172.181.6]:3467 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267519AbUG2WnI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 18:43:08 -0400
Date: Thu, 29 Jul 2004 15:46:25 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jan Blunck <j.blunck@tu-harburg.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext2_readdir() filp->f_pos fix
Message-Id: <20040729154625.0a6f48a3.akpm@osdl.org>
In-Reply-To: <41094D69.9030008@tu-harburg.de>
References: <41094D69.9030008@tu-harburg.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Blunck <j.blunck@tu-harburg.de> wrote:
>
> If the whole inode is read, ext2_readdir() sets the f_pos to a multiple 

                    ^^ directory

> of the page size (because of the conditions of the outer for loop). This 
> sets the wrong f_pos for directory inodes on ext2 partitions with a 
> block size differing from the page size.

Interesting.  How did you actually notice this?  Is the same problem not present
in 2.4?

If the IS_ERR(page) returns true, should we not advance f_pos to skip this
page?

If the filldir() call returns non-zero your patch will leave f_pos pointing at
the problematic directory entry.  I'm not sure whether this is desirable.

hmm, ext2_readir() isn't propagating EFAULT back up to the caller.

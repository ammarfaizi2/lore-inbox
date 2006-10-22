Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932311AbWJVJLq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932311AbWJVJLq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 05:11:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932314AbWJVJLp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 05:11:45 -0400
Received: from mail.parknet.jp ([210.171.160.80]:45572 "EHLO parknet.jp")
	by vger.kernel.org with ESMTP id S932311AbWJVJLo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 05:11:44 -0400
X-AuthUser: hirofumi@parknet.jp
To: Nick Piggin <npiggin@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, Damien Wyart <damien.wyart@free.fr>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.19-rc2-mm2 : empty files on vfat file system
References: <20061021104454.GA1996@localhost.localdomain>
	<87lkn9x0ly.fsf@duaron.myhome.or.jp>
	<20061021173849.GA1999@localhost.localdomain>
	<20061021131932.09801b4a.akpm@osdl.org>
	<873b9htne9.fsf@duaron.myhome.or.jp>
	<20061022015028.GB17694@wotan.suse.de>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sun, 22 Oct 2006 18:11:36 +0900
In-Reply-To: <20061022015028.GB17694@wotan.suse.de> (Nick Piggin's message of "Sun\, 22 Oct 2006 03\:50\:28 +0200")
Message-ID: <87lkn8sojb.fsf@duaron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <npiggin@suse.de> writes:

> On Sun, Oct 22, 2006 at 05:38:38AM +0900, OGAWA Hirofumi wrote:
>> 
>> As I said in this thread, generic_cont_expand() uses "to == from".
>> Should we fix generic_cont_expand() instead? I don't know the
>> background of this patch.
>
> OK I have to write an RFC for various fs developers, so I'll be sure
> to include you.
>
> We want to be able to pass in a short (possibly zero) commit_write
> length if the page data can not be fully copied.

Thanks. So, if the range is zero, what should fs driver do?

> generic_cont_expand seems to be using that as a shorthand for
> "update the i_size but don't mark anything uptdoate"? If so, I think
> it would be nice to fix it. Why does it even need to go through the
> prepare/commit?

It's not only for updating ->i_size.

__generic_cont_expand() is used for expanding ->i_size by trucate(2).
In FAT case, it needs to fill the hole by zero and dirty it before
write new ->i_size. The ->prepare_write() does it, and ->commit_write()
writes ->i_size and dirty inode in __generic_cont_expand().

Anyway, if it's required, maybe we would be able to change
__generic_cont_expand().
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

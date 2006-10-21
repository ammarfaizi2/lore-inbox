Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750794AbWJUUiq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750794AbWJUUiq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 16:38:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161026AbWJUUiq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 16:38:46 -0400
Received: from mail.parknet.jp ([210.171.160.80]:36100 "EHLO parknet.jp")
	by vger.kernel.org with ESMTP id S1750794AbWJUUip (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 16:38:45 -0400
X-AuthUser: hirofumi@parknet.jp
To: Andrew Morton <akpm@osdl.org>
Cc: Damien Wyart <damien.wyart@free.fr>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Nick Piggin <npiggin@suse.de>
Subject: Re: 2.6.19-rc2-mm2 : empty files on vfat file system
References: <20061021104454.GA1996@localhost.localdomain>
	<87lkn9x0ly.fsf@duaron.myhome.or.jp>
	<20061021173849.GA1999@localhost.localdomain>
	<20061021131932.09801b4a.akpm@osdl.org>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sun, 22 Oct 2006 05:38:38 +0900
In-Reply-To: <20061021131932.09801b4a.akpm@osdl.org> (Andrew Morton's message of "Sat\, 21 Oct 2006 13\:19\:32 -0700")
Message-ID: <873b9htne9.fsf@duaron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> On Sat, 21 Oct 2006 19:38:49 +0200
> Damien Wyart <damien.wyart@free.fr> wrote:
>
>> > --- a/fs/fat/inode.c~fs-prepare_write-fixes
>> > +++ a/fs/fat/inode.c
>> > @@ -150,7 +150,11 @@ static int fat_commit_write(struct file 
>> >  			    unsigned from, unsigned to)
>> >  {
>> >  	struct inode *inode = page->mapping->host;
>> > -	int err = generic_commit_write(file, page, from, to);
>> > +	int err;
>> > +	if (to - from > 0)
>> > +		return 0;
>> > +
>
> That should have been
>
> 	if (to - from == 0)
> 		return 0;

As I said in this thread, generic_cont_expand() uses "to == from".
Should we fix generic_cont_expand() instead? I don't know the
background of this patch.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

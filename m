Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262471AbUKWC6s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262471AbUKWC6s (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 21:58:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262550AbUKWC4i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 21:56:38 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:34833 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S262500AbUKWCzk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 21:55:40 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] problem of cont_prepare_write()
References: <877joexjk5.fsf@devron.myhome.or.jp>
	<20041122024654.37eb5f3d.akpm@osdl.org>
	<87ekimw1uj.fsf@devron.myhome.or.jp>
	<20041122134344.3b2cb489.akpm@osdl.org>
	<87k6sdwbhy.fsf@devron.myhome.or.jp>
	<20041122183006.5ef3b41c.akpm@osdl.org>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Tue, 23 Nov 2004 11:55:31 +0900
In-Reply-To: <20041122183006.5ef3b41c.akpm@osdl.org> (Andrew Morton's
 message of "Mon, 22 Nov 2004 18:30:06 -0800")
Message-ID: <87brdpw9y4.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

>> But, it's not required... yes?
>
> yes, it's needed in theory - see generic_file_buffered_write().  I'm trying
> to remember why...
>
> I think the only problem which that is solving is that the filesystem may
> have left some blocks in the file outside i_size.  That's a minor
> consistency issue which a fsck will fix up.  But I guess a subsequent lseek
> may permit unwritten disk blocks to be read.
>
> This problem is present whenever ->prepare_write() is called and we really
> shouldn't be open-coding it everywhere.

I see. Thanks.

>> Anyway, fixed patch is the following.
>
> Thanks. Does it pass all your testing?

Sorry, no. I'm still compiling kernel. I'll report the result of test
to you (probably few hours).
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283588AbRK3Kle>; Fri, 30 Nov 2001 05:41:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283587AbRK3KlZ>; Fri, 30 Nov 2001 05:41:25 -0500
Received: from mail.parknet.co.jp ([210.134.213.6]:5896 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP
	id <S283598AbRK3KlK>; Fri, 30 Nov 2001 05:41:10 -0500
To: Andrew Morton <akpm@zip.com.au>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] smarter atime updates
In-Reply-To: <3C072279.D346CD09@zip.com.au> <3C072279.D346CD09@zip.com.au>
	<87n1144mo6.fsf@devron.myhome.or.jp> <3C0757B0.CF881394@zip.com.au>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Fri, 30 Nov 2001 19:40:36 +0900
In-Reply-To: <3C0757B0.CF881394@zip.com.au>
Message-ID: <87snaw35jv.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@zip.com.au> writes:

> OGAWA Hirofumi wrote:
> > 
> > #define UPDATE_ATIME(inode)                     \
> > do {                                            \
> >         if ((inode)->i_atime != CURRENT_TIME)   \
> >                 update_atime (inode);           \
> > } while (0)
> > 
> 
> yes, that'd be fine.  The more conventional approach
> would be to blow away the strange UPPER CASE name and:
> 
> static inline void update_atime(struct inode *inode)
> {
> 	if (inode->i_atime != CURRENT_TIME)
> 		__update_atime(inode);
> }
> 
> But that would be a bigger patch, and I rather like shaving
> off three quarters of the sys_read() overhead with a two-liner ;)

Umm, I think only fs/autofs4/root.c use update_atime() directly.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

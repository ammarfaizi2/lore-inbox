Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283583AbRK3J4s>; Fri, 30 Nov 2001 04:56:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283587AbRK3J4i>; Fri, 30 Nov 2001 04:56:38 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:38926 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S283583AbRK3J41>; Fri, 30 Nov 2001 04:56:27 -0500
Message-ID: <3C0757B0.CF881394@zip.com.au>
Date: Fri, 30 Nov 2001 01:56:00 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
CC: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] smarter atime updates
In-Reply-To: <3C072279.D346CD09@zip.com.au>,
		<3C072279.D346CD09@zip.com.au> <87n1144mo6.fsf@devron.myhome.or.jp>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OGAWA Hirofumi wrote:
> 
> #define UPDATE_ATIME(inode)                     \
> do {                                            \
>         if ((inode)->i_atime != CURRENT_TIME)   \
>                 update_atime (inode);           \
> } while (0)
> 

yes, that'd be fine.  The more conventional approach
would be to blow away the strange UPPER CASE name and:

static inline void update_atime(struct inode *inode)
{
	if (inode->i_atime != CURRENT_TIME)
		__update_atime(inode);
}

But that would be a bigger patch, and I rather like shaving
off three quarters of the sys_read() overhead with a two-liner ;)

-

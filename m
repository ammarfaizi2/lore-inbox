Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261970AbVCGXdZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261970AbVCGXdZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 18:33:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261903AbVCGWxk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 17:53:40 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:44295 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261344AbVCGWBZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 17:01:25 -0500
Date: Mon, 7 Mar 2005 23:01:23 +0100
From: Adrian Bunk <bunk@stusta.de>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 23/29] FAT: Remove the multiple MSDOS_SB() call
Message-ID: <20050307220123.GI3170@stusta.de>
References: <87wtsmorii.fsf_-_@devron.myhome.or.jp> <87sm3aorho.fsf_-_@devron.myhome.or.jp> <87oedyorgu.fsf_-_@devron.myhome.or.jp> <87k6olq60a.fsf_-_@devron.myhome.or.jp> <87fyz9q5z7.fsf_-_@devron.myhome.or.jp> <87br9xq5y8.fsf_-_@devron.myhome.or.jp> <877jklq5x7.fsf_-_@devron.myhome.or.jp> <873bv9q5vx.fsf_-_@devron.myhome.or.jp> <87y8d1orah.fsf_-_@devron.myhome.or.jp> <87u0npor9o.fsf_-_@devron.myhome.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87u0npor9o.fsf_-_@devron.myhome.or.jp>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 06, 2005 at 03:56:51AM +0900, OGAWA Hirofumi wrote:
> 
> Since MSDOS_SB() is inline function, it increases text size at each calls.
> I don't know whether there is __attribute__ for avoiding this.
> 
> This removes the multiple call.
>...

"inline" in the kernel is (for recent gcc's) mapped to 
__attribute__((always_inline)), and therefore the
"static inline struct msdos_sb_info *MSDOS_SB" does exactly the opposite 
of what you want.

You'd have to move this into a .c file to remove the "inline".

But considering that the whole function is

static inline struct msdos_sb_info *MSDOS_SB(struct super_block *sb)
{
        return sb->s_fs_info;
}

I'm quite surprised that there's any problem with it.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


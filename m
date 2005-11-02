Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751522AbVKBSEF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751522AbVKBSEF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 13:04:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965137AbVKBSEE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 13:04:04 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:3602 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751523AbVKBSED (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 13:04:03 -0500
Date: Wed, 2 Nov 2005 19:04:01 +0100
From: Adrian Bunk <bunk@stusta.de>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: Ben Dooks <ben-linux@fluff.org>, linux-kernel@vger.kernel.org
Subject: Re: fs/fat - fix sparse warning
Message-ID: <20051102180401.GA4272@stusta.de>
References: <20051031113639.GA30667@home.fluff.org> <87zmophiwp.fsf@devron.myhome.or.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zmophiwp.fsf@devron.myhome.or.jp>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2005 at 11:15:34PM +0900, OGAWA Hirofumi wrote:
> Ben Dooks <ben-linux@fluff.org> writes:
> 
> > move fat_cache_init/fat_cache_destroy to a common
> > header file in fs/fat so that inode.c and cache.c
> > see the same definition, and to stop warnings
> > from sparse about undeclared functions
> 
> The fs/fat/* has many internal functions, it is in
> include/linux/msdos_fs.h.  Please move those internal functions to one
> internal header (probably fs/fat/fat.h?).
> 
> This seems be just for sparse, please do real cleanup instead.

It's not only for sparse.

The -Wmissing-prototypes flag to gcc gives similar warnings, and I'm 
also cleaning up code for adding this flag to the CFLAGS.

Why?

It sometimes happens that the signature of a function changes and it is 
forgotten to update all prototypes.

If the prototype is in a header file, gcc tells about the mistake.

If the prototype is in the C file gcc can't help us and it might take 
some time until someone tracks the source of the nasty runtime problems 
this might cause.

It's your choice as subsystem maintainer which header file the 
prototypes should go into - it is only important that both the file with 
the actual function and all users of this function #include this header.

> OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


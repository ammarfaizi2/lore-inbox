Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268721AbRHBTWF>; Thu, 2 Aug 2001 15:22:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268813AbRHBTV4>; Thu, 2 Aug 2001 15:21:56 -0400
Received: from thebsh.namesys.com ([212.16.0.238]:15881 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S268721AbRHBTVr>; Thu, 2 Aug 2001 15:21:47 -0400
Message-ID: <3B69A84A.8050F9F2@namesys.com>
Date: Thu, 02 Aug 2001 23:21:46 +0400
From: Hans Reiser <reiser@namesys.com>
Organization: Namesys
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en, ru
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: Linus Torvalds <Torvalds@Transmeta.COM>,
        Nikita Danilov <NikitaDanilov@Yahoo.COM>,
        Reiserfs developers mail-list <Reiserfs-Dev@namesys.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [reiserfs-dev] Re: [PATCH]: reiserfs: D-clear-i_blocks.patch
In-Reply-To: <Pine.GSO.4.21.0108021322360.29563-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:

> Thanks for spotting, but I have to disagree with analysis.
>         a) it's a procfs bug. We leave ->i_blocks uninitialized and inode
> constructor leaves it in undefined state.
>         b) I'd rather fix it once in fs/inode.c::clean_inode() instead of
> hunting similar bugs down again and again.
> 
> See if the patch below works for you. It makes sure that inodes passed to
> ->read_inode() or returned by new_inode() have zero in i_blocks and removes
> the redundant assignments in filesystems. Warning: it's completely untested.

Nikita sent you an email saying that he though you should fix it in the manner
you fixed it above, and then posted a patch which was localized in its impact to
just ReiserFS because he was sure it was correct.

Nikita should be more aggressive in patching VFS rather than asking you to do
it, but I don't think you can claim to be differing with his analysis.

Hans

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267265AbSK3QIz>; Sat, 30 Nov 2002 11:08:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267266AbSK3QIz>; Sat, 30 Nov 2002 11:08:55 -0500
Received: from smtp06.iddeo.es ([62.81.186.16]:5815 "EHLO smtp06.retemail.es")
	by vger.kernel.org with ESMTP id <S267265AbSK3QIy>;
	Sat, 30 Nov 2002 11:08:54 -0500
Date: Sat, 30 Nov 2002 17:16:18 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@digeo.com>, hugang <hugang@soulinfo.com>
Subject: [BUG] ext3-orlov for 2.4
Message-ID: <20021130161618.GK2517@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

HI all...

Tell me if this is correct. GCC-3.2 spits a wrning like this when
building -jam, I did not noticed before:

ialloc.c: In function `ext3_new_inode':
ialloc.c:546: warning: comparison between pointer and integer
ialloc.c:682: warning: label `out' defined but not used
ialloc.c:520: warning: `gdp' might be used uninitialized in this function

Line is question is:
    if (gdp == -1)
        goto fail;
It comes from the orlov-allocator for ext3.

Looking at the structure of ext3_new_inode:

struct inode * ext3_new_inode (handle_t *handle, struct inode * dir, int mode)
{
    ...
    struct ext3_group_desc * gdp;
        
repeat:
    ...
    if (gdp == -1)
        goto fail;
    ...
    gdp = ext3_get_group_desc (sb, group, &bh2);
    ...                    

Thigs to note:
- gdp is used without previous initialization.
- gdp is a pointer and is compared with -1

Should not the structure be:
    gdp = ext3_get_group_desc (sb, group, &bh2);
    if (!gdp)
        goto fail;

Can anybody check 2.5 for this also ?

???

TIA

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.1 (Cooker) for i586
Linux 2.4.20-jam0 (gcc 3.2 (Mandrake Linux 9.1 3.2-4mdk))

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282355AbRKXGB5>; Sat, 24 Nov 2001 01:01:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282367AbRKXGBi>; Sat, 24 Nov 2001 01:01:38 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:30475 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S282355AbRKXGBa>; Sat, 24 Nov 2001 01:01:30 -0500
Date: Fri, 23 Nov 2001 21:55:42 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: Alexander Viro <viro@math.psu.edu>, <linux-kernel@vger.kernel.org>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: 2.4.15-pre9 breakage (inode.c)
In-Reply-To: <20011124064739.J1324@athlon.random>
Message-ID: <Pine.LNX.4.33.0111232154320.1821-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 24 Nov 2001, Andrea Arcangeli wrote:
>
> --- 2.4.15pre9aa1/fs/inode.c.~1~	Thu Nov 22 20:48:23 2001
> +++ 2.4.15pre9aa1/fs/inode.c	Sat Nov 24 06:30:20 2001
> @@ -1071,7 +1071,7 @@
>  			if (inode->i_state != I_CLEAR)
>  				BUG();
>  		} else {
> -			if (!list_empty(&inode->i_hash) && sb && sb->s_root) {
> +			if (!list_empty(&inode->i_hash)) {
>  				if (!(inode->i_state & (I_DIRTY|I_LOCK))) {
>  					list_del(&inode->i_list);
>  					list_add(&inode->i_list, &inode_unused);

I have to say that I like this patch better myself - the added tests are
not sensible, and just removing them seems to be the right thing.

		Linus


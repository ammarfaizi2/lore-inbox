Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135277AbRDLTcd>; Thu, 12 Apr 2001 15:32:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135271AbRDLTcY>; Thu, 12 Apr 2001 15:32:24 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:3088 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S135270AbRDLTat>; Thu, 12 Apr 2001 15:30:49 -0400
Date: Thu, 12 Apr 2001 12:30:13 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: "Stephen C. Tweedie" <sct@redhat.com>, Alexander Viro <viro@math.psu.edu>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: generic_osync_inode() broken?
In-Reply-To: <Pine.LNX.4.21.0104121412150.2892-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.31.0104121228550.20191-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 12 Apr 2001, Marcelo Tosatti wrote:
>
> Comments?
>
> --- fs/inode.c~	Thu Mar 22 16:04:13 2001
> +++ fs/inode.c	Thu Apr 12 15:18:22 2001
> @@ -347,6 +347,11 @@
>  #endif
>
>  	spin_lock(&inode_lock);
> +	while (inode->i_state & I_LOCK) {
> +		spin_unlock(&inode_lock);
> +		__wait_on_inode(inode);
> +		spin_lock(&inode_lock);
> +	}
>  	if (!(inode->i_state & I_DIRTY))
>  		goto out;
>  	if (datasync && !(inode->i_state & I_DIRTY_DATASYNC))

Ehh.

Why not just lock the inode around the thing?

The above looks rather ugly.

		Linus


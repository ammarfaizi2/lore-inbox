Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290760AbSAYSZm>; Fri, 25 Jan 2002 13:25:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290762AbSAYSZc>; Fri, 25 Jan 2002 13:25:32 -0500
Received: from smtp-out-6.wanadoo.fr ([193.252.19.25]:2290 "EHLO
	mel-rto6.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S290760AbSAYSZY>; Fri, 25 Jan 2002 13:25:24 -0500
Content-Type: text/plain; charset=US-ASCII
From: Duncan Sands <duncan.sands@math.u-psud.fr>
To: Mikael Pettersson <mikpe@csd.uu.se>
Subject: Re: filesystem corruption with 2.5.2-dj5
Date: Fri, 25 Jan 2002 19:25:00 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <E16U2Og-0000qu-00@baldrick> <15441.21347.214934.178562@harpo.it.uu.se>
In-Reply-To: <15441.21347.214934.178562@harpo.it.uu.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16UB25-0000L5-00@baldrick>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 25 January 2002 1:45 pm, Mikael Pettersson wrote:
> Duncan Sands writes:
>  > I just gave 2.5.2-dj5 a try.  On a subsequent reboot and fsck
>  > (with a stable kernel), I got a slew of messages about bad inode
>  > fsizes on files modified while using 2.5.2-dj5.  The partition uses
>  > ext2.  This is a UP i386 (AMD K6) machine with no other patches.
>  > What can I do to help track this down?
>
> I reported this a couple of hours ago for 2.5.3-pre and Al Viro posted
> this patch:
>
> --- C3-pre4/fs/ext2/ialloc.c	Wed Jan 23 20:45:32 2002
> +++ /tmp/ialloc.c	Thu Jan 24 21:41:52 2002
> @@ -392,6 +392,7 @@
>  		ei->i_flags &= ~(EXT2_IMMUTABLE_FL|EXT2_APPEND_FL);
>  	ei->i_faddr = 0;
>  	ei->i_frag_no = 0;
> +	ei->i_frag_size = 0;
>  	ei->i_osync = 0;
>  	ei->i_file_acl = 0;
>  	ei->i_dir_acl = 0;
> --- C3-pre4/fs/ext2/inode.c	Wed Jan 23 20:45:32 2002
> +++ /tmp/inode.c	Thu Jan 24 21:44:48 2002
> @@ -963,6 +963,7 @@
>  	ei->i_frag_size = raw_inode->i_fsize;
>  	ei->i_osync = 0;
>  	ei->i_file_acl = le32_to_cpu(raw_inode->i_file_acl);
> +	ei->i_dir_acl = 0;
>  	if (S_ISREG(inode->i_mode))
>  		inode->i_size |= ((__u64)le32_to_cpu(raw_inode->i_size_high)) << 32;
>  	else

Yes, that was the problem.  Thanks for the info, I hadn't spotted the patch.

Duncan.

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132261AbRAGNxt>; Sun, 7 Jan 2001 08:53:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132272AbRAGNxj>; Sun, 7 Jan 2001 08:53:39 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:47118 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132261AbRAGNxZ>; Sun, 7 Jan 2001 08:53:25 -0500
Subject: Re: ftruncate returning EPERM on vfat filesystem
To: djdave@bigpond.net.au (Dave)
Date: Sun, 7 Jan 2001 13:55:15 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0101071613130.1132-100000@athlon.internal> from "Dave" at Jan 07, 2001 04:47:01 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14FGI2-0002fo-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +
> +       /* FAT cannot truncate to a longer file */
> +       if (attr->ia_valid & ATTR_SIZE) {
> +               if (attr->ia_size > inode->i_size)
> +                       return -EPERM;
> +       }
> 
>         error = inode_change_ok(inode, attr);
>         if (error)
> 
> Can someone tell me if this is the cause of my samba problems, and if
> so, why this was added and if this is safe to revert?

To stop a case where the fs gets corrupted otherwise. You can change that to
return 0 which is more correct but most not remove it.

(ftruncate is specified to make the file at most length bytes long, extending
the file is not a guaranteed side effect according to the docs I have)



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

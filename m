Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264251AbTIJCkP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 22:40:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264481AbTIJCkP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 22:40:15 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:17541 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264251AbTIJCkM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 22:40:12 -0400
Date: Wed, 10 Sep 2003 03:40:10 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Stephen Hemminger <shemminger@osdl.org>
Cc: jffs-dev@axis.com, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] fix type mismatch in jffs.
Message-ID: <20030910024010.GN454@parcelfarce.linux.theplanet.co.uk>
References: <20030909144420.120d4add.shemminger@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030909144420.120d4add.shemminger@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 09, 2003 at 02:44:20PM -0700, Stephen Hemminger wrote:
> On 2.6.0-test5 jffs generates a warning about type mismatch because it casting a short
> to a pointer.  Look like an obvious typo.

Which it is.  Thanks for spotting.  Linux, please apply.
 
> Builds clean, not tested on real hardware.
> 
> diff -Nru a/fs/jffs/inode-v23.c b/fs/jffs/inode-v23.c
> --- a/fs/jffs/inode-v23.c	Tue Sep  9 14:41:53 2003
> +++ b/fs/jffs/inode-v23.c	Tue Sep  9 14:41:53 2003
> @@ -1734,7 +1734,7 @@
>  		   the device should be read from the flash memory and then
>  		   added to the inode's i_rdev member.  */
>  		u16 val;
> -		jffs_read_data(f, (char *)val, 0, 2);
> +		jffs_read_data(f, (char *)&val, 0, 2);
>  		init_special_inode(inode, inode->i_mode,
>  			old_decode_dev(val));
>  	}



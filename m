Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261250AbVARKzc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261250AbVARKzc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 05:55:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261251AbVARKzc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 05:55:32 -0500
Received: from [213.146.154.40] ([213.146.154.40]:19180 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261250AbVARKz1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 05:55:27 -0500
Date: Tue, 18 Jan 2005 10:55:22 +0000
From: Christoph Hellwig <hch@infradead.org>
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Cc: Andi Kleen <ak@muc.de>, akpm@osdl.org, hch@infradead.org,
       linux-kernel@vger.kernel.org, chrisw@osdl.org, davem@davemloft.net
Subject: Re: [PATCH 2/5] socket ioctl fix (from Andi)
Message-ID: <20050118105522.GA25875@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Michael S. Tsirkin" <mst@mellanox.co.il>, Andi Kleen <ak@muc.de>,
	akpm@osdl.org, linux-kernel@vger.kernel.org, chrisw@osdl.org,
	davem@davemloft.net
References: <20050118072133.GB76018@muc.de> <20050118104816.GB23127@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050118104816.GB23127@mellanox.co.il>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 18, 2005 at 12:48:16PM +0200, Michael S. Tsirkin wrote:
> Attached patch is against 2.6.11-rc1-bk5.
> It is split out from Andi's big patch.
> It is really unchanged so I dont put a signed-off-by here.
> 
> Signed-off-by: Andi Kleen <ak@muc.de>
> 
> SIOCDEVPRIVATE ioctl command only applies to socket descriptors.
> 
> diff -rup linux-2.6.10-orig/fs/compat.c linux-2.6.10-ioctl-sym/fs/compat.c
> --- linux-2.6.10-orig/fs/compat.c	2005-01-18 10:58:33.609880024 +0200
> +++ linux-2.6.10-ioctl-sym/fs/compat.c	2005-01-18 10:54:26.289478440 +0200
> @@ -454,7 +460,8 @@ asmlinkage long compat_sys_ioctl(unsigne
>  	}
>  	up_read(&ioctl32_sem);
>  
> -	if (cmd >= SIOCDEVPRIVATE && cmd <= (SIOCDEVPRIVATE + 15)) {
> +	if (S_ISSOCK(filp->f_dentry->d_inode->i_mode) &&
> +	    cmd >= SIOCDEVPRIVATE && cmd <= (SIOCDEVPRIVATE + 15)) {
>  		error = siocdevprivate_ioctl(fd, cmd, arg);

Maybe this should move into a new sock_compat_ioctl() instead?


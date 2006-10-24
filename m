Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030301AbWJXOB2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030301AbWJXOB2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 10:01:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965159AbWJXOB2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 10:01:28 -0400
Received: from frankvm.xs4all.nl ([80.126.170.174]:40161 "EHLO
	janus.localdomain") by vger.kernel.org with ESMTP id S965158AbWJXOB0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 10:01:26 -0400
Date: Tue, 24 Oct 2006 16:01:25 +0200
From: Frank van Maarseveen <frankvm@frankvm.com>
To: Thomas Zeitlhofer <tzeitlho+lkml@nt.tuwien.ac.at>
Cc: linux-kernel@vger.kernel.org
Subject: automount nfs: mkdir_path /net/host/dir failed: Read-only file system
Message-ID: <20061024140125.GA12781@janus>
References: <20061023092329.GA5231@swan.nt.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061023092329.GA5231@swan.nt.tuwien.ac.at>
User-Agent: Mutt/1.4.1i
X-BotBait: val@frankvm.com, kuil@frankvm.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2006 at 11:23:29AM +0200, Thomas Zeitlhofer wrote:
> 
> there is a problem in 2.6.18/.1 when mkdir is called for an existing
> directory on a read-only mounted NFS filesystem.
[...]
> As a consequence of 1), autofs does not work with mountpoints on NFS

I'm hitting this regression too

> So please consider this patch for the next -stable release:
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index 432d6bc..5201d77 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -1774,8 +1774,6 @@ struct dentry *lookup_create(struct name
>  	if (nd->last_type != LAST_NORM)
>  		goto fail;
>  	nd->flags &= ~LOOKUP_PARENT;
> -	nd->flags |= LOOKUP_CREATE;
> -	nd->intent.open.flags = O_EXCL;
>  
>  	/*
>  	 * Do the final lookup.

yep, fixes it for me. Thankx.

-- 
Frank

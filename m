Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261853AbVCYWfP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261853AbVCYWfP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 17:35:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261872AbVCYWdC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 17:33:02 -0500
Received: from alog0005.analogic.com ([208.224.220.20]:3746 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261862AbVCYWaZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 17:30:25 -0500
Date: Fri, 25 Mar 2005 17:29:56 -0500 (EST)
From: linux-os <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Jesper Juhl <juhl-lkml@dif.dk>
cc: ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] no need to check for NULL before calling kfree() -
 fs/ext2/
In-Reply-To: <Pine.LNX.4.62.0503252307010.2498@dragon.hyggekrogen.localhost>
Message-ID: <Pine.LNX.4.61.0503251726010.6354@chaos.analogic.com>
References: <Pine.LNX.4.62.0503252307010.2498@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Isn't it expensive of CPU time to call kfree() even though the
pointer may have already been freed? I suggest that the check
for a NULL before the call is much less expensive than calling
kfree() and doing the check there. The resulting "double check"
is cheap, compared to the call.

On Fri, 25 Mar 2005, Jesper Juhl wrote:

> (please keep me on CC)
>
>
> kfree() handles NULL fine, to check is redundant.
>
> Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
>
> --- linux-2.6.12-rc1-mm3-orig/fs/ext2/acl.c	2005-03-02 08:38:18.000000000 +0100
> +++ linux-2.6.12-rc1-mm3/fs/ext2/acl.c	2005-03-25 22:41:07.000000000 +0100
> @@ -194,8 +194,7 @@ ext2_get_acl(struct inode *inode, int ty
> 		acl = NULL;
> 	else
> 		acl = ERR_PTR(retval);
> -	if (value)
> -		kfree(value);
> +	kfree(value);
>
> 	if (!IS_ERR(acl)) {
> 		switch(type) {
> @@ -262,8 +261,7 @@ ext2_set_acl(struct inode *inode, int ty
>
> 	error = ext2_xattr_set(inode, name_index, "", value, size, 0);
>
> -	if (value)
> -		kfree(value);
> +	kfree(value);
> 	if (!error) {
> 		switch(type) {
> 			case ACL_TYPE_ACCESS:
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.11 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.

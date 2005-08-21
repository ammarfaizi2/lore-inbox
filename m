Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750883AbVHUJGB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750883AbVHUJGB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Aug 2005 05:06:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750886AbVHUJGB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Aug 2005 05:06:01 -0400
Received: from wproxy.gmail.com ([64.233.184.205]:12612 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750878AbVHUJGA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Aug 2005 05:06:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=k7qxPwIWuZXEUqRvCeBTTy2ZpshZYfXPldhmko39yJcsTam3P8KzQ5Yfzwx4AM6yWcBe3d4QEx+BDqWOSfEyAi8P8W6JKLHkDzmi1s1+JweoEZ4plvTnHr/fIqD/B0UABPBNZhk9dQ9NNKt96EYEg+oE6MQSPANQNRZgCGToVOY=
Date: Sun, 21 Aug 2005 13:14:01 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: linux-kernel@vger.kernel.org, jffs-dev@axis.com
Subject: Re: use of uninitialized pointer in jffs_create()
Message-ID: <20050821091401.GA23626@mipter.zuzino.mipt.ru>
References: <9a87484905082015284c1686ec@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a87484905082015284c1686ec@mail.gmail.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 21, 2005 at 12:28:08AM +0200, Jesper Juhl wrote:
> gcc kindly pointed me at jffs_create() with this warning : 
> 
> fs/jffs/inode-v23.c:1279: warning: `inode' might be used uninitialized
> in this function

I don't see a warning with latest gcc-4.1 snapshot.

> And looking at the function :
> 
> static int
> jffs_create(struct inode *dir, struct dentry *dentry, int mode,
>                 struct nameidata *nd)
> {
>         struct jffs_raw_inode raw_inode;
>         struct jffs_control *c;
>         struct jffs_node *node;
>         struct jffs_file *dir_f; /* JFFS representation of the directory.  */
>         struct inode *inode;
>         int err;
> 
>         truncate_inode_pages(&inode->i_data, 0);

$ grep truncate_inode_pages -r fs/jffs/
$
	?

> I think it is correct. How on earth is that call to
> truncate_inode_pages() going to avoid blowing up? inode has not yet
> been initialized...


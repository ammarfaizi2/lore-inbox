Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262039AbVBJHwx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262039AbVBJHwx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 02:52:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262040AbVBJHwx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 02:52:53 -0500
Received: from wproxy.gmail.com ([64.233.184.200]:41093 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262039AbVBJHwv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 02:52:51 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=NmdncoTABzOTe2AbbbLOs3TPDZXX1ZKaL9+6xZ6Ck2J37v68Vh+6Y20ggoTFO/aJSGQryaMCR4diKieUI95j020ZvwB3L7e3NBTvs9GlwD5FTq8vno1Pd+FV5fiZhuNFVk3TCSQVz2wIoeGj1UutZxQVCPUh+5W1O+Q4zxc3dZ4=
Message-ID: <84144f020502092352682a732f@mail.gmail.com>
Date: Thu, 10 Feb 2005 09:52:50 +0200
From: Pekka Enberg <penberg@gmail.com>
Reply-To: Pekka Enberg <penberg@gmail.com>
To: Tom Zanussi <zanussi@us.ibm.com>
Subject: Re: [PATCH] relayfs redux, part 4
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>,
       Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>,
       Roman Zippel <zippel@linux-m68k.org>,
       Robert Wisniewski <bob@watson.ibm.com>, Tim Bird <tim.bird@am.sony.com>,
       Christoph Hellwig <hch@infradead.org>, karim@opersys.com,
       penberg@cs.helsinki.fi
In-Reply-To: <16906.52160.870346.806462@tut.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <16906.52160.870346.806462@tut.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Feb 2005 20:49:36 -0600, Tom Zanussi <zanussi@us.ibm.com> wrote:
> +static int relayfs_create_entry(const char *name, struct dentry *parent,
> +                               int mode, struct rchan *chan,
> +                               struct dentry **dentry)
> +{
> +       struct qstr qname;
> +       struct dentry *d;
> +       struct inode *inode;
> +       int error = 0;
> +
> +       BUG_ON(!(S_ISREG(mode) || S_ISDIR(mode)));
> +
> +       error = simple_pin_fs("relayfs", &relayfs_mount, &relayfs_mount_count);
> +       if (error) {
> +               printk(KERN_ERR "Couldn't mount relayfs: errcode %d\n", error);
> +               return error;
> +       }
> +
> +       qname.name = name;
> +       qname.len = strlen(name);
> +       qname.hash = full_name_hash(name, qname.len);
> +
> +       if (!parent)
> +               if (relayfs_mount && relayfs_mount->mnt_sb)
> +                       parent = relayfs_mount->mnt_sb->s_root;

Please move the nested if statement to the parent expression. The
!parent part is always evaluated first.

> +static struct inode *relayfs_alloc_inode(struct super_block *sb)
> +{
> +       struct relayfs_inode_info *p;
> +       p = (struct relayfs_inode_info *)kmem_cache_alloc(relayfs_inode_cachep,
> +                                                         SLAB_KERNEL);

Please drop the spurious cast from void *.

                         Pekka

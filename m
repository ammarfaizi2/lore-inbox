Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030506AbWF1OQk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030506AbWF1OQk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 10:16:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030510AbWF1OQj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 10:16:39 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:32286 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030501AbWF1OQh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 10:16:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=S41h0l19oXZPQt1Jx8YcMIKPTI2kjXC3DnNSImoYUXoSXPI4pPLflSs7bdL5RU9Cg0Ov3L1UxtE3kU1F5nWl8Te1+CtxiWr+vDMn6CsWXsH2jyfoBJVqpCZjfBXJyR0llhRkPdBGkCsflL52h5Am0Y960AO4CRjBdRPXR5dwtVI=
Message-ID: <84144f020606280716y2bea236du2ea84018e15a7d0a@mail.gmail.com>
Date: Wed, 28 Jun 2006 17:16:34 +0300
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Phillip Hellewell" <phillip@hellewell.homeip.net>
Subject: Re: [PATCH 10/13: eCryptfs] Mmap operations
Cc: "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, viro@ftp.linux.org.uk, mike@halcrow.us,
       mhalcrow@us.ibm.com, mcthomps@us.ibm.com, toml@us.ibm.com,
       yoder1@us.ibm.com, "James Morris" <jmorris@namei.org>,
       "Stephen C. Tweedie" <sct@redhat.com>, "Erez Zadok" <ezk@cs.sunysb.edu>,
       "David Howells" <dhowells@redhat.com>
In-Reply-To: <20060513034708.GJ18631@hellewell.homeip.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060513033742.GA18598@hellewell.homeip.net>
	 <20060513034708.GJ18631@hellewell.homeip.net>
X-Google-Sender-Auth: b3917a541bae06c6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Sorry for the late comment...

On 5/13/06, Phillip Hellewell <phillip@hellewell.homeip.net> wrote:
> +static struct page *ecryptfs_get1page(struct file *file, int index)
> +{
> +       struct page *page;
> +       struct dentry *dentry;
> +       struct inode *inode;
> +       struct address_space *mapping;
> +
> +       dentry = file->f_dentry;
> +       inode = dentry->d_inode;
> +       mapping = inode->i_mapping;
> +       page = read_cache_page(mapping, index,
> +                              (filler_t *)mapping->a_ops->readpage,
> +                              (void *)file);
> +       if (IS_ERR(page))
> +               goto out;
> +       wait_on_page_locked(page);

Why no check for PageUptodate?

> +out:
> +       return page;
> +}

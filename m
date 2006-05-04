Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751473AbWEDOv1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751473AbWEDOv1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 10:51:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751492AbWEDOv0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 10:51:26 -0400
Received: from wr-out-0506.google.com ([64.233.184.229]:609 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751491AbWEDOvZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 10:51:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=DfjrfLJqg2B1VCUUjA3L/fkW7gUaE3AteuV+UAn5MwcTyJgsOs+OtKH5i1jOm2EKqwMGS0av/Dp0c2gsoloT9Jq92ReoGmgdhabDpPYeLkJ16IrwXqZZfref7a3uQq+2NdmLPpQC90tPw3i/Is9pvGm4cRT1Ffy8Ows1+VPpjZM=
Message-ID: <84144f020605040751t2d2dca5ai4044f28d7118ee96@mail.gmail.com>
Date: Thu, 4 May 2006 17:51:25 +0300
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Phillip Hellewell" <phillip@hellewell.homeip.net>
Subject: Re: [PATCH 5/13: eCryptfs] Header declarations
Cc: "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, viro@ftp.linux.org.uk, mike@halcrow.us,
       mhalcrow@us.ibm.com, mcthomps@us.ibm.com, toml@us.ibm.com,
       yoder1@us.ibm.com, "James Morris" <jmorris@namei.org>,
       "Stephen C. Tweedie" <sct@redhat.com>, "Erez Zadok" <ezk@cs.sunysb.edu>,
       "David Howells" <dhowells@redhat.com>
In-Reply-To: <20060504033750.GD28613@hellewell.homeip.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060504031755.GA28257@hellewell.homeip.net>
	 <20060504033750.GD28613@hellewell.homeip.net>
X-Google-Sender-Auth: 039a574543faca7b
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/4/06, Phillip Hellewell <phillip@hellewell.homeip.net> wrote:
> +#ifdef OBSERVE_ASSERTS
> +#define ASSERT(EX)                                                           \
> +do {                                                                         \
> +        if (unlikely(!(EX))) {                                                \
> +               printk(KERN_CRIT "ASSERTION FAILED: %s at %s:%d (%s)\n", #EX, \
> +                      __FILE__, __LINE__, __FUNCTION__);                     \
> +                BUG();                                                        \
> +        }                                                                    \
> +} while (0)
> +#else
> +#define ASSERT(EX) ;
> +#endif /* OBSERVE_ASSERTS */

So, what's wrong with BUG_ON?

> +
> +#define ECRYPTFS_FILE_TO_PRIVATE(file) ((struct ecryptfs_file_info *) \
> +                                        ((file)->private_data))
> +#define ECRYPTFS_FILE_TO_PRIVATE_SM(file) ((file)->private_data)
> +#define ECRYPTFS_FILE_TO_LOWER(file) \
> +        ((ECRYPTFS_FILE_TO_PRIVATE(file))->wfi_file)
> +#define ECRYPTFS_INODE_TO_PRIVATE(ino) ((struct ecryptfs_inode_info *) \
> +                                        (ino)->u.generic_ip)
> +#define ECRYPTFS_INODE_TO_PRIVATE_SM(ino) ((ino)->u.generic_ip)
> +#define ECRYPTFS_INODE_TO_LOWER(ino) (ECRYPTFS_INODE_TO_PRIVATE(ino)->wii_inode)
> +#define ECRYPTFS_SUPERBLOCK_TO_PRIVATE(super) ((struct ecryptfs_sb_info *) \
> +                                               (super)->s_fs_info)
> +#define ECRYPTFS_SUPERBLOCK_TO_PRIVATE_SM(super) ((super)->s_fs_info)
> +#define ECRYPTFS_SUPERBLOCK_TO_LOWER(super) \
> +        (ECRYPTFS_SUPERBLOCK_TO_PRIVATE(super)->wsi_sb)
> +#define ECRYPTFS_DENTRY_TO_PRIVATE_SM(dentry) ((dentry)->d_fsdata)
> +#define ECRYPTFS_DENTRY_TO_PRIVATE(dentry) ((struct ecryptfs_dentry_info *) \
> +                                            (dentry)->d_fsdata)
> +#define ECRYPTFS_DENTRY_TO_LOWER(dentry) \
> +        (ECRYPTFS_DENTRY_TO_PRIVATE(dentry)->wdi_dentry)

Static inline functions, please.

> +
> +#define ecryptfs_printk(type, fmt, arg...) \
> +        __ecryptfs_printk(type "%s: " fmt, __FUNCTION__, ## arg);
> +void __ecryptfs_printk(const char *fmt, ...);

Why not plain printk?

> +extern kmem_cache_t *ecryptfs_auth_tok_list_item_cache;
> +extern kmem_cache_t *ecryptfs_file_info_cache;
> +extern kmem_cache_t *ecryptfs_dentry_info_cache;
> +extern kmem_cache_t *ecryptfs_inode_info_cache;
> +extern kmem_cache_t *ecryptfs_sb_info_cache;
> +extern kmem_cache_t *ecryptfs_header_cache_0;
> +extern kmem_cache_t *ecryptfs_header_cache_1;
> +extern kmem_cache_t *ecryptfs_header_cache_2;
> +extern kmem_cache_t *ecryptfs_lower_page_cache;

Please use struct kmem_cache instead.

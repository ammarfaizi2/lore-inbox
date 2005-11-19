Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751035AbVKSKhh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751035AbVKSKhh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 05:37:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751022AbVKSKhg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 05:37:36 -0500
Received: from nproxy.gmail.com ([64.233.182.204]:64309 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751020AbVKSKhe convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 05:37:34 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lOyQvu8uGDoCZ+EcGPVPYdMhbY/Bfe41j7quoO+VgX1Kmz0uLrxvLcqR//jT2smYIDfc+WnvfGDFPIIY+T5FJnlj3QDjILxsdK4PK+iBLsFkNV4ar/nDTRBu9yi61rL+eGIvF3qaMrwsLH4eQsK2KkYGSk4Bsp5o+6MnGRj9Oyk=
Message-ID: <84144f020511190237w8b5404em461bb2eaf5fa8ea6@mail.gmail.com>
Date: Sat, 19 Nov 2005 12:37:33 +0200
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Phillip Hellewell <phillip@hellewell.homeip.net>
Subject: Re: [PATCH 5/12: eCryptfs] Header declarations
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       viro@ftp.linux.org.uk, mike@halcrow.us, mhalcrow@us.ibm.com,
       mcthomps@us.ibm.com, yoder1@us.ibm.com
In-Reply-To: <20051119041837.GE15747@sshock.rn.byu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051119041130.GA15559@sshock.rn.byu.edu>
	 <20051119041837.GE15747@sshock.rn.byu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Phillip,

On 11/19/05, Phillip Hellewell <phillip@hellewell.homeip.net> wrote:
> +struct ecryptfs_session_key {
> +#define ECRYPTFS_USERSPACE_SHOULD_TRY_TO_DECRYPT 0x01
> +#define ECRYPTFS_USERSPACE_SHOULD_TRY_TO_ENCRYPT 0x02
> +#define ECRYPTFS_CONTAINS_DECRYPTED_KEY 0x04
> +#define ECRYPTFS_CONTAINS_ENCRYPTED_KEY 0x08
> +       int32_t flags;
> +       int32_t encrypted_key_size;
> +       int32_t decrypted_key_size;
> +       uint8_t decrypted_key[ECRYPTFS_MAX_KEY_BYTES];
> +       uint8_t encrypted_key[ECRYPTFS_MAX_ENCRYPTED_KEY_BYTES];

s32 and u8 are preferred in the kernel.

> +#define OBSERVE_ASSERTS 1
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
> +#endif                         /* OBSERVE_ASSERTS */

Any reason why you can't just use BUG and BUG_ON()?

> +
> +/**
> + * Halcrow: What does the kernel VFS do to ensure that there is no
> + * contention for file->private_data?
> + */

Please elaborate?

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

These wrappers seem rather pointless and obfuscating...

> +int virt_to_scatterlist(const void *addr, int size, struct scatterlist *sg,
> +                       int sg_size);

Doesn't seem ecryptfs specific, why is it here?

                                          Pekka

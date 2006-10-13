Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750739AbWJMIXy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750739AbWJMIXy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 04:23:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750778AbWJMIXy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 04:23:54 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:21044 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750739AbWJMIXx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 04:23:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=VheHQVFp34337/bMTUSBD8JcQzx8iOm9b+qfhR5fW1/AF2MCC7jJ6SfvkhcosnlP1h93kaRmtFAMLrq7Rqe1OOAHtcjh5bUL8ondU2+rUwfbqk9L43gB7PwK2Td3wpyQ1yZy4cR/y5l8XKvPs6uELc8MlD3pNWLSiaMwjnK0PUQ=
Message-ID: <84144f020610130123u1f7b9d2cve36c0242a6bc037@mail.gmail.com>
Date: Fri, 13 Oct 2006 11:23:51 +0300
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Josef Jeff Sipek" <jsipek@cs.sunysb.edu>
Subject: Re: [PATCH 19 of 23] Unionfs: Helper macros/inlines
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       torvalds@osdl.org, akpm@osdl.org, hch@infradead.org,
       viro@ftp.linux.org.uk
In-Reply-To: <d7b005418bfc9911ed07.1160197658@thor.fsl.cs.sunysb.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <patchbomb.1160197639@thor.fsl.cs.sunysb.edu>
	 <d7b005418bfc9911ed07.1160197658@thor.fsl.cs.sunysb.edu>
X-Google-Sender-Auth: 1df3d0fbc806702e
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Josef,

The names of some of these macros are somewhat unreadable.

On 10/7/06, Josef Jeff Sipek <jsipek@cs.sunysb.edu> wrote:
> +/* Inode to private data */
> +static inline struct unionfs_inode_info *itopd(const struct inode *inode)
> +{
> +       return
> +           &(container_of(inode, struct unionfs_inode_container, vfs_inode)->
> +             info);
> +}

Rename to unionfs_inode?

> +#define itohi_ptr(ino) (itopd(ino)->uii_inode)

unionfs_hidden_inodes ?

> +#define ibstart(ino) (itopd(ino)->b_start)

unionfs_inode_branch_start ?

> +#define ibend(ino) (itopd(ino)->b_end)

unionfs_inode_branch_end ?

> +#define stopd(super) ((struct unionfs_sb_info *)(super)->s_fs_info)

unionfs_sb_info ?

> +#define stopd_lhs(super) ((super)->s_fs_info)

This you should drop.

> +#define sbstart(sb) 0

unionfs_sb_branch_start?

> +#define sbend(sb) stopd(sb)->b_end

unionfs_sb_branch_end?

> +#define sbmax(sb) (stopd(sb)->b_end + 1)

unionfs_sb_branch_max?

> +#define ftopd(file) ((struct unionfs_file_info *)((file)->private_data))

unionfs_file_info ?

> +#define ftopd_lhs(file) ((file)->private_data)

This you should drop.

> +#define ftohf_ptr(file)  (ftopd(file)->ufi_file)

unionfs_hidden_files ?

> +#define fbstart(file) (ftopd(file)->b_start)

unionfs_file_branch_start ?

> +#define fbend(file) (ftopd(file)->b_end)

unionfs_file_branch_end ?

> +
> +/* File to hidden file. */
> +static inline struct file *ftohf(struct file *f)
> +{
> +       return ftopd(f)->ufi_file[fbstart(f)];
> +}

unionfs_hidden_file ?

> +
> +static inline struct file *ftohf_index(const struct file *f, int index)
> +{
> +       return ftopd(f)->ufi_file[index];
> +}

__unionfs_hidden_file (and make the above use this too)?

> +
> +static inline void set_ftohf_index(struct file *f, int index, struct file *val)
> +{
> +       ftopd(f)->ufi_file[index] = val;
> +}

__unionfs_set_hidden_file ?

> +
> +static inline void set_ftohf(struct file *f, struct file *val)
> +{
> +       ftopd(f)->ufi_file[fbstart(f)] = val;
> +}

unionfs_set_hidden_file ?

[Same comments apply for the rest.]

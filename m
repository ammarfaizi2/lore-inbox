Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261700AbVBDMnK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261700AbVBDMnK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 07:43:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261687AbVBDMnJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 07:43:09 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:31495 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S261179AbVBDMmy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 07:42:54 -0500
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Updated FAT attributes patch
References: <4202741F.9040102@zytor.com>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Fri, 04 Feb 2005 21:42:41 +0900
In-Reply-To: <4202741F.9040102@zytor.com> (H. Peter Anvin's message of "Thu,
 03 Feb 2005 10:57:35 -0800")
Message-ID: <87hdkswl6m.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" <hpa@zytor.com> writes:

> This updates the FAT attributes as well as (hopefully) corrects the
> handling of VFAT ctime.  The FAT attributes are implemented as a
> 32-bit ioctl, per the previous discussions.

[...]

> +		/* This MUST be done before doing anything irreversible... */
> +		if ( (err = notify_change(filp->f_dentry, &ia)) )
> +			goto up;
> +		
> +		if (sbi->options.sys_immutable) {
> +			if ( attr & ATTR_SYS )
> +				inode->i_flags |= S_IMMUTABLE;
> +			else
> +				inode->i_flags &= S_IMMUTABLE;
> +		}
> +
> +		MSDOS_I(inode)->i_attrs = attr & ATTR_UNUSED;

Looks good to me. However, we would need to add the mark_inode_ditry()
after seting iattr. Because another write_inode() path can clear the
dirty flag before setting ->i_attr.

I'll apply the patch and add it.

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

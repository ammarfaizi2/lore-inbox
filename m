Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261386AbVCGBMK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261386AbVCGBMK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 20:12:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261616AbVCGBMK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 20:12:10 -0500
Received: from fire.osdl.org ([65.172.181.4]:48093 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261386AbVCGBKw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 20:10:52 -0500
Date: Sun, 6 Mar 2005 17:10:51 -0800
From: Andrew Morton <akpm@osdl.org>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] FAT: Support synchronous update
Message-Id: <20050306171051.06c7f00c.akpm@osdl.org>
In-Reply-To: <87ll92rl6a.fsf@devron.myhome.or.jp>
References: <87ll92rl6a.fsf@devron.myhome.or.jp>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> wrote:
>
> Hi,
> 
> These patches adds the `-o sync' and `-o dirsync' supports to fatfs.
> If user specified that option, the fatfs does traditional ordered
> updates by using synchronous writes.  If compared to before, these
> patches will show a improvement of robustness I think.
> 
> `-o sync'    - writes all buffers out before returning from syscall.
> `-o dirsync' - writes the directory's metadata, and unreferencing
>                operations of data block.
> 
>     remaining to be done
>          fat_generic_ioctl(), fat_notify_change(),
> 	 ATTR_ARCH of fat_xxx_write[v],
> 	 and probably, filling hole in cont_prepare_write(),
> 
> NOTE: Since fatfs doesn't have link-count, unfortunately ->rename() is
> not safe order at all.  It may make the shared blocks, but user
> shouldn't lose the data by ->rename().
> 
> Please apply.
> 
> 
> If you test this, please use attached dosfstools. This is fixing
> several bugs of dosfstools.  And "2/29" patch from hpa adds new ioctl,
> the attached archive is also including the commands for testing it.
> -- 
> OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
> 
> 

OK.  This email was way too big for linux-kernel, so nobody saw it.

I put the modified fatfsprogs at
http://www.zip.com.au/~akpm/linux/patches/stuff/fatfsprogs.tar.bz2 and
updated the changlog to mention that.

Is there an official place where people should go to download the modified
fatfsprogs?


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265997AbUFDU4v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265997AbUFDU4v (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 16:56:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266004AbUFDUya
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 16:54:30 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:19855 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265999AbUFDUxo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 16:53:44 -0400
Date: Fri, 4 Jun 2004 21:53:41 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: mike.miller@hp.com
Cc: akpm@osdl.org, axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: cciss update for 2.6.7-rc1
Message-ID: <20040604205341.GP12308@parcelfarce.linux.theplanet.co.uk>
References: <20040602201326.GA1346@beardog.cca.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040602201326.GA1346@beardog.cca.cpqcorp.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 02, 2004 at 03:13:26PM -0500, mikem@beardog.cca.cpqcorp.net wrote:

a) use compat_alloc_user_space() and copy_in_user()

> +	err |= copy_from_user(&arg64.LUN_info, &arg32->LUN_info, sizeof(arg64.LUN_info));
> +	err |= copy_from_user(&arg64.Request, &arg32->Request, sizeof(arg64.Request));
> +	err |= copy_from_user(&arg64.error_info, &arg32->error_info, sizeof(arg64.error_info));
> +	err |= get_user(arg64.buf_size, &arg32->buf_size);

b) use compat_ptr() to convert pointers

> +	err |= get_user(arg64.buf, &arg32->buf);


c) and do not bother with get_fs()/set_fs() at all - with
compat_alloc_user_space() variant you won't need it.

> +	old_fs = get_fs();
> +	set_fs(KERNEL_DS);
> +	err = sys_ioctl(fd, CCISS_PASSTHRU, (unsigned long) &arg64);
> +	set_fs(old_fs);

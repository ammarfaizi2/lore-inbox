Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265463AbUGDSmJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265463AbUGDSmJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jul 2004 14:42:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265467AbUGDSmJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jul 2004 14:42:09 -0400
Received: from holomorphy.com ([207.189.100.168]:6347 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265463AbUGDSmH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jul 2004 14:42:07 -0400
Date: Sun, 4 Jul 2004 11:42:03 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, akpm@osdl.org,
       hugh@veritas.com
Subject: Re: move O_LARGEFILE forcing to filp_open()
Message-ID: <20040704184203.GM21066@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
	akpm@osdl.org, hugh@veritas.com
References: <20040704064122.GY21066@holomorphy.com> <20040704172750.GJ21066@holomorphy.com> <20040704173805.GK21066@holomorphy.com> <200407041949.01126.arnd@arndb.de> <20040704175202.GL21066@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040704175202.GL21066@holomorphy.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 04, 2004 at 07:49:00PM +0200, Arnd Bergmann wrote:
>> At first sight, it looks like (filp->f_flags & O_LARGEFILE) will always
>> be true after calling filp_open, but I don't have time to look closer
>> today.

On Sun, Jul 04, 2004 at 10:52:02AM -0700, William Lee Irwin III wrote:
> Quite right.
[...]
> +			if (!(flags & O_LARGEFILE) &&
> +				i_size_read(f->f_dentry->d_inode) > MAX_NON_LFS) {
> +				error = -EFBIG;
> +				filp_close(f, current->files);
> +				goto out_error;
> +			}

With my stuff, the compat_sys_open() patch, and the compat_sys_open()
MAX_NON_LFS patch in place, things pass quick manual backward
compatibility testing (basically, one small app that does open() of a
large file sees the right results with and without O_LARGEFILE where it
didn't before).

-- wli

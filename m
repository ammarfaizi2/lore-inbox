Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262254AbTHBMRO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 08:17:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262321AbTHBMRO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 08:17:14 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:60427 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S262254AbTHBMRL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 08:17:11 -0400
Date: Sat, 2 Aug 2003 14:17:09 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Erik McKee <camhanaich99@yahoo.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: minixfs question
Message-ID: <20030802121709.GA3689@win.tue.nl>
References: <20030802094854.19141.qmail@web14202.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030802094854.19141.qmail@web14202.mail.yahoo.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 02, 2003 at 02:48:54AM -0700, Erik McKee wrote:

> hoping this fs is a good place to start learning about fs in linux

Since it is small, and was the first, it has been a template
for many other filesystems. On the other hand, today it is a fossil,
not used very much, and its code is no longer exemplary.

You ask about minix_find_first_zero_bit and whether there aren't generic fns.
There are, but the details differ a bit. The original version was
little-endian. On other architectures one must choose between
little-endian and native endian. The choice can be read off in asm*/bitops.h.

> 224         bh = NULL;
> 225         *error = -ENOSPC;
> 226         lock_kernel();
> 227         for (i = 0; i < sbi->s_imap_blocks; i++) {
> 228                 bh = sbi->s_imap[i];
> 229                 if ((j = minix_find_first_zero_bit(bh->b_data, 8192)) < 8192)
> 230                         break;
> 231         }
> 232         if (!bh || j >= 8192) {

You ask about the dereference bh->b_data and the test !bh.
The intention is that sbi->s_imap_blocks gives the number of
entries in sbi->s_imap that are nonzero. So, the bh in the
inner loop should be non-NULL. But after the loop bh can be NULL,
namely when sbi->s_imap_blocks == 0.


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932449AbWGLGNV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932449AbWGLGNV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 02:13:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932450AbWGLGNV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 02:13:21 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:58515
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932449AbWGLGNU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 02:13:20 -0400
Date: Tue, 11 Jul 2006 23:14:09 -0700 (PDT)
Message-Id: <20060711.231409.121242621.davem@davemloft.net>
To: kaos@ocs.com.au
Cc: linux-kernel@vger.kernel.org
Subject: Re: sparse annotation question
From: David Miller <davem@davemloft.net>
In-Reply-To: <27360.1152683223@kao2.melbourne.sgi.com>
References: <27360.1152683223@kao2.melbourne.sgi.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Keith Owens <kaos@ocs.com.au>
Date: Wed, 12 Jul 2006 15:47:03 +1000

> func (long regno, unsigned long *contents)
> {
> 	unsigned long i, *bsp;
> 	mm_segment_t old_fs;
> 	bsp = <expression involving only kernel variables>;
> 	old_fs = set_fs(KERNEL_DS);
> 	for (i = 0; i < (regno - 32); ++i)
> 		bsp = ia64_rse_skip_regs(bsp, 1);
> 	put_user(*contents, bsp);
> 	set_fs(old_fs);
> }
> 
> sparse is complaining that the second parameter to put_user() is not
> marked as __user.  How do I tell sparse to ignore this case?  Marking
> bsp as __user does not work, sparse then complains about incorrect type
> in assignment (different address spaces).

Since, in this case, you "know what you are doing" you can force the
matter by using the __force keyword as well as __user.


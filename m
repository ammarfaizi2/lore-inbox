Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752012AbWJWVWc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752012AbWJWVWc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 17:22:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752011AbWJWVWc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 17:22:32 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:53468 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1752012AbWJWVWb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 17:22:31 -0400
Date: Mon, 23 Oct 2006 14:23:07 -0700
From: Mike Kravetz <kravetz@us.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [RT] scheduling and oprofile
Message-ID: <20061023212307.GA21498@monkey.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been trying to use oprofile on an RT kernel to look at some
performance issues.  While running I notice the following sent to
the console:

BUG: scheduling with irqs disabled: java/0x00000000/4521
caller is rt_mutex_slowlock+0x156/0x1dd
 [<c032051a>] schedule+0x65/0xd2 (8)
 [<c0321338>] rt_mutex_slowlock+0x156/0x1dd (12)
 [<c032142a>] rt_mutex_lock+0x24/0x28 (72)
 [<c0134904>] rt_down_read+0x38/0x3b (20)
 [<c0322a89>] do_page_fault+0xe3/0x52d (12)
 [<c03229a6>] do_page_fault+0x0/0x52d (76)
 [<c01033bb>] error_code+0x4f/0x54 (8)
 [<c01ce6d0>] __copy_from_user_ll+0x55/0x7c (44)
 [<f89be7ef>] dump_user_backtrace+0x2e/0x56 [oprofile] (24)
 [<c0134869>] rt_up_read+0x3e/0x41 (20)
 [<f89be864>] x86_backtrace+0x4a/0x5a [oprofile] (20)
 [<f89bd53a>] oprofile_add_sample+0x73/0x89 [oprofile] (20)
 [<f89beea3>] athlon_check_ctrs+0x22/0x4a [oprofile] (32)
 [<f89be8c5>] nmi_callback+0x18/0x1b [oprofile] (28)
 [<c01041ff>] do_nmi+0x24/0x33 (12)
 [<c0103462>] nmi_stack_correct+0x1d/0x22 (16)

It seems strange to me that oprofile would be calling
'__copy_from_user_ll' in this context.  I can see why the
changes made for RT locking expose this.  But, doesn't this
issue also exist on non-RT (default) kernels?  What happens
when we generate a page fault in this context on non-RT kernels?

-- 
Mike

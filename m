Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751340AbWGLFrO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751340AbWGLFrO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 01:47:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751351AbWGLFrO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 01:47:14 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:58835 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751340AbWGLFrM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 01:47:12 -0400
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: sparse annotation question
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 12 Jul 2006 15:47:03 +1000
Message-ID: <27360.1152683223@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fragment of ia64 code calculates the address of a user space
location, starting from a kernel derived (i.e. not user supplied)
pointer.  put_user() has to be used because the code is running in
interrupt context and the calculated target address may be invalid or
paged out.

func (long regno, unsigned long *contents)
{
	unsigned long i, *bsp;
	mm_segment_t old_fs;
	bsp = <expression involving only kernel variables>;
	old_fs = set_fs(KERNEL_DS);
	for (i = 0; i < (regno - 32); ++i)
		bsp = ia64_rse_skip_regs(bsp, 1);
	put_user(*contents, bsp);
	set_fs(old_fs);
}

sparse is complaining that the second parameter to put_user() is not
marked as __user.  How do I tell sparse to ignore this case?  Marking
bsp as __user does not work, sparse then complains about incorrect type
in assignment (different address spaces).


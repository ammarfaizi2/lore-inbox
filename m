Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261489AbVCRIP4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261489AbVCRIP4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 03:15:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261490AbVCRIP4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 03:15:56 -0500
Received: from smtp1.Stanford.EDU ([171.67.16.123]:13448 "EHLO
	smtp1.Stanford.EDU") by vger.kernel.org with ESMTP id S261489AbVCRIPx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 03:15:53 -0500
Date: Fri, 18 Mar 2005 00:15:51 -0800 (PST)
From: Yichen Xie <yxie@cs.stanford.edu>
X-X-Sender: yxie@localhost.localdomain
To: linux-kernel@vger.kernel.org
Subject: Potential DOS in load_elf_library?
Message-ID: <Pine.LNX.4.60.0503180008140.25717@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys, I was looking at the load_elf_library function (fs/binfmt_elf.c) 
in 2.6.10, and noticed the following:

 	elf_phdata = (struct elf_phdr *) kmalloc(j, GFP_KERNEL);
 	...
 	while (elf_phdata->p_type != PT_LOAD) elf_phdata++;
 	...
 	kfree(elf_phdata);

Could this be problematic since the pointer being freed might be different 
from that returned from kmalloc?

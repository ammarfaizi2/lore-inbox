Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262458AbVAEPG7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262458AbVAEPG7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 10:06:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262459AbVAEPG7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 10:06:59 -0500
Received: from alog0273.analogic.com ([208.224.222.49]:5504 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262458AbVAEPG5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 10:06:57 -0500
Date: Wed, 5 Jan 2005 10:00:24 -0500 (EST)
From: linux-os <linux-os@chaos.analogic.com>
Reply-To: linux-os@analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: remap_pfm_range() Linux-2.6.10
Message-ID: <Pine.LNX.4.61.0501050951520.13645@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


History....

For many years we had:

 	struct vm_area_struct *vma;

 	remap_page_range(vma->vm_start, base_addr, len, prot)

Then somebody needed the pointer so it became:

 	remap_page_range(vma, vma->vm_start, base_addr, len, prot)

Then they changed its name:

 	remap_pfn_range(vma, vma->vm_start, base_addr >> PAGE_SHIFT, len, prot)

Now, here's the $US0.02 question. Why wasn't PAGE_SHIFT put inside
the new function? The base address cannot ever be used without
PAGE_SHIFT.  In previous versions, information hiding was properly
used to hide the implementation details. Now, part of the implementation
detail is exposed to interface code.

Is this going to be removed in the future, forcing another change
to all drivers that use memory-mapping or is this now considered
the correct way to implement a kernel function?

If you are going to put PAGE_SHIFT inside the function, please
do it now so we don't have to modify all the drivers again.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.10 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262106AbVBPXPC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262106AbVBPXPC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 18:15:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262118AbVBPXPC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 18:15:02 -0500
Received: from postfix3-1.free.fr ([213.228.0.44]:34493 "EHLO
	postfix3-1.free.fr") by vger.kernel.org with ESMTP id S262106AbVBPXPA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 18:15:00 -0500
Message-ID: <4213D3F8.2000904@free.fr>
Date: Thu, 17 Feb 2005 00:15:04 +0100
From: "Menyhart, Zoltan" <Zoltan.Menyhart@free.fr>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.3) Gecko/20040910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: dup_mmap() questions
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We lock the semaphore of the old "mm" for write.
Usually we do this when the corresponding VMA list is being modified.
Does "dup_mmap()" modify the old VMA list ?
Or would a "down_read(&oldmm->mmap_sem)" be enough ?

Should not we lock for write the semaphore of the new "mm" ?
It is on the "mmlist", it can be seen.
The new "vma" is on the "anon" list and on the "vma_prio_tree",
can it be done without holding for write the semaphore of the new "mm" ?

Should not we hold for write the semaphore of the new "mm"
when the new "vma" is actually added ?
Is the "page_table_lock" enough ?

Apparently, the argument "oldmm" is equal to "current->mm".
Why do we pass it as an argument ?

Thanks.




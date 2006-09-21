Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751041AbWIUIGS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751041AbWIUIGS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 04:06:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751046AbWIUIGS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 04:06:18 -0400
Received: from moutng.kundenserver.de ([212.227.126.177]:15323 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1751041AbWIUIGP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 04:06:15 -0400
Date: Thu, 21 Sep 2006 10:04:12 +0200
To: linux-kernel@vger.kernel.org
Subject: munmap from inside kernel
From: "Andreas Block" <andreas.block@esd-electronics.com>
Content-Type: text/plain; format=flowed; delsp=yes; charset=iso-8859-15
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-ID: <op.tf7x1ae18n9ctc@pc-block.esd>
User-Agent: Opera Mail/9.01 (Win32)
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:7ee1d245d6d47e4a96dce2c88f0dd45f
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

following scenario:
Two linux systems connected via PCI.
I'd like to write a driver, which allows to map memory from the remote  
system into local user space and vice versa.
This works quite well utilizing mmap and respective vma_ops.
I do have one problem though. When the buffer on the remote side gets  
destroyed, I'd like to remove the mappings from local user space into this  
buffer (I do prefer a segfaulting application over an application writing  
into "I don't know where").
Under kernel 2.4.x I used "do_munmap()" in protection of "mm->mmap_sem"  
and it seemed to work quite well for me.
Now using kernel 2.6.x (I tested 2.6.8 and 2.6.15) this seemingly doesn't  
work anymore, because I do end up with a crash, when trying to manually  
unmap the memory.

Is there any safe way to "trigger munmap()" from inside the kernel?

Best regards,
Andreas

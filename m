Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262774AbUCULRH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 06:17:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263634AbUCULRH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 06:17:07 -0500
Received: from mail.mellanox.co.il ([194.90.237.34]:33426 "EHLO
	mtlex01.yok.mtl.com") by vger.kernel.org with ESMTP id S262774AbUCULRF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 06:17:05 -0500
Message-ID: <405D7A0A.2000408@mellanox.co.il>
Date: Sun, 21 Mar 2004 13:18:34 +0200
From: Eli Cohen <mlxk@mellanox.co.il>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: locking user space memory in kernel
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I need to be able to lock memory allocated in user space and passed to 
my driver, in order to pass it to a dma controller that can maintain a 
translation table for each process. The obvious thing is to use 
sys_mlock() (and sys_munlock() for unlocking) but this function is not 
exported anymore, nore is sys_call_table.  I considered marking the 
relevant vma->vm_flags with VM_LOCKED and calling get_user_pages but 
that could be overkill if I want to lock just a portion of the VMA. 
Currently I do some hacking to find the addresses of sys_mlock/sys_munlock.
I also need to maintain a reference count on the locking /unlocking such 
that a region that has been locked twice will really be unlocked after 
unlocking twice. This needs to support partly overlapping regions. To 
cope with this I have implemented some code on top of calls to 
sys_mlock/sys_munlock to provide this functionality.
Are there more standard ways to get this functionality from the kernel? 
Any help is appreciated.

Thanks
Eli

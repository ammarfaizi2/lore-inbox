Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264136AbTIIPKL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 11:10:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264155AbTIIPKL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 11:10:11 -0400
Received: from 64-60-248-67.cust.telepacific.net ([64.60.248.67]:50 "EHLO
	mx.rackable.com") by vger.kernel.org with ESMTP id S264136AbTIIPKE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 11:10:04 -0400
Message-ID: <3F5DEBA5.9060607@rackable.com>
Date: Tue, 09 Sep 2003 08:03:01 -0700
From: Samuel Flory <sflory@rackable.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: sleeping function called from invalid context
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Sep 2003 15:10:03.0326 (UTC) FILETIME=[71F8D5E0:01C376E4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  I'm seeing this on arjanv's 2.6.0-0.test4.1.33 kernel.

Debug: sleeping function called from invalid context at 
include/asm/uaccess.h:473
Call Trace:
 [<c011b7dd>] __might_sleep+0x5d/0x70
 [<c010d0ea>] save_v86_state+0x6a/0x200
 [<c010c8b5>] do_IRQ+0xd5/0x110
 [<c010acd2>] work_notifysig_v86+0x6/0x14
 [<c010ac7f>] syscall_call+0x7/0xb

Debug: sleeping function called from invalid context at 
include/asm/uaccess.h:473
Call Trace:
 [<c011b7dd>] __might_sleep+0x5d/0x70
 [<c010d0ea>] save_v86_state+0x6a/0x200
 [<c010bba0>] do_general_protection+0x0/0xb0
 [<c010acd2>] work_notifysig_v86+0x6/0x14
 [<c010ac7f>] syscall_call+0x7/0xb


  Any thoughts.  The system seems to function despite the issue.  It 
seems to have also occurred under 2.6.0-0.test3.1.31:
Aug 25 16:28:49 goblin kernel: Call Trace:
Aug 25 16:28:49 goblin kernel:  [<c011af2d>] __might_sleep+0x5d/0x70
Aug 25 16:28:49 goblin kernel:  [<c010d06a>] save_v86_state+0x6a/0x200
Aug 25 16:28:49 goblin kernel:  [<c010bb50>] do_general_protection+0x0/0xb0
Aug 25 16:28:49 goblin kernel:  [<c010ac82>] work_notifysig_v86+0x6/0x14
Aug 25 16:28:49 goblin kernel:  [<c010ac2f>] syscall_call+0x7/0xb
Aug 25 16:28:49 goblin kernel:
Aug 25 16:28:50 goblin kernel: Debug: sleeping function called from 
invalid cont
ext at include/asm/uaccess.h:473
Aug 25 16:28:50 goblin kernel: Call Trace:
Aug 25 16:28:50 goblin kernel:  [<c011af2d>] __might_sleep+0x5d/0x70
Aug 25 16:28:50 goblin kernel:  [<c010d06a>] save_v86_state+0x6a/0x200
Aug 25 16:28:50 goblin kernel:  [<c010bb50>] do_general_protection+0x0/0xb0
Aug 25 16:28:50 goblin kernel:  [<c010ac82>] work_notifysig_v86+0x6/0x14
Aug 25 16:28:50 goblin kernel:  [<c010ac2f>] syscall_call+0x7/0xb
Aug 25 16:28:50 goblin kernel:
Aug 25 16:28:51 goblin kernel: Debug: sleeping function called from 
invalid cont
ext at include/asm/uaccess.h:473
Aug 25 16:28:51 goblin kernel: Call Trace:
Aug 25 16:28:51 goblin kernel:  [<c011af2d>] __might_sleep+0x5d/0x70
Aug 25 16:28:51 goblin kernel:  [<c010d06a>] save_v86_state+0x6a/0x200
Aug 25 16:28:51 goblin kernel:  [<c010c865>] do_IRQ+0xd5/0x110
Aug 25 16:28:51 goblin kernel:  [<c010ac82>] work_notifysig_v86+0x6/0x14
Aug 25 16:28:51 goblin kernel:  [<c010ac2f>] syscall_call+0x7/0xb

-- 
Once you have their hardware. Never give it back.
(The First Rule of Hardware Acquisition)
Sam Flory  <sflory@rackable.com>



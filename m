Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271146AbUJVBIl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271146AbUJVBIl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 21:08:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271105AbUJVBHP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 21:07:15 -0400
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:63110 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S271052AbUJVA7T
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 20:59:19 -0400
Message-ID: <41785B65.4090202@rtr.ca>
Date: Thu, 21 Oct 2004 20:59:17 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.9-ac3
References: <1098400086.18025.0.camel@localhost.localdomain>
In-Reply-To: <1098400086.18025.0.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 >Bug Fixes
 >o	Working IDE locking		(Alan Cox)
 >	| And a great deal of review by Bartlomiej

Mmm.. may still have some issues.

Here's what "cardctl eject" now gives on unload of ide-cs:

bad: scheduling while atomic!
  [<c02a0f7e>] schedule+0x4de/0x4f0
  [<c0119451>] __wake_up_common+0x41/0x60
  [<c02a1079>] wait_for_completion+0x99/0xf0
  [<c01193f0>] default_wake_function+0x0/0x20
  [<c01193f0>] default_wake_function+0x0/0x20
  [<c012c8a8>] queue_work+0x68/0x80
  [<c012c791>] call_usermodehelper+0xe1/0xf0
  [<c012c640>] __call_usermodehelper+0x0/0x70
  [<c01bdc7d>] kset_hotplug+0x1dd/0x240
  [<c01bdd3a>] kobject_hotplug+0x5a/0x60
  [<c01be07b>] kobject_del+0x1b/0x40
  [<c01be0b3>] kobject_unregister+0x13/0x30
  [<c018cef9>] del_gendisk+0x39/0xe0
  [<c0223cd8>] idedisk_cleanup+0x48/0x60
  [<c0212fd6>] __ide_unregister_hwif+0x506/0x5c0
  [<c0196be8>] ext3_mark_iloc_dirty+0x28/0x40
  [<c02130b6>] ide_unregister_hwif+0x26/0x40
  [<e092da23>] ide_release+0x73/0x80 [ide_cs]
  [<c0118992>] activate_task+0x62/0x80
  [<e092d1b6>] ide_detach+0x86/0xa0 [ide_cs]
  [<e08b5b19>] unbind_request+0xc9/0xd0 [ds]
  [<e08b62fd>] ds_ioctl+0x3dd/0x690 [ds]
  [<c029c25d>] unix_dgram_sendmsg+0x36d/0x570
  [<c0230ce0>] sock_sendmsg+0xe0/0x100
  [<c013bd8b>] generic_file_aio_write_nolock+0x27b/0x4b0
  [<c0185a7b>] proc_destroy_inode+0x1b/0x20
  [<c0172b75>] destroy_inode+0x35/0x60
  [<c0173ef2>] iput+0x62/0x90
  [<c0185a7b>] proc_destroy_inode+0x1b/0x20
  [<c0172b75>] destroy_inode+0x35/0x60
  [<c0147bb3>] zap_pmd_range+0x63/0x80
  [<c0147c23>] unmap_page_range+0x53/0x80
  [<c0147d36>] unmap_vmas+0xe6/0x1d0
  [<c014a4d7>] remove_vm_struct+0x77/0xa0
  [<c014bf1f>] unmap_vma_list+0x1f/0x30
  [<c014c2df>] do_munmap+0x14f/0x190
  [<c016ba30>] sys_ioctl+0x100/0x270
  [<c01060d9>] sysenter_past_esp+0x52/0x71

I see a similar dump when using delkin_cb on 2.6.9-ac3 as well.

Cheers
-- 
Mark Lord
(hdparm keeper & the original "Linux IDE Guy")

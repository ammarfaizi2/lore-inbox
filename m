Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264127AbTKJVpN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 16:45:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264128AbTKJVpM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 16:45:12 -0500
Received: from mail.kroah.org ([65.200.24.183]:62424 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264127AbTKJVpI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 16:45:08 -0500
Date: Mon, 10 Nov 2003 13:44:22 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test9-bk12 oops in file_ra_state_init
Message-ID: <20031110214422.GA1910@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, this laptop doesn't seem to like to stay up on a 2.6 kernel for more
than a few days.  Usually it locks up overnight and I can't catch any
oopses, but this morning I caught the following:

Unable to handle kernel paging request at virtual address 050d0000
 printing eip:
c013ab39
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c013ab39>]    Not tainted
EFLAGS: 00010246
EIP is at file_ra_state_init+0x19/0x20
eax: 050d0000   ebx: ccac0d20   ecx: 00000000   edx: ccac0d6c
esi: d5942c04   edi: ccac0d90   ebp: ffffffe9   esp: cf22bf30
ds: 007b   es: 007b   ss: 0068
Process ssh (pid: 7905, threadinfo=cf22a000 task=c1a57350)
Stack: d6fd4260 c014cb42 ccac0d6c d1942c98 00000003 00001000 40032000 00000000 
       00000000 00000003 d09d9000 cf22a000 c014cacd d5b424e0 d6fd4260 00000000 
       d5b424e0 d6fd4260 d193a460 00001000 fffffff4 00000101 00000001 00000001 
Call Trace:
 [<c014cb42>] dentry_open+0x62/0x1a0
 [<c014cacd>] filp_open+0x4d/0x60
 [<c014ce55>] sys_open+0x35/0x70
 [<c0108fb3>] syscall_call+0x7/0xb



Which then spireled off into lots of other oopses, all in the same file
at the same location.  Then these fun messages:

attempt to access beyond end of device
hda6: rw=0, want=2195953118, limit=20482812
Buffer I/O error on device hda6, logical block 3245460206
attempt to access beyond end of device
hda6: rw=0, want=2900596198, limit=20482812
Buffer I/O error on device hda6, logical block 3597781746
attempt to access beyond end of device
hda6: rw=0, want=2867041774, limit=20482812
Buffer I/O error on device hda6, logical block 3581004534


and then two more oopses in the same location.  hda6 is my /home drive.

Anyone have any ideas?

thanks,

greg k-h

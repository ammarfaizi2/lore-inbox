Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267523AbUHJRYc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267523AbUHJRYc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 13:24:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267589AbUHJRXo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 13:23:44 -0400
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:14232 "EHLO
	alpha.logic.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S267470AbUHJRSr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 13:18:47 -0400
Date: Tue, 10 Aug 2004 19:18:10 +0200
To: David Brownell <david-b@pacbell.net>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] 2.6.8-rc2-mm2 with usb and input problems
Message-ID: <20040810171809.GA4217@gamma.logic.tuwien.ac.at>
References: <20040802162845.GA24725@gamma.logic.tuwien.ac.at> <200408041926.31293.david-b@pacbell.net> <20040805065153.GC3984@gamma.logic.tuwien.ac.at> <200408050837.38757.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200408050837.38757.david-b@pacbell.net>
User-Agent: Mutt/1.3.28i
From: Norbert Preining <preining@logic.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David!

On Don, 05 Aug 2004, David Brownell wrote:
> > > Not clear how to read that stack; if it's usbdev_open()
> > > that's making the trouble, lock_kernel() is blocked.
> > > But that doesn't quite make sense to me.  Sorry!
> > 
> 
> Check other traces, surely something will make more sense.

Ok, here are two new ones with 2.6.8-rc4-mm1: The one from lsusb, the
other from cat /proc/bus/usb/devices ...


lsusb         D C0CE8B00     0  2605      1          2611  2351 (NOTLB)
d71f0eec 00000086 00000000 c0ce8b00 c015a30d 08088000 d71f0ef0 00000000 
       000f83ad 98a6d31f 0000007b dfb8b110 dfb8b2b8 c0d2f024 00000282 d71f0000 
       dfb8b110 c02d9d6b c0d2f02c 00000001 dfb8b110 c0118fd7 c0d2f02c c0d2f02c 
Call Trace:
 [<c015a30d>] link_path_walk+0xa56/0xd91
 [<c02d9d6b>] __down+0x8b/0x122
 [<c0118fd7>] default_wake_function+0x0/0xc
 [<c0205ffc>] get_device+0xe/0x14
 [<e08cf8ae>] usb_get_dev+0x12/0x16 [usbcore]
 [<c02d9f68>] __down_failed+0x8/0xc
 [<e08da6c5>] .text.lock.devio+0x5/0x150 [usbcore]
 [<c014cdeb>] dentry_open+0xfe/0x210
 [<c014d8ee>] vfs_read+0xa9/0xf5
 [<c014db4c>] sys_read+0x47/0x76
 [<c0105e4f>] syscall_call+0x7/0xb

cat           D 80000180     0  3902   3131                     (NOTLB)
d6c23e0c 00000086 d6c26530 80000180 c15dbe80 d702cc00 80000180 d2c0b840 
       00163790 8d5506e2 000000ff d50fee70 d50ff018 e08e58ac d6c23e1c d50fee70 
       e08e58ac c02daa87 00000409 e08e58b0 e08e58b0 e08e58b0 d50fee70 00000001 
Call Trace:
 [<c02daa87>] rwsem_down_read_failed+0x8f/0x191
 [<e08dc5cb>] .text.lock.devices+0x7/0x98 [usbcore]
 [<e08dbbc7>] usb_dump_interface+0x38/0x79 [usbcore]
 [<e08dbcfc>] usb_dump_config+0x91/0xcc [usbcore]
 [<e08dbfa7>] usb_dump_desc+0x94/0xad [usbcore]
 [<e08dc12e>] usb_device_dump+0x16e/0x2fa [usbcore]
 [<e08dc3b6>] usb_device_read+0xfc/0x12f [usbcore]
 [<c014d8ee>] vfs_read+0xa9/0xf5
 [<c014db4c>] sys_read+0x47/0x76
 [<c0105e4f>] syscall_call+0x7/0xb

Best wishes

Norbert

-------------------------------------------------------------------------------
Norbert Preining <preining AT logic DOT at>         Technische Universität Wien
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
SNITTERBY (n.)
Someone who pins snitters (q.v.) on to snitterfields (q.v.) and is
also suspected of being responsible for the extinction of virginstows
(q.v.)
			--- Douglas Adams, The Meaning of Liff

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265546AbUAPQPO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 11:15:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265554AbUAPQPO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 11:15:14 -0500
Received: from obsidian.spiritone.com ([216.99.193.137]:34513 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S265546AbUAPQOe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 11:14:34 -0500
Date: Fri, 16 Jan 2004 08:14:27 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: galen@starline.ee
Subject: [Bug 1886] New: Disconnecting scanner produces kernel	oops 
Message-ID: <1182380000.1074269667@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=1886

           Summary: Disconnecting scanner produces kernel oops
    Kernel Version: 2.6.1
            Status: NEW
          Severity: normal
             Owner: greg@kroah.com
         Submitter: galen@starline.ee


Distribution: Debian Unstable
Hardware Environment: chaintech 7aja, via kt133 chips, usb uchi
Software Environment: Debian Unstable, gcc version 3.3.3 20040110 (prerelease)
(Debian)

Problem Description: Working with obsoleted usb scanner module works fine
(scanner not supported by sane, so cant use usblib), until I disconnect scanner.
Then I get kernel oops (below) and cannot unload the module, even with with
force flag. After that, cat /proc/modules hangs too, and to get things working
again I have to boot :( 

 usb 1-2: USB disconnect, address 2
 Unable to handle kernel NULL pointer dereference at virtual address 0000001e
  printing eip:
 e089d0cc
 *pde = 00000000
 Oops: 0000 [#1]
 CPU:    0
 EIP:    0060:[_end+540430148/1068260984]    Not tainted
 EFLAGS: 00010282
 EIP is at disconnect_scanner+0x2c/0x6d [scanner]
 eax: dfce73c0   ebx: dfce73d4   ecx: e089d0a0   edx: dfd67800
 esi: 00000000   edi: dd0f7168   ebp: e08a0bfc   esp: dfdf1e50
 ds: 007b   es: 007b   ss: 0068
 Process khubd (pid: 5, threadinfo=dfdf0000 task=c151c040)
 Stack: dfce73c0 e08a0c78 dfce73c0 e08a0ce0 c02fcb5b dfce73c0 dfce73c0 dfce7400
        dfce73d4 e08a0d00 c028c494 dfce73d4 dfce7400 dd0f717c dd0f7140 e089ca4f
        dfce73d4 dfce73c0 dd0f717c e08a0c0c 00000000 00000000 c0235538 dd0f717c
 Call Trace:
  [usb_unbind_interface+123/128] usb_unbind_interface+0x7b/0x80
  [device_release_driver+100/112] device_release_driver+0x64/0x70
  [_end+540428487/1068260984] destroy_scanner+0x4f/0xb0 [scanner]
  [kobject_cleanup+152/160] kobject_cleanup+0x98/0xa0
  [usb_unbind_interface+123/128] usb_unbind_interface+0x7b/0x80
  [device_release_driver+100/112] device_release_driver+0x64/0x70
  [bus_remove_device+85/160] bus_remove_device+0x55/0xa0
  [device_del+93/160] device_del+0x5d/0xa0
  [usb_disable_device+111/176] usb_disable_device+0x6f/0xb0
  [usb_disconnect+150/224] usb_disconnect+0x96/0xe0
  [hub_port_connect_change+783/800] hub_port_connect_change+0x30f/0x320
  [hub_port_status+67/176] hub_port_status+0x43/0xb0
  [hub_events+714/832] hub_events+0x2ca/0x340
  [hub_thread+45/240] hub_thread+0x2d/0xf0
  [ret_from_fork+6/20] ret_from_fork+0x6/0x14
  [default_wake_function+0/32] default_wake_function+0x0/0x20
  [hub_thread+0/240] hub_thread+0x0/0xf0
  [kernel_thread_helper+5/12] kernel_thread_helper+0x5/0xc

 Code: 80 7e 1e 00 75 2e 85 f6 74 17 8d 46 3c 8b 5c 24 08 8b 74 24



Steps to reproduce:

Compile kernel with usb and usbscanner support, swich scanner on, swich scanner off.



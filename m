Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262706AbTDXPNW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 11:13:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263726AbTDXPNW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 11:13:22 -0400
Received: from nika.frontier.iarc.uaf.edu ([137.229.94.16]:15238 "EHLO
	nika.frontier.iarc.uaf.edu") by vger.kernel.org with ESMTP
	id S262706AbTDXPNT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 11:13:19 -0400
Date: Thu, 24 Apr 2003 07:25:56 -0800
From: Christopher Swingley <cswingle@iarc.uaf.edu>
To: linux-kernel@vger.kernel.org
Subject: 2.5.68, khubd oops upon USB flash drive removal
Message-ID: <20030424152556.GA11972@iarc.uaf.edu>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-gpg-fingerprint: B96C 58DC 0643 F8FE C9D0  8F55 1542 1A4F 0698 252E
X-gpg-key: [http://www.frontier.iarc.uaf.edu/~cswingle/gnupgkey.asc]
X-URL: [http://www.frontier.iarc.uaf.edu/~cswingle/]
X-Editor: VIM [http://www.vim.org]
X-message-flag: Consider Linux: fast, reliable, secure & free!
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

I reported this for 2.5.67 as well.  Repeatable on more than one sort of 
i386 machine (P3, K7).  Insert USB flash drive, mount drive, unmount 
drive, remove USB device, kernel oops.  Kernel keeps running, but USB is 
dead.  Here's the oops from /var/log/kern.log.  I have symbol 
information in the kernel, which (correct me if I'm wrong!) means I 
don't need ksymoops, right?

#####
usb 1-1: USB disconnect, address 3
Unable to handle kernel NULL pointer dereference at virtual address 00000001
 printing eip:
c01badd3
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[proc_match+19/64]    Not tainted
EFLAGS: 00010286
EIP is at proc_match+0x13/0x40
eax: ffffffff   ebx: c1bcd85c   ecx: ffffffff   edx: c11efdc8
esi: c11efdc8   edi: c1bcd88c   ebp: c11efd8c   esp: c11efd84
ds: 007b   es: 007b   ss: 0068
Process khubd (pid: 4, threadinfo=c11ee000 task=c114d320)
Stack: 00000001 c1bcd88c c11efdb4 c01bc3d2 00000001 c11efdc8 ffffffff c11efdb4 
       c11efdc8 c7e725e0 c11efdc8 c7e721b0 c11efde0 c0337bc2 c11efdc8 c1bcd85c 
       00000000 c7b20030 c7e721b0 c11efe58 c7e725e0 c7e725e0 c7b20200 c11efe58 
Call Trace:
 [remove_proc_entry+82/288] remove_proc_entry+0x52/0x120
 [scsi_proc_host_rm+66/112] scsi_proc_host_rm+0x42/0x70
 [scsi_unregister+253/576] scsi_unregister+0xfd/0x240
 [scsi_remove_device+64/80] scsi_remove_device+0x40/0x50
 [scsi_remove_device+64/80] scsi_remove_device+0x40/0x50
 [storage_disconnect+429/785] storage_disconnect+0x1ad/0x311
 [iput+99/144] iput+0x63/0x90
 [storage_disconnect+0/785] storage_disconnect+0x0/0x311
 [usb_device_remove+156/160] usb_device_remove+0x9c/0xa0
 [device_release_driver+102/112] device_release_driver+0x66/0x70
 [bus_remove_device+127/208] bus_remove_device+0x7f/0xd0
 [device_del+108/176] device_del+0x6c/0xb0
 [device_unregister+20/34] device_unregister+0x14/0x22
 [usb_disconnect+199/352] usb_disconnect+0xc7/0x160
 [usb_hub_port_connect_change+831/848] usb_hub_port_connect_change+0x33f/0x350
 [usb_hub_port_status+104/176] usb_hub_port_status+0x68/0xb0
 [usb_hub_events+1014/1392] usb_hub_events+0x3f6/0x570
 [allow_signal+204/512] allow_signal+0xcc/0x200
 [usb_hub_thread+53/240] usb_hub_thread+0x35/0xf0
 [default_wake_function+0/32] default_wake_function+0x0/0x20
 [usb_hub_thread+0/240] usb_hub_thread+0x0/0xf0
 [kernel_thread_helper+5/24] kernel_thread_helper+0x5/0x18

Code: 0f b7 48 02 3b 4d 08 74 14 31 c0 8b 34 24 8b 7c 24 04 89 ec 
 <3>drivers/usb/host/uhci-hcd.c: 1060: host controller halted. very bad
#####

Chris
-- 
Christopher S. Swingley          email: cswingle@iarc.uaf.edu
IARC -- Frontier Program         Please use encryption.  GPG key at:
University of Alaska Fairbanks   www.frontier.iarc.uaf.edu/~cswingle/


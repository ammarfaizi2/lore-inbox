Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261249AbVDDOq4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261249AbVDDOq4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 10:46:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261253AbVDDOq4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 10:46:56 -0400
Received: from wsip-68-99-153-203.ri.ri.cox.net ([68.99.153.203]:19401 "EHLO
	blue-labs.org") by vger.kernel.org with ESMTP id S261249AbVDDOqx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 10:46:53 -0400
Message-ID: <42515358.7020101@blue-labs.org>
Date: Mon, 04 Apr 2005 10:46:48 -0400
From: David Ford <david+challenge-response@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8b2) Gecko/20050331
MIME-Version: 1.0
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: ALSA bugs with 2.6.12-rc1
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems that 2.6.12-rc1 introduced an ALSA bug generating an oops for a 
null pointer.

codec_semaphore: semaphore is not ready [0x1][0x300300]
codec_read 0: semaphore is not ready for register 0x2c
Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
c01d7746
*pde = 00000000
Oops: 0002 [#1]
PREEMPT
Modules linked in: orinoco_cs orinoco hermes pcmcia yenta_socket 
rsrc_nonstatic pcmcia_core vfat fat nls_base i2c_sensor i2c_core eth1394 
ohci1394 ieee1394 i8k
CPU:    0
EIP:    0060:[<c01d7746>]    Not tainted VLI
EFLAGS: 00010202   (2.6.12-rc1)
EIP is at memcpy+0x1e/0x39
eax: 00000010   ebx: e7608180   ecx: 00000004   edx: 00000000
esi: e13d1ee4   edi: 00000000   ebp: bf924390   esp: e13d1eb4
ds: 007b   es: 007b   ss: 0068
Process artsd (pid: 11880, threadinfo=e13d1000 task=e1436590)
Stack: ffffffea ffffffea e13d1ef4 c02b8793 00000000 e13d1ee4 00000010 
e7608180
       c02b954d e7608180 e13d1ee4 00000050 00000006 00000000 00000000 
00000000
       00000005 00000001 00000000 00000000 00008002 00000000 00000000 
00000000
Call Trace:
 [<c02b8793>] snd_timer_user_append_to_tqueue+0x40/0x49
 [<c02b954d>] snd_timer_user_params+0x236/0x245
 [<c016f152>] do_ioctl+0x9a/0xa9
 [<c016f2ef>] vfs_ioctl+0x65/0x1e1
 [<c015bc34>] get_unused_fd+0x2c/0xd2
 [<c016f4b0>] sys_ioctl+0x45/0x6d
 [<c0102f87>] sysenter_past_esp+0x54/0x75
Code: fd 31 c0 c3 31 d2 b8 f2 ff ff ff c3 90 83 ec 0c 8b 44 24 18 8b 54 
24 10 89 74 24 04 89 c1 89 7c 24 08 8b 74 24 14 c1 e9 02 89 d7 <f3> a5 
a8 02 74 02 66 a5 a8 01 74 01 a4 89 d0 8b 74 24 04 8b 7c
 codec_semaphore: semaphore is not ready [0x1][0x300300]
codec_read 1: semaphore is not ready for register 0x54
codec_semaphore: semaphore is not ready [0x1][0x300300]
codec_write 1: semaphore is not ready for register 0x54


This happens on multiple machines, 32b and 64bit.  I'll be happy to 
provide further information if needed.

-david


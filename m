Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262142AbTIMSI0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 14:08:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262158AbTIMSI0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 14:08:26 -0400
Received: from 62-43-29-174.user.ono.com ([62.43.29.174]:32640 "EHLO wanda")
	by vger.kernel.org with ESMTP id S262142AbTIMSIU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 14:08:20 -0400
From: Paco Ros <switch@tiscali.es>
Reply-To: switch@tiscali.es
To: linux-kernel@vger.kernel.org
Subject: visor module and Palm Zire 71 problem.
Date: Sat, 13 Sep 2003 20:08:17 +0200
User-Agent: KMail/1.5.3
Don't-Read-With: Microsoft Outlook, Microsoft Outlook Express
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309132008.17716.switch@tiscali.es>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I bought one of these nice Palm handhelds with integrated camera.
I was running 2.4.20 kernel at that time and I modified the following files:
- drivers/usb/serial/visor.h
 added #define PALM_ZIRE71_ID			0x0060

- drivers/usb/serial/visor.c
 added id_table and id_table_combined definitions.

You have both modified from 2.4.20 files here:
http://bulmalug.net/~pacoros/articulos/visor.c
http://bulmalug.net/~pacoros/articulos/visor.h

They were working fine with pilot-link software.

Some weeks ago I compiled a 2.4.22-ac1 kernel and I saw that a new version of visor was released.
I haven't been able to make my Zire 71 work with this kernel version.

The trick of adding PALM_ZIRE71_ID definition does not work anymore and I get a Oops! when the module tries to be removed.
Here is the log:
Sep 13 19:48:06 wanda kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000998
Sep 13 19:48:06 wanda kernel:  printing eip:
Sep 13 19:48:06 wanda kernel: e1c1816a
Sep 13 19:48:06 wanda kernel: *pde = 00000000
Sep 13 19:48:06 wanda kernel: Oops: 0002
Sep 13 19:48:06 wanda kernel: CPU:    0
Sep 13 19:48:06 wanda kernel: EIP:    0010:[<e1c1816a>]    Tainted: P
Sep 13 19:48:06 wanda kernel: EFLAGS: 00010246
Sep 13 19:48:06 wanda kernel: eax: 00000000   ebx: d054a86c   ecx: d00c5000   edx: 00000000
Sep 13 19:48:06 wanda kernel: esi: d054a888   edi: 00000001   ebp: d054a800   esp: def55f20
Sep 13 19:48:06 wanda kernel: ds: 0018   es: 0018   ss: 0018
Sep 13 19:48:06 wanda kernel: Process khubd (pid: 60, stackpage=def55000)
Sep 13 19:48:06 wanda kernel: Stack: d054a888 00000000 00000018 e1c19520 00000000 e1c19500 d00c5400 e08e6554
Sep 13 19:48:06 wanda kernel:        d9b0cc00 d054a800 d9b0cc04 00000003 00000000 d9b0cc00 00000100 0000000a
Sep 13 19:48:06 wanda kernel:        deaff800 00000001 e08e97d5 deaff910 00000002 00000010 00000001 e08f3dae
Sep 13 19:48:06 wanda kernel: Call Trace:    [<e1c19520>] [<e1c19500>] [ipt_state:__insmod_ipt_state_O/lib/modules/2.4.22-ac1/kernel/net/ipv4+-727724/96] [ipt_state:__insmod_ipt_state_O/lib/modules/2.4.22-ac1/kernel/net/ipv4+-714795/96] [ipt_state:__insmod_ipt_state_O/lib/modules/2.4.22-ac1/kernel/net/ipv4+-672338/96]
Sep 13 19:48:06 wanda kernel:   [ipt_state:__insmod_ipt_state_O/lib/modules/2.4.22-ac1/kernel/net/ipv4+-714064/96] [ipt_state:__insmod_ipt_state_O/lib/modules/2.4.22-ac1/kernel/net/ipv4+-713883/96] [arch_kernel_thread+43/64] [ipt_state:__insmod_ipt_state_O/lib/modules/2.4.22-ac1/kernel/net/ipv4+-713936/96]
Sep 13 19:48:06 wanda kernel:
Sep 13 19:48:06 wanda kernel: Code: c7 80 98 09 00 00 00 00 00 00 8d 4e 58 ff 43 74 0f 8e 5f 05

It seems there's some problem at khubd (I have my handheld plugged in a usb hub)

Is Palm Zire 71 going to be officially supported?
I've been googling and looking for visor project and seems to be completely integrated in kernel tree and no news or movement is appreciated at usbvisor web site.

Best greetings.
-- 
Paco Ros.
Member of Balearic Islands Linux User Group BULMA
http://www.bulmalug.net


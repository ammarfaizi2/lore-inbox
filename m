Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262878AbTJTWIX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 18:08:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262881AbTJTWIW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 18:08:22 -0400
Received: from pa208.myslowice.sdi.tpnet.pl ([213.76.228.208]:44170 "EHLO
	finwe.eu.org") by vger.kernel.org with ESMTP id S262878AbTJTWIU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 18:08:20 -0400
Date: Tue, 21 Oct 2003 00:08:17 +0200
From: Jacek Kawa <jfk@zeus.polsl.gliwice.pl>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: linux-usb-devel@lists.sourceforge.net
Subject: 2.6.0-test6, usblp (usb?) oops
Message-ID: <20031020220817.GA32167@finwe.eu.org>
Mail-Followup-To: Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-usb-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Kreatorzy Kreacji Bialej
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got oops in 2.6.0-test6 while rebooting to 2.6.0-test8 :) 
I will try to reproduce it later with -test8, but in the meantime...

 drivers/usb/class/usblp.c: usblp0: removed
  printing eip:
 c02296e5
 Oops: 0000 [#1]
 CPU:    0
 EIP:    0060:[usb_buffer_free+21/96]    Not tainted
 EFLAGS: 00010202
 EIP is at usb_buffer_free+0x15/0x60
 eax: c5928c00   ebx: c38ebd80   ecx: c0372844   edx: 00000001
 esi: c38ebd84   edi: c77e4240   ebp: c2800dfc   esp: c6fc5e30
 ds: 007b   es: 007b   ss: 0068
 Process ptal-mlcd (pid: 762, threadinfo=c6fc4000 task=c70446a0)
 Stack: c016a743 c38ebd80 c38ebd84 c77e4240 c802c38f c5928c00 00002000 c1a4c000 
        01a4c000 c38ebd80 c802c488 c38ebd80 c640f380 c802c430 c015269a c2800dfc 
        c640f380 c0770a80 c640f380 00000000 c6ffe180 00000001 c0150b79 c640f380 
 Call Trace:
  [destroy_inode+67/112] destroy_inode+0x43/0x70
  [_end+130628471/1069963240] usblp_cleanup+0x3f/0xa0 [usblp]
  [_end+130628720/1069963240] usblp_release+0x58/0x60 [usblp]
  [_end+130628632/1069963240] usblp_release+0x0/0x60 [usblp]
  [__fput+282/304] __fput+0x11a/0x130
  [filp_close+89/144] filp_close+0x59/0x90
  [put_files_struct+100/208] put_files_struct+0x64/0xd0
  [do_exit+347/1008] do_exit+0x15b/0x3f0
  [do_group_exit+58/176] do_group_exit+0x3a/0xb0
  [get_signal_to_deliver+610/880] get_signal_to_deliver+0x262/0x370
  [do_signal+147/288] do_signal+0x93/0x120
  [__pollwait+0/208] __pollwait+0x0/0xd0
  [sys_select+612/1312] sys_select+0x264/0x520
  [do_notify_resume+55/60] do_notify_resume+0x37/0x3c
  [work_notifysig+19/21] work_notifysig+0x13/0x15
 
 Code: 8b 4a 20 85 c9 74 14 8b 41 18 85 c0 75 11 8d b6 00 00 00 00 


config: http://zeus.polsl.gliwice.pl/~jfk/kernel/2.6.0-test6/config

System information (gathered in 2.6.0-test8):

cpuinfo: http://zeus.polsl.gliwice.pl/~jfk/kernel/2.6.0-test6/cpuinfo
dmesg: http://zeus.polsl.gliwice.pl/~jfk/kernel/2.6.0-test6/dmesg
  (boot options as in 2.6.0-test6)
lsmod: http://zeus.polsl.gliwice.pl/~jfk/kernel/2.6.0-test6/lsmod
lspci: http://zeus.polsl.gliwice.pl/~jfk/kernel/2.6.0-test6/lspci
lspci -v: http://zeus.polsl.gliwice.pl/~jfk/kernel/2.6.0-test6/lspci-v
lspci -v -v: http://zeus.polsl.gliwice.pl/~jfk/kernel/2.6.0-test6/lspci-v-v
modules: http://zeus.polsl.gliwice.pl/~jfk/kernel/2.6.0-test6/modules

module-init-tools: module-init-tools 0.9.15-pre2

If I can provide some more information, please let me know. 

bye

-- 
Jacek Kawa  **You know, you come from nothing-you're going back to
               nothing. What have you lost? Nothing!** ["MPFC"]

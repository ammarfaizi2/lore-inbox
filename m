Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262585AbVDGUI2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262585AbVDGUI2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 16:08:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262586AbVDGUI1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 16:08:27 -0400
Received: from fire.osdl.org ([65.172.181.4]:35757 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262585AbVDGUIS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 16:08:18 -0400
Date: Thu, 7 Apr 2005 13:08:14 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: linux-os@analogic.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux-2.6.11 can't disable CAD
Message-Id: <20050407130814.46f70fbc.rddunlap@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0504071538120.7168@chaos.analogic.com>
References: <Pine.LNX.4.61.0504071102590.4871@chaos.analogic.com>
	<20050407115904.1d1ee28f.rddunlap@osdl.org>
	<Pine.LNX.4.61.0504071538120.7168@chaos.analogic.com>
Organization: OSDL
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: SvC&!/v_Hr`MvpQ*|}uez16KH[#EmO2Tn~(r-y+&Jb}?Zhn}c:Eee&zq`cMb_[5`tT(22ms
 (.P84,bq_GBdk@Kgplnrbj;Y`9IF`Q4;Iys|#3\?*[:ixU(UR.7qJT665DxUP%K}kC0j5,UI+"y-Sw
 mn?l6JGvyI^f~2sSJ8vd7s[/CDY]apD`a;s1Wf)K[,.|-yOLmBl0<axLBACB5o^ZAs#&m?e""k/2vP
 E#eG?=1oJ6}suhI%5o#svQ(LvGa=r
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Apr 2005 15:46:20 -0400 (EDT) Richard B. Johnson wrote:

| On Thu, 7 Apr 2005, Randy.Dunlap wrote:
| 
| > On Thu, 7 Apr 2005 11:16:14 -0400 (EDT) Richard B. Johnson wrote:
| >
| > |
| > | In the not-too distant past, one could disable Ctl-Alt-DEL.
| > | Can't do it anymore.
| >
| > What should disabling C_A_D do?
| >
| > | Script started on Thu 07 Apr 2005 10:58:11 AM EDT
| > | [SNIPPED leading stuff...]
| > |
| > | mprotect(0xb7fe4000, 28672, PROT_READ|PROT_EXEC) = 0
| > | brk(0)                                  = 0x804a000
| > | brk(0x8053000)                          = 0x8053000
| > | reboot(LINUX_REBOOT_MAGIC1, LINUX_REBOOT_MAGIC2, LINUX_REBOOT_CMD_CAD_OFF)
| > = 0
| > | pause( <unfinished ...>
| > | _exit(0)                                = ?
| > | # exit
| > | Script done on Thu 07 Apr 2005 10:58:21 AM EDT
| >
| 
| It's a program that executes the __NR_reboot syscall (88) after
| putting the documented values into the appropriate registers.

Yeah, I understood that much.  Just wondering if it was
available somewhere...

| > What program is that?  I'm just echoing 0 | 1 into
| > /proc/sys/kernel/ctrl-alt-del , is that equivalent?
| > or have you tried that?
| >
| 
| Doesn't matter. Many embedded systems don't have /proc because
| they don't have any file-systems.

It matters if they are equivalent (and I don't have that
program above).

| > | Observe that reboot() returns 0 and `strace` understands what
| > | parameters were passed. The result is that, if I hit Ctl-Alt-Del,
| > | `init` will still execute the shutdown-order (INIT 0).
| >
| > echo 0 > /proc/sys/kernel/ctrl-alt-del
| >  is same as CAD_OFF
| > echo 1
| >  is same as CAD_ON
| >
| > I tested 2.4.28, 2.6.3, 2.6.9, 2.6.11, and all of them behaved
| > the same way for me.  If it's an issue with using a syscall
| > to change the setting, I'll be glad to look into that too.
| >
| > observed behaviors:
| > CAD enabled + C_A_D keys => call machine_reboot()
| >  to reboot quickly, no normal shutdown sequence;
| > CAD disabled + C_A_D keys => kill init, go thru normal
| >  clean shutdown sequence;
| > are these the expected behaviors?
| 
| The expected behavior of the reported operation is for
| Ctl-Alt-Del to no longer do anything. If the system-call
| has been depreciated, then the call should return -1 and
| errno should be ENOSYS. In such a case, I would have
| to trap the key-sequence in some other way, not that
| I know how without modifying the kernel.

Have you looked at 'man 2 reboot'?  It seems to agree with
the observed behavior (above).
or where should I look to find documentation of the
expected behavior that you described?

---
~Randy

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751172AbVHLNTo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751172AbVHLNTo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 09:19:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751173AbVHLNTo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 09:19:44 -0400
Received: from cantor.suse.de ([195.135.220.2]:30596 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751172AbVHLNTo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 09:19:44 -0400
Date: Fri, 12 Aug 2005 15:19:43 +0200
From: Olaf Hering <olh@suse.de>
To: linux-kernel@vger.kernel.org
Subject: netconsole lockup with current kernel 2.6.13-rc6-git3
Message-ID: <20050812131942.GA2696@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


on the system to debug do:

girgendwas:~ # netconsole-server boettger:12346
verify the loglevel. otherwise no message may appear on the remove host, see man
dmesg(1)
now run 'netcat -l -u -p 12346' on host 10.10.125.16 to see further kernel messages
girgendwas:~ # echo 8 > /proc/sysrq-trigger
girgendwas:~ # echo t > /proc/sysrq-trigger

on the system to retrieve kernel messages from client above do:

netcat -l -u -p 12346
SysRq : Changing Loglevel
Loglevel set to 8
SysRq : Show State

                                               sibling
  task             PC      pid father child younger older
init          S 00000286     0     1      0     2               (NOTLB)
dfe1fec8 00000082 dfe1e000 00000286 0000002c 00000058 4f924352 00007b27
       ffff037f 00000bca 4f924ace 00007b27 c15d3b88 c15d3a60 c15d3540 c140d160
       4f92b4eb 00007b27 dfe1e000 00000000 00000282 c012f350 0204f514 c140dfe0
Call Trace:
 [<c012f350>] lock_timer_base+0x20/0x50
 [<c012f428>] __mod_timer+0xa8/0xd0
 [<c0342d7e>] schedule_timeout+0x4e/0xc0
 [<c012fed0>] process_timeout+0x0/0x10
 [<c018541f>] do_select+0x2af/0x360
 [<c0184f90>] __pollwait+0x0/0xd0


this is all I get, then the system is dead. I see it also on G5, no interrupts
served. Will check if older kernels work ok, it does at least work in SLES9

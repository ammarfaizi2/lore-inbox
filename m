Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263354AbTIWMIq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 08:08:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263355AbTIWMIq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 08:08:46 -0400
Received: from mail.gmx.net ([213.165.64.20]:55231 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263354AbTIWMIo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 08:08:44 -0400
Date: Tue, 23 Sep 2003 14:08:43 +0200 (MEST)
From: "Daniel Blueman" <daniel.blueman@gmx.net>
To: linux-kernel@vger.kernel.org, davej@codemonkey.org.uk,
       padraig@antefacto.com
MIME-Version: 1.0
Subject: [OOPS] [2.6.0-test5-bk8] cpufreq and sysfs problem...
X-Priority: 3 (Normal)
X-Authenticated: #8973862
Message-ID: <10099.1064318923@www55.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I load the longhaul driver, set the governor to userspace and then 'rmmod
longhaul'.

If I cd to "/sys/[...]/cpu/cpu0/cpufreq" before I do the 'rmmod' then the
oops doesn't happen, presumably because the open file in the directory holds
the inode ref count above 0, stopping the directory being deleted.

Looks like it's to do with the removal of the 'scaling_setspeed' file, in a
directory owned by the module which is being removed.  Not sure if the
userspace modules need to increase the ref count of the directory or if sysfs
should manage that.

Please CC me on any replies for any response.

---

 printing eip:
c01803ec
Oops: 0002 [#1]
CPU:    0
EIP:    0060:[sysfs_hash_and_remove+12/100]    Not tainted
EFLAGS: 00010246
EIP is at sysfs_hash_and_remove+0xc/0x64
eax: 00000000   ebx: c02afa80   ecx: 00000068   edx: 00000000
esi: d7ce1e80   edi: f6c9fc80   ebp: 00000002   esp: dacb3eec
ds: 007b   es: 007b   ss: 0068
Process rmmod (pid: 11059, threadinfo=dacb2000 task=f6ec8710)
Stack: c02afa80 00000000 c01e73e2 d7ce1e80 c025fb73 00000001 f6c9fc80
f6c9fc80
       c01e691a f6c9fc80 00000002 f6c9fcb4 f6c9fc80 c02ad71c c02ad368
c01e6638
       f6c9fc80 00000002 c0306624 c02afa54 c01bdea3 c0306624 f8810680
00000880
Call Trace:
 [cpufreq_governor_userspace+434/448] cpufreq_governor_userspace+0x1b2/0x1c0
 [__cpufreq_governor+90/288] __cpufreq_governor+0x5a/0x120
 [cpufreq_remove_dev+168/224] cpufreq_remove_dev+0xa8/0xe0
 [sysdev_driver_unregister+115/208] sysdev_driver_unregister+0x73/0xd0
 [cpufreq_unregister_driver+36/83] cpufreq_unregister_driver+0x24/0x53
 [__crc_ip_mc_join_group+1281510/2332411] longhaul_exit+0xa/0x18 [longhaul]
 [sys_delete_module+278/400] sys_delete_module+0x116/0x190
 [do_munmap+250/304] do_munmap+0xfa/0x130
 [syscall_call+7/11] syscall_call+0x7/0xb

Code: ff 48 68 78 53 8b 4c 24 10 51 56 e8 74 ff ff ff 89 c3 81 fb

-- 
Daniel J Blueman

+++ GMX - die erste Adresse für Mail, Message, More! +++

Getestet von Stiftung Warentest: GMX FreeMail (GUT), GMX ProMail (GUT)
(Heft 9/03 - 23 e-mail-Tarife: 6 gut, 12 befriedigend, 5 ausreichend)

Jetzt selbst kostenlos testen: http://www.gmx.net


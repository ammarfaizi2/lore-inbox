Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262272AbUKVSmV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262272AbUKVSmV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 13:42:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262339AbUKVSkK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 13:40:10 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:14496 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S262332AbUKVSgK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 13:36:10 -0500
Date: Mon, 22 Nov 2004 19:36:03 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: linux-kernel@vger.kernel.org, reiser@namesys.com
cc: mantel@suse.de
Subject: [reiser4 bug] Whoops on module unload
Message-ID: <Pine.LNX.4.53.0411221929460.2981@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


I just picked this up from /dev/vcsa10 (and /var/log/{kernel,messages})...
seems to have happened upon `rmmod reiser4`. Did not luckily seem to make the
system unusable.

Kernel-version: SUSE Kernel of the day 20041029
Reiser4 fs were not mounted at the time of the rmmod (that's logic), but were
mounted before.

The backtrace does not give much info (and ksymoops neither), so the best I
could suggest is checking whether these codepaths allow unfreed objects. Since
the KOTD I'm using is also a month old by now, don't invest too much time into
this, if at all.

Nov 22 19:29:13 otto kernel: slab error in kmem_cache_destroy(): cache
`plugin_set': Can't free all objects
Nov 22 19:29:13 otto kernel:  [kmem_cache_destroy+216/304]
kmem_cache_destroy+0xd8/0x130
Nov 22 19:29:13 otto kernel:  [<c0137b88>] kmem_cache_destroy+0xd8/0x130
Nov 22 19:29:13 otto kernel:  [pg0+276180016/1069949952]
plugin_set_done+0x10/0x40 [reiser4]
Nov 22 19:29:13 otto kernel:  [<d0afec30>] plugin_set_done+0x10/0x40 [reiser4]
Nov 22 19:29:13 otto kernel:  [pg0+276150806/1069949952]
shutdown_reiser4+0x126/0x270 [reiser4]
Nov 22 19:29:13 otto kernel:  [<d0af7a16>] shutdown_reiser4+0x126/0x270
[reiser4]
Nov 22 19:29:13 otto kernel:  [sys_delete_module+415/432]
sys_delete_module+0x19f/0x1b0
Nov 22 19:29:13 otto kernel:  [<c012ba5f>] sys_delete_module+0x19f/0x1b0
Nov 22 19:29:13 otto kernel:  [do_munmap+289/368] do_munmap+0x121/0x170
Nov 22 19:29:13 otto kernel:  [<c0141351>] do_munmap+0x121/0x170
Nov 22 19:29:13 otto kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov 22 19:29:13 otto kernel:  [<c010414f>] syscall_call+0x7/0xb


Jan Engelhardt
-- 
Gesellschaft für Wissenschaftliche Datenverarbeitung
Am Fassberg, 37077 Göttingen, www.gwdg.de

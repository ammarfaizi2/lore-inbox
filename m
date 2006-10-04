Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751135AbWJDVRH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751135AbWJDVRH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 17:17:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751138AbWJDVRG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 17:17:06 -0400
Received: from wx-out-0506.google.com ([66.249.82.232]:53431 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751135AbWJDVRF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 17:17:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Tv9NhnTzgyVJzmdKBSKqJXhif4b4ygBW9YJFz6hkFOIAMOql8ukoitvr69bSd5NauHTFiskjejV+9Zgo7yGGnLxsbJP8f1hwN7M80At5W1iWqGockLRK9E8VQVfsHTYV4bXZO5ublhEXqQW8gAaaMYN77+y6Q+OVZyqc+N9LW5w=
Message-ID: <5a4c581d0610041417y113bb92cs10971308180980e5@mail.gmail.com>
Date: Wed, 4 Oct 2006 23:17:04 +0200
From: "Alessandro Suardi" <alessandro.suardi@gmail.com>
To: "Linux Kernel" <linux-kernel@vger.kernel.org>
Subject: 2.6.18-git21, possible recursive locking in kseriod ends up in DWARF2 unwinder stuck
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Non-fatal (box is still alive and apparently well) on boot,
 FC5-uptodate on a Dell Latitude C640. From the dmesg ring:

[    8.680000] =============================================
[    8.680000] [ INFO: possible recursive locking detected ]
[    8.680000] 2.6.18-git21 #1
[    8.680000] ---------------------------------------------
[    8.680000] kseriod/163 is trying to acquire lock:
[    8.680000]  (&ps2dev->cmd_mutex/1){--..}, at: [<c03198c3>]
ps2_command+0x89/0x358
[    8.680000]
[    8.680000] but task is already holding lock:
[    8.680000]  (&ps2dev->cmd_mutex/1){--..}, at: [<c03198c3>]
ps2_command+0x89/0x358
[    8.680000]
[    8.680000] other info that might help us debug this:
[    8.680000] 4 locks held by kseriod/163:
[    8.680000]  #0:  (serio_mutex){--..}, at: [<c0317a5f>]
serio_thread+0x11/0x2ca
[    8.680000]  #1:  (&serio->drv_mutex){--..}, at: [<c0316f2c>]
serio_connect_driver+0x17/0x32
[    8.680000]  #2:  (psmouse_mutex){--..}, at: [<c0320a90>]
psmouse_connect+0x11/0x24a
[    8.680000]  #3:  (&ps2dev->cmd_mutex/1){--..}, at: [<c03198c3>]
ps2_command+0x89/0x358
[    8.680000]
[    8.680000] stack backtrace:
[    8.680000]  [<c010339c>] show_trace_log_lvl+0x24/0x39
[    8.680000]  [<c0103b54>] dump_stack+0x24/0x28
[    8.680000]  [<c0129c8f>] __lock_acquire+0x128/0xa1c
[    8.680000]  [<c012a897>] lock_acquire+0x6a/0x84
[    8.680000]  [<c03d14f5>] mutex_lock_nested+0xd8/0x25b
[    8.680000]  [<c03198c3>] ps2_command+0x89/0x358
[    8.680000]  [<c031fed9>] psmouse_sliced_command+0x2c/0x74
[    8.680000]  [<c0323be0>] synaptics_pt_write+0x2a/0x5a
[    8.680000]  [<c031978e>] ps2_sendbyte+0x51/0xfd
[    8.680000]  [<c031994f>] ps2_command+0x115/0x358
[    8.680000]  [<c031fa59>] psmouse_probe+0x24/0x7d
[    8.680000]  [<c0320b8d>] psmouse_connect+0x10e/0x24a
[    8.680000]  [<c0316f36>] serio_connect_driver+0x21/0x32
[    8.680000]  [<c02e0615>] really_probe+0x3c/0xc3
[    8.680000]  [<c02dfaea>] bus_for_each_drv+0x52/0x84
[    8.680000]  [<c02e07a9>] device_attach+0x5e/0x72
[    8.680000]  [<c02dfa6c>] bus_attach_device+0x24/0x50
[    8.680000]  [<c02ded5c>] device_add+0x37d/0x4bf
[    8.680000]  [<c0317b29>] serio_thread+0xdb/0x2ca
[    8.680000]  [<c0123d19>] kthread+0xc5/0xf4
[    8.680000]  [<c0102edb>] kernel_thread_helper+0x7/0x10
[    8.680000] DWARF2 unwinder stuck at kernel_thread_helper+0x7/0x10
[    8.680000]
[    8.680000] Leftover inexact backtrace:
[    8.680000]
[    8.680000]  =======================


--alessandro

"Well a man has two reasons for things that he does
  the first one is pride and the second one is love
  all understandings must come by this way"

     (Husker Du, 'She Floated Away')

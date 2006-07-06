Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030325AbWGFReS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030325AbWGFReS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 13:34:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030336AbWGFReS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 13:34:18 -0400
Received: from mx1.redhat.com ([66.187.233.31]:42651 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030325AbWGFReR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 13:34:17 -0400
Date: Thu, 6 Jul 2006 13:34:11 -0400
From: Dave Jones <davej@redhat.com>
To: arjan@infradead.org
Cc: mingo@redhat.com, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: lockdep input layer warnings.
Message-ID: <20060706173411.GA2538@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, arjan@infradead.org,
	mingo@redhat.com, Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One of our Fedora-devel users picked up on this this morning
in an 18rc1 based kernel.

		Dave


 Synaptics Touchpad, model: 1, fw: 5.9, id: 0x2c6ab1, caps: 0x884793/0x0
 serio: Synaptics pass-through port at isa0060/serio1/input0
 input: SynPS/2 Synaptics TouchPad as /class/input/input1
 PM: Adding info for serio:serio2
 
 =============================================
 [ INFO: possible recursive locking detected ]
 ---------------------------------------------
 kseriod/111 is trying to acquire lock:
  (&ps2dev->cmd_mutex/1){--..}, at: [<c05937fd>] ps2_command+0x6a/0x2bd
 
 but task is already holding lock:
  (&ps2dev->cmd_mutex/1){--..}, at: [<c05937fd>] ps2_command+0x6a/0x2bd
 
 other info that might help us debug this:
 4 locks held by kseriod/111:
  #0:  (serio_mutex){--..}, at: [<c060d6bb>] mutex_lock+0x21/0x24
  #1:  (&serio->drv_mutex){--..}, at: [<c060d6bb>] mutex_lock+0x21/0x24
  #2:  (psmouse_mutex){--..}, at: [<c060d6bb>] mutex_lock+0x21/0x24
  #3:  (&ps2dev->cmd_mutex/1){--..}, at: [<c05937fd>] ps2_command+0x6a/0x2bd
 
 stack backtrace:
  [<c0405167>] show_trace_log_lvl+0x54/0xfd
  [<c040571e>] show_trace+0xd/0x10
  [<c040583d>] dump_stack+0x19/0x1b
  [<c043bdb2>] __lock_acquire+0x76a/0x98d
  [<c043c546>] lock_acquire+0x4b/0x6d
  [<c060d793>] mutex_lock_nested+0xd5/0x251
  [<c05937fd>] ps2_command+0x6a/0x2bd
  [<c0598f41>] psmouse_sliced_command+0x1c/0x5a
  [<c059c45a>] synaptics_pt_write+0x1e/0x44
  [<c05936fb>] ps2_sendbyte+0x3e/0xd6
  [<c0593879>] ps2_command+0xe6/0x2bd
  [<c0598b3e>] psmouse_probe+0x1d/0x68
  [<c0599ad0>] psmouse_connect+0xe8/0x20f
  [<c05910d9>] serio_connect_driver+0x1e/0x2e
  [<c05910ff>] serio_driver_probe+0x16/0x18
  [<c0550076>] driver_probe_device+0x45/0x92
  [<c05500cb>] __device_attach+0x8/0xa
  [<c054fa0c>] bus_for_each_drv+0x3a/0x65
  [<c0550126>] device_attach+0x59/0x6e
  [<c054f74a>] bus_attach_device+0x16/0x2b
  [<c054eb03>] device_add+0x1f4/0x307
  [<c0591b9d>] serio_thread+0xfd/0x27c
  [<c04365dc>] kthread+0xc3/0xef
  [<c0402005>] kernel_thread_helper+0x5/0xb

-- 
http://www.codemonkey.org.uk

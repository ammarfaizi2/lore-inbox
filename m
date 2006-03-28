Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750869AbWC1PdZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750869AbWC1PdZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 10:33:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751078AbWC1PdZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 10:33:25 -0500
Received: from delta.securenet-server.net ([72.9.248.26]:33453 "EHLO
	delta.securenet-server.net") by vger.kernel.org with ESMTP
	id S1750869AbWC1PdZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 10:33:25 -0500
Subject: realtime-preempt 2.6.16-rt7-10 bug?
From: "Shayne O'Connor" <machine@machinehasnoagenda.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Machine Has No Agenda
Date: Wed, 29 Mar 2006 02:33:14 +1100
Message-Id: <1143559994.2959.5.camel@machine>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 (2.4.2.1-1.1.fc4.nr) 
Content-Transfer-Encoding: 7bit
X-PopBeforeSMTPSenders: forums+machinehasnoagenda.com,machine+machinehasnoagenda.com
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - delta.securenet-server.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - machinehasnoagenda.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i've compiled the 2.6.16 kernel with the realtime-preempt patches, but
have run into some problems while using Ardour for realtime audio.
Ardour crashes whenever i stop recording, and after running dmesg i'm
suspecting a bug in the realtime patch (i've tried rt7 and rt10, both
have the same problem):

ardour:2843 userspace BUG: scheduling in user-atomic context!
 [<c03731d8>] schedule+0x108/0x130 (8)
 [<c037320e>] io_schedule+0xe/0x20 (36)
 [<c016518b>] sync_buffer+0x3b/0x50 (8)
 [<c0373795>] __wait_on_bit+0x45/0x70 (12)
 [<c0165150>] sync_buffer+0x0/0x50 (8)
 [<c0165150>] sync_buffer+0x0/0x50 (12)
 [<c037383d>] out_of_line_wait_on_bit+0x7d/0x90 (8)
 [<c012eaf0>] wake_bit_function+0x0/0x60 (24)
 [<c016804d>] __bread+0x8d/0xc0 (24)
 [<c01d6c56>] ext3_free_branches+0x96/0x250 (20)
 [<c01d936a>] ext3_truncate+0x97a/0xa20 (60)
 [<c011556c>] __wake_up+0x3c/0x70 (20)
 [<c01e7d79>] journal_start+0x109/0x140 (64)
 [<c0135ef7>] rt_up+0x27/0x40 (20)
 [<c01d60d4>] start_transaction+0x24/0x60 (24)
 [<c01d9506>] ext3_delete_inode+0xf6/0x130 (24)
 [<c01d9410>] ext3_delete_inode+0x0/0x130 (16)
 [<c017ea69>] generic_delete_inode+0x69/0x110 (8)
 [<c0174586>] do_unlinkat+0x116/0x140 (24)
 [<c0163972>] sys_write+0x72/0x80 (56)
 [<c0102eff>] sysenter_past_esp+0x54/0x75 (40)


please CC any comments or requests for more info to me ...

thanx

shayne


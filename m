Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265016AbUELMSj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265016AbUELMSj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 08:18:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265008AbUELMSj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 08:18:39 -0400
Received: from stingr.net ([212.193.32.15]:58253 "EHLO stingr.net")
	by vger.kernel.org with ESMTP id S265034AbUELMSh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 08:18:37 -0400
Date: Wed, 12 May 2004 16:18:35 +0400
From: Paul P Komkoff Jr <i@stingr.net>
To: Jan Kara <jack@ucw.cz>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: might_sleep in quota code path as of 2.6.6-rc2, may be fixed already
Message-ID: <20040512121835.GP13255@stingr.net>
Mail-Followup-To: Jan Kara <jack@ucw.cz>,
	Andrew Morton <akpm@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
User-Agent: Agent Darien Fawkes
X-Mailer: Intel Ultra ATA Storage Driver
X-RealName: Stingray Greatest Jr
Organization: Department of Fish & Wildlife
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Have you seen that?

May 12 16:01:14 ns Debug: sleeping function called from invalid context at include/asm/semaphore.h:119
May 12 16:01:14 ns in_atomic():1, irqs_disabled():0
May 12 16:01:14 ns Call Trace:
May 12 16:01:14 ns [<c01193e8>] __might_sleep+0xa5/0xaf
May 12 16:01:14 ns [<c0176a3a>] dquot_release+0x32/0xb0
May 12 16:01:14 ns [<c0176fad>] dqput+0x126/0x181
May 12 16:01:14 ns [<c017747c>] remove_inode_dquot_ref+0xae/0xb8
May 12 16:01:14 ns [<c016568e>] remove_dquot_ref+0x6a/0x157
May 12 16:01:14 ns [<c0177506>] drop_dquot_ref+0x4b/0x6b
May 12 16:01:14 ns [<c0178470>] vfs_quota_off+0x85/0x116
May 12 16:01:14 ns [<c017a551>] do_quotactl+0x131/0x34a
May 12 16:01:14 ns [<c0154f65>] bdev_set+0x0/0xc
May 12 16:01:14 ns [<c0154f55>] bdev_test+0x0/0x10
May 12 16:01:14 ns [<c016221d>] dput+0x75/0x211
May 12 16:01:14 ns [<c0159dca>] path_release+0xd/0x2b
May 12 16:01:14 ns [<c0155b6d>] lookup_bdev+0x6c/0x7b
May 12 16:01:14 ns [<c017a823>] sys_quotactl+0xb9/0xd2
May 12 16:01:14 ns [<c0105bad>] sysenter_past_esp+0x52/0x71

Only once, in quotacheck -a after umount ; e2fsck -fD ; mount

-- 
Paul P 'Stingray' Komkoff Jr // http://stingr.net/key <- my pgp key
 This message represents the official view of the voices in my head

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261273AbVCFAOo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261273AbVCFAOo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 19:14:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261274AbVCFALG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 19:11:06 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:11017 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S261242AbVCFAHL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 19:07:11 -0500
To: linux-kernel@vger.kernel.org
Subject: [PATCH] FAT: Support synchronous updates
References: <87ll92rl6a.fsf@devron.myhome.or.jp>
	<87hdjqrl44.fsf@devron.myhome.or.jp>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sun, 06 Mar 2005 09:07:01 +0900
In-Reply-To: <87hdjqrl44.fsf@devron.myhome.or.jp> (OGAWA Hirofumi's message
 of "Sun, 06 Mar 2005 03:41:31 +0900")
Message-ID: <87br9x8wnu.fsf_-_@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[It seems that my first e-mail was lost, so this is re-post. If you
received duplicated email, sorry.]

Hi,

These patches adds the `-o sync' and `-o dirsync' supports to fatfs.
If user specified that option, the fatfs does traditional ordered
updates by using synchronous writes.  If compared to before, these
patches will show a improvement of robustness I think.

`-o sync'    - writes all buffers out before returning from syscall.
`-o dirsync' - writes the directory's metadata, and unreferencing
               operations of data block.

    remaining to be done
         fat_generic_ioctl(), fat_notify_change(),
	 ATTR_ARCH of fat_xxx_write[v],
	 and probably, filling hole in cont_prepare_write(),

NOTE: Since fatfs doesn't have link-count, unfortunately ->rename() is
not safe order at all.  It may make the shared blocks, but user
shouldn't lose the data by ->rename().

Please apply.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

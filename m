Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751056AbVIQKrr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751056AbVIQKrr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 06:47:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751057AbVIQKrq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 06:47:46 -0400
Received: from webmail.woosh.co.nz ([202.74.207.2]:13068 "EHLO
	mail2.woosh.co.nz") by vger.kernel.org with ESMTP id S1751055AbVIQKrq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 06:47:46 -0400
Date: Sat, 17 Sep 2005 22:44:41 +1200 (NZST)
From: Bart Oldeman <bartoldeman@users.sourceforge.net>
X-X-Sender: enbeo@enm-bo-lt.localnet
To: mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: [patch] bug fix: tss->io_bitmap_owner is never set to non-NULL.
Message-ID: <Pine.LNX.4.62.0509172239570.3423@enm-bo-lt.localnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

it appears that there is exists a field io_bitmap_owner in the TSS that is 
only checked, but never set to anything else but NULL.

The below patch corrects this.

Signed-off-by: Bart Oldeman <bartoldeman@users.sourceforge.net>

--- arch/i386/kernel/traps.c.org	2005-09-17 17:20:19.000000000 +1200
+++ arch/i386/kernel/traps.c	2005-09-17 22:33:00.000000000 +1200
@@ -489,6 +489,7 @@ fastcall void __kprobes do_general_prote
  				tss->io_bitmap_max - thread->io_bitmap_max);
  		tss->io_bitmap_max = thread->io_bitmap_max;
  		tss->io_bitmap_base = IO_BITMAP_OFFSET;
+		tss->io_bitmap_owner = thread;
  		put_cpu();
  		return;
  	}

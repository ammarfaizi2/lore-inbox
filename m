Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312917AbSDGCJY>; Sat, 6 Apr 2002 21:09:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312918AbSDGCJX>; Sat, 6 Apr 2002 21:09:23 -0500
Received: from [209.143.110.29] ([209.143.110.29]:17633 "HELO
	mail.the-rileys.net") by vger.kernel.org with SMTP
	id <S312917AbSDGCJX>; Sat, 6 Apr 2002 21:09:23 -0500
Date: 7 Apr 2002 02:11:22 -0000
Message-ID: <20020407021122.3009.qmail@mail.the-rileys.net>
From: oscar@mail.the-rileys.net
To: linux-kernel@vger.kernel.org
Subject: Keyboard trouble with 2.5.8-pre2: missed interrupt?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been having keyboard troubles on my Athlon box with recent kernels, and I've traced it to a problem with interrupts.  In kernel 2.4.x, the function handle_kbd_event() does not find a full input buffer when it is first called (status = 0x14).  However, when the keyboard controller interrupt calls it, it (logically, since it was from the interrupt) finds 0x15 in the status register[D.  Howerver, in 2.5.8-pre2 (and presumably others), the keyboard interrupt is only caught once, before the first send_data function is called.  I can't offer any reasons as to why that may be, since I don't see much change related to the keyboard interrupt in drivers/char/pc_keyb.c, but that is what I've traced it to.  If you have any help, please CC me directly, since I'm no longer on the list.

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266574AbRHFDrB>; Sun, 5 Aug 2001 23:47:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266580AbRHFDqv>; Sun, 5 Aug 2001 23:46:51 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:2311 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S266574AbRHFDqe>;
	Sun, 5 Aug 2001 23:46:34 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
Subject: drivers/ieee1394 duplicate symbol, 2.4.8-pre4
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 06 Aug 2001 13:46:40 +1000
Message-ID: <32414.997069600@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/ieee1394/raw1394.c:spinlock_t host_info_lock = SPIN_LOCK_UNLOCKED;
drivers/ieee1394/nodemgr.c:spinlock_t host_info_lock = SPIN_LOCK_UNLOCKED;

when both raw1394 and nodemgr are linked into vmlinux, it gets

drivers/ieee1394/raw1394.o(.data+0x8): multiple definition of `host_info_lock'
drivers/ieee1394/ieee1394.o(.data+0x8c): first defined here

Either host_info_lock should be static or it should be defined as
extern in one source and referenced in the others.


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130031AbRBKUKL>; Sun, 11 Feb 2001 15:10:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129617AbRBKUKB>; Sun, 11 Feb 2001 15:10:01 -0500
Received: from tazenda.demon.co.uk ([158.152.220.239]:54278 "EHLO
	tazenda.demon.co.uk") by vger.kernel.org with ESMTP
	id <S129231AbRBKUJr>; Sun, 11 Feb 2001 15:09:47 -0500
X-Mailer: exmh version 2.1.1 10/15/1999 (debian)
To: linux-kernel@vger.kernel.org
Subject: 2.4.1, slhc as a module
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 11 Feb 2001 20:02:16 +0000
From: Philip Blundell <philb@gnu.org>
Message-Id: <E14S2hM-0003k5-00@kings-cross.london.uk.eu.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The makefile in drivers/net goes like this:

obj-$(CONFIG_SLIP) += slip.o
ifeq ($(CONFIG_SLIP),y)
  obj-$(CONFIG_SLIP_COMPRESSED) += slhc.o
else
  ifeq ($(CONFIG_SLIP),m)
    obj-$(CONFIG_SLIP_COMPRESSED) += slhc.o
  endif
endif

CONFIG_SLIP_COMPRESSED is a `bool' value.  The way the makefile is written, 
selecting compression will always build slhc.o into the kernel, even if SLIP 
is a module.  This doesn't seem like the way it ought to work.

p.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

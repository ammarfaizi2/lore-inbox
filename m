Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266264AbUBLLBk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 06:01:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266270AbUBLLBk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 06:01:40 -0500
Received: from 216-239-45-4.google.com ([216.239.45.4]:1575 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id S266264AbUBLLBj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 06:01:39 -0500
Message-ID: <402B5D09.6030909@google.com>
Date: Thu, 12 Feb 2004 03:01:29 -0800
From: Paul Menage <menage@google.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030701
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] Typo in include/asm-x86_64/pci-direct.h ?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andi,

I noticed that the return value of read_pci_config_16() was a u8, which looks a bit suspicious. The 
only users of it are in kernel/aperture.c, and appear to work despite only getting 8 bits back, due 
to lucky circumstances. Patch applies to both 2.4 and 2.6.

Paul

--- linux/include/asm-x86_64/pci-direct.h.old	2004-02-12 02:37:53 -0800
+++ linux/include/asm-x86_64/pci-direct.h	2004-02-12 02:37:15 -0800
@@ -28,7 +28,7 @@
  	return v;
  }

-static inline u8 read_pci_config_16(u8 bus, u8 slot, u8 func, u8 offset)
+static inline u16 read_pci_config_16(u8 bus, u8 slot, u8 func, u8 offset)
  {
  	u16 v;
  	outl(0x80000000 | (bus<<16) | (slot<<11) | (func<<8) | offset, 0xcf8);



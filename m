Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267244AbTBQRlQ>; Mon, 17 Feb 2003 12:41:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267246AbTBQRlQ>; Mon, 17 Feb 2003 12:41:16 -0500
Received: from kim.it.uu.se ([130.238.12.178]:64905 "EHLO kim.it.uu.se")
	by vger.kernel.org with ESMTP id <S267244AbTBQRlP>;
	Mon, 17 Feb 2003 12:41:15 -0500
Date: Mon, 17 Feb 2003 18:51:12 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200302171751.SAA19069@kim.it.uu.se>
To: ak@suse.de
Subject: 2.5.61: x86_64 num_online_cpus() buglet?
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi,

Kernel 2.5.61's include/asm-x86_64/smp.h contains:

extern unsigned long cpu_online_map;
...
extern inline unsigned int num_online_cpus(void)
{ 
	return hweight32(cpu_online_map);
} 

and similarly for cpu_callout_map.

hweight32() truncates a 64-bit operand to 32-bits, so either
- the maps should be int rather than long, or
- x86_64 needs to define and use a new hweight64(), or
- CONFIG_NR_CPUS must not exceed 32 on x86_64.

Comments?

/Mikael

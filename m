Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317387AbSHOUKY>; Thu, 15 Aug 2002 16:10:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317415AbSHOUJW>; Thu, 15 Aug 2002 16:09:22 -0400
Received: from kim.it.uu.se ([130.238.12.178]:9627 "EHLO kim.it.uu.se")
	by vger.kernel.org with ESMTP id <S317404AbSHOUJR>;
	Thu, 15 Aug 2002 16:09:17 -0400
From: Mikael Pettersson <mikpe@csd.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15708.2901.701484.171663@kim.it.uu.se>
Date: Thu, 15 Aug 2002 22:13:09 +0200
To: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Cc: martin@dalecki.de, linux-kernel@vger.kernel.org
Subject: Re: 2.5.31 boot failure on pdc20267
In-Reply-To: <217C4D61227@vcnet.vc.cvut.cz>
References: <217C4D61227@vcnet.vc.cvut.cz>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Petr Vandrovec writes:
 > On 15 Aug 02 at 17:15, Mikael Pettersson wrote:
 > > Booting 2.5.31 (non-bk) on hde5, a UDMA(66) Quantum Fireball
 > > on a PDC20267 add-on card, resulted in a complete hang as init
 > > came to its "mount -n -o remount,rw /" point. No visible messages
 > > or anything in the log.
 > 
 > Known bug. Apply IDE113 (Aug 06, 11:02 CEST, from Martin), or just open 
 > drivers/ide/pcidma.c in your favorite text editor, look for (first) 
 > #ifdef CONFIG_BLK_DEV_TRM290, and replace whole ifdef block with 
 > '*--table |= cpu_to_le32(0x80000000);'

Tested. First time 2.5.31 + the patch booted it seemed to work, but hung
later on while compiling a 2.4.19 kernel. No messages of any kind. The
hang _seemed_ to coincide with the console screen blanker kicking in.
Second boot went ok and I made sure the screen blanker wouldn't kick
in while doing the compile, and it didn't hang.

This box is the only one so far I've seen this problem on, my other
Intel chipset boxes actually seem to work fairly well with 2.5.31.

/Mikael

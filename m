Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317117AbSHOPcB>; Thu, 15 Aug 2002 11:32:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317141AbSHOPcB>; Thu, 15 Aug 2002 11:32:01 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:44043 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S317117AbSHOPcA>;
	Thu, 15 Aug 2002 11:32:00 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Mikael Pettersson <mikpe@csd.uu.se>
Date: Thu, 15 Aug 2002 17:34:20 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: 2.5.31 boot failure on pdc20267
CC: martin@dalecki.de, linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.50
Message-ID: <217C4D61227@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 15 Aug 02 at 17:15, Mikael Pettersson wrote:
> Booting 2.5.31 (non-bk) on hde5, a UDMA(66) Quantum Fireball
> on a PDC20267 add-on card, resulted in a complete hang as init
> came to its "mount -n -o remount,rw /" point. No visible messages
> or anything in the log.

Known bug. Apply IDE113 (Aug 06, 11:02 CEST, from Martin), or just open 
drivers/ide/pcidma.c in your favorite text editor, look for (first) 
#ifdef CONFIG_BLK_DEV_TRM290, and replace whole ifdef block with 
'*--table |= cpu_to_le32(0x80000000);'

Test in the ifdef is exactly opposite, and #ifdef is also wrong.
                                            Petr Vandrovec
                                            vandrove@vc.cvut.cz
                                            

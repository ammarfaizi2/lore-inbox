Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129723AbQKLN4y>; Sun, 12 Nov 2000 08:56:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130667AbQKLN4e>; Sun, 12 Nov 2000 08:56:34 -0500
Received: from gemini.yars.free.net ([193.233.48.66]:60870 "EHLO
	gemini.yars.free.net") by vger.kernel.org with ESMTP
	id <S129723AbQKLN40>; Sun, 12 Nov 2000 08:56:26 -0500
From: "Alexander V. Lukyanov" <lav@long.yar.ru>
Date: Sun, 12 Nov 2000 16:56:09 +0300
To: linux-kernel@vger.kernel.org
Subject: sound problems caused by masking irq for too long
Message-ID: <20001112165609.A1006@long.yar.ru>
Reply-To: lav@yars.free.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

In some cases sound gets interrupted for a moment, this happens in two
occasions. When unmaskirq flag is off on ide cdrom and it is accessed,
and when tdfxfb console (800x600) flashes (tput flash, or `set bell-style
visible' in .inputrc).

It seems the problem is caused by masking irq for too long, and then
the sound dma buffer underruns. This is fixed by unmasking irq for ide
cdrom by `hdparm -u1 /dev/cdrom', and by changing spin_(un)lock_irq
in console.c to spin_(un)lock_bh.

This was observed on 2.4.0-pre10, the problem with ide also exists on
2.2.17, the console.c in 2.2.17 only disables CONSOLE_BH.

The audio card is old awe32 (isa), sound driver is modular.

-- 
   Alexander.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

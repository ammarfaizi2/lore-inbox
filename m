Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317887AbSGaKDR>; Wed, 31 Jul 2002 06:03:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317889AbSGaKDR>; Wed, 31 Jul 2002 06:03:17 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:26377 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S317887AbSGaKDR>;
	Wed, 31 Jul 2002 06:03:17 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: akpm@zip.com.au
Date: Wed, 31 Jul 2002 12:06:31 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: BUG at rmap.c:212
CC: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.50
Message-ID: <AA4A1044BB@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
  yesterday I told (in IDE thread) that BUG at rmap.c:212 is probably
already fixed by changeset 520. Unfortunately, it is not, I got it again
with BK tree. It happened again when 'ntpd' called exit() upon receiving
sigterm.

  Stack trace:
  
  page_remove_rmap
  zap_pte_range
  zap_pmd_range
  unmap_page_range
  exit_mmap
  mmput
  do_exit
  sys_exit
  syscall_call

If it is not known bug, I'll rebuild kernel with DEBUG_RMAP. Unfortunately
it looks like that machine must have uptime > 12hrs to trigger this. Probably
updatedb or some other task must be run to try to swap ntpd out?
                                                Best regards,
                                                    Petr Vandrovec
                                                    vandrove@vc.cvut.cz
                                                    

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262653AbRFGOhF>; Thu, 7 Jun 2001 10:37:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262658AbRFGOgz>; Thu, 7 Jun 2001 10:36:55 -0400
Received: from hera.cwi.nl ([192.16.191.8]:58295 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S262653AbRFGOgn>;
	Thu, 7 Jun 2001 10:36:43 -0400
Date: Thu, 7 Jun 2001 16:36:40 +0200 (MET DST)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200106071436.QAA224593.aeb@vlet.cwi.nl>
To: linux-kernel@vger.kernel.org, olh@suse.de
Subject: Re: 2.4.5-ac9 console NULL pointer pointer dereference
Cc: alan@lxorguk.ukuu.org.uk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From: Olaf Hering <olh@suse.de>

    this happend with 2.4.5-ac9 with serial console on i386.

    Unable to handle kernel NULL pointer dereference0x02f8 (irq = 3) at virtual address 00000004
    Oops: 0000
    >>EIP; c01967c7 <poke_blanked_console+1b/5c>   <=====

Sounds like this should help:

--- console.c~  Fri Feb  9 20:30:22 2001
+++ console.c   Thu Jun  7 16:28:59 2001
@@ -2684,7 +2684,7 @@
 void poke_blanked_console(void)
 {
        del_timer(&console_timer);      /* Can't use _sync here: called from tasklet */
-       if (vt_cons[fg_console]->vc_mode == KD_GRAPHICS)
+       if (!vt_cons[fg_console] || vt_cons[fg_console]->vc_mode == KD_GRAPHICS)
                return;
        if (console_blanked) {
                console_timer.function = unblank_screen_t;

Andries

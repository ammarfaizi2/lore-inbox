Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278792AbRJ0OJ0>; Sat, 27 Oct 2001 10:09:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279820AbRJ0OJH>; Sat, 27 Oct 2001 10:09:07 -0400
Received: from ws-han1.win-ip.dfn.de ([193.174.75.150]:41554 "EHLO
	ws-han1.win-ip.dfn.de") by vger.kernel.org with ESMTP
	id <S278792AbRJ0OI7>; Sat, 27 Oct 2001 10:08:59 -0400
Date: Sat, 27 Oct 2001 16:09:51 +0100
Message-ID: <vines.sxdD+zsgqvA@SZKOM.BFS.DE>
X-Priority: 3 (Normal)
To: <linux-kernel@vger.kernel.org>
From: <WHarms@bfs.de> (Walter Harms)
Reply-To: <WHarms@bfs.de>
Subject: fix for broken pc_keyb.c (late 2.2.x all 2.4.x kernel)
X-Incognito-SN: 25185
X-Incognito-Version: 5.1.0.84
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



hi list,
there is a logical problem with pc_keyb.c. if setting the leds does not work the keyboard will no longer exists.
attention:  
pckbd_leds() is also know as kbd_leds() what is used quit often !

This is a quick fix ! (read: no real solution !)

some comments from my side:

1. the kbd_exists stuff is not realy documented. I should be removed or explaind properly.

2. the next better way is to check for the returncode from
send_data() and send kbd_exists accordingly.

3. kdb_rate works the same way but does not set kbd_exists


	walter











*** pc_keyb.c   Sat Oct 27 15:57:20 2001
--- pc_keyb.c.broken    Sat Oct 27 15:46:45 2001
***************
*** 525,543 ****
        return 0;
  }
  
- 
- /* someone added kbd_exists i dont know when or why    */
- /* but there a few routines that ever check kdb_exists */
- /* if somebody understands it *please* document        */ 
- /* The old code liked to shut down my keyboad          */
- /* the routine is also known as kbd_leds()           */ 
- /* walter.harms@informatik.uni-oldenburg.de            */
- 
  void pckbd_leds(unsigned char leds)
  {
        if (kbd_exists && (!send_data(KBD_CMD_SET_LEDS) || !send_data(leds))) {
                send_data(KBD_CMD_ENABLE);      /* re-enable kbd if any errors */
!               kbd_exists = 1;
        }
  }
  
--- 525,535 ----
        return 0;
  }
  
  void pckbd_leds(unsigned char leds)
  {
        if (kbd_exists && (!send_data(KBD_CMD_SET_LEDS) || !send_data(leds))) {
                send_data(KBD_CMD_ENABLE);      /* re-enable kbd if any errors */
!               kbd_exists = 0;
        }
  }



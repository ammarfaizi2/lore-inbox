Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278833AbRJVOfj>; Mon, 22 Oct 2001 10:35:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278835AbRJVOfa>; Mon, 22 Oct 2001 10:35:30 -0400
Received: from ws-han1.win-ip.dfn.de ([193.174.75.150]:34024 "EHLO
	ws-han1.win-ip.dfn.de") by vger.kernel.org with ESMTP
	id <S278833AbRJVOfQ>; Mon, 22 Oct 2001 10:35:16 -0400
Date: Mon, 22 Oct 2001 16:36:25 +0100
Message-ID: <vines.sxdD+tn1pvA@SZKOM.BFS.DE>
X-Priority: 3 (Normal)
To: <linux-kernel@vger.kernel.org>
From: <WHarms@bfs.de> (Walter Harms)
Reply-To: <WHarms@bfs.de>
Subject: possible bug in 2.4.x pc_keyb.c
X-Incognito-SN: 25185
X-Incognito-Version: 5.1.0.84
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi list,

keyboard disappears with 2.4.x kernel on notebook (compaq amarda)

After some time the keyboard from my amarda notebook does not respond to anything. The only hint is that 
"keyboard: Timeout - AT keyboard not present?" appears
quit often in the syslog before the kbd stops working.

Comparing the 2.2.x code (no problems) with the 2.4.x code i found pckbd_leds() as prime suspect.
as you can see it sets kbd_exists = 0 (FALSE) after sending an ENABLE. I am not sure if this is my probleme (read: no time to check if this fix works) but i guess its wrong. 

Note: 
1. the error isnt easy reproduceable but appears only with the 2.4.x 
2. send_data returns 1 for  acknowledge  else 0 
3. kann sombody please document kbd_exists ?

	walter



org:

void pckbd_leds(unsigned char leds)
{
        if (kbd_exists && (!send_data(KBD_CMD_SET_LEDS) || !send_data(leds))) {
                send_data(KBD_CMD_ENABLE);      /* re-enable kbd if any errors *
/
                kbd_exists = 0;
        }
}


my idea:

 if () {
	   if (send_data(KBD_CMD_ENABLE)){
        printk(KERN_WARNING "Keyboard off-line ?!\n");
		kbd_exists = FALSE;
		}
	}

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264594AbRFPIe2>; Sat, 16 Jun 2001 04:34:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264595AbRFPIeJ>; Sat, 16 Jun 2001 04:34:09 -0400
Received: from mail211.mail.bellsouth.net ([205.152.58.151]:10150 "EHLO
	imf11bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S264594AbRFPIeE>; Sat, 16 Jun 2001 04:34:04 -0400
Date: Sat, 16 Jun 2001 04:34:29 -0400 (EDT)
From: volodya@mindspring.com
Reply-To: volodya@mindspring.com
To: David Ashley <dash@xdr.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: psaux mouse driver + inland pro optical 100 mouse
In-Reply-To: <200106160325.UAA00890@dave.xdr.com>
Message-ID: <Pine.LNX.4.20.0106160432040.853-100000@node2.localnet.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Try commenting out the AUX_RECONNECT block on line 406 in pc_keyb.c

#ifdef CONFIG_PS2_KEYBOARD_SWITCH_COMPATIBILITY_MODE	
	else if(scancode == AUX_RECONNECT){
		queue->head = queue->tail = 0;  /* Flush input queue */
		__aux_write_ack(AUX_ENABLE_DEV);  /* ping the mouse :) */
		return;
	}
#endif

and let me know what happens..  

                     Vladimir Dergachev
PS please CC me as I read this list only occasionally (too much traffic).

On Fri, 15 Jun 2001, David Ashley wrote:

> Under linux 2.4.1 if I move the mouse slow enough it doesn't register at all
> in Xwindows. If I unplug the ps2 mouse and plug it back in, it works
> perfectly, no matter how slowly I move it the movement is registered. It
> is as if the linux kernel is imposing a threshold on the movement.
> 
> Under windows it works fine. The problem is in linux.
> 
> I've tried modifying pc_keyb.c code by sending an F6 byte to set defaults,
> using the aux_write_ack function in open_aux(), but that doesn't have any
> effect. Does anyone have a clue what the driver is doing to reduce the
> quality of the mouse? I'm not sure it is limited to this particular mouse,
> it is just the one I just bought at Fry's for $10.
> 
> I'm running an athlon 1 gig, /proc/version is
> Linux version 2.4.1 (root@dave) (gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)) #17 Fri Jun 15 20:15:45 PDT 2001
> 
> Thanks!
> -Dave
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 



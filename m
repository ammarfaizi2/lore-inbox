Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129348AbRADWmg>; Thu, 4 Jan 2001 17:42:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131552AbRADWm0>; Thu, 4 Jan 2001 17:42:26 -0500
Received: from host156.207-175-42.redhat.com ([207.175.42.156]:32520 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S129348AbRADWmN>; Thu, 4 Jan 2001 17:42:13 -0500
Date: Thu, 4 Jan 2001 17:42:12 -0500
From: Bill Nottingham <notting@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: alan@redhat.com
Subject: Re: prerelease-ac6 compile problem in serial.c
Message-ID: <20010104174212.A27418@devserv.devel.redhat.com>
Mail-Followup-To: linux-kernel@vger.kernel.org, alan@redhat.com
In-Reply-To: <Pine.GSO.4.21.0101050022210.9014-100000@madli.ut.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.21.0101050022210.9014-100000@madli.ut.ee>; from mroos@linux.ee on Fri, Jan 05, 2001 at 12:23:48AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Meelis Roos (mroos@linux.ee) said: 
> 2.4.0-prerelease-ac6 doesn't compile serial on x86 with pnp enabled:
> 
> serial.c: In function `probe_serial_pnp':
> serial.c:5187: structure has no member named `device'
> serial.c:5192: structure has no member named `device'

Doh. I swear this did build when I tried it, although I don't see how.

Bill

--- linux/drivers/char/serial.c.foo	Thu Jan  4 17:31:43 2001
+++ linux/drivers/char/serial.c	Thu Jan  4 17:32:38 2001
@@ -5184,12 +5184,12 @@
 	       
 	       for (pnp_board = pnp_devices; pnp_board->vendor; pnp_board++)
 		       if ((dev->vendor == pnp_board->vendor) &&
-			   (dev->device == pnp_board->device))
+			   (dev->device == pnp_board->function))
 			       break;
 
 	       if (pnp_board->vendor) {
 		       board.vendor = pnp_board->vendor;
-		       board.device = pnp_board->device;
+		       board.device = pnp_board->function;
 		       /* Special case that's more efficient to hardcode */
 		       if ((board.vendor == ISAPNP_VENDOR('A', 'K', 'Y') &&
 			    board.device == ISAPNP_DEVICE(0x1021)))
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

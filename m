Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130188AbRCCAoj>; Fri, 2 Mar 2001 19:44:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130196AbRCCAo3>; Fri, 2 Mar 2001 19:44:29 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:44331 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S130188AbRCCAoU>; Fri, 2 Mar 2001 19:44:20 -0500
Date: Sat, 3 Mar 2001 00:44:13 +0000
From: Tim Waugh <twaugh@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] 2.4.3-pre1: parport fix (nAutoFd)
Message-ID: <20010303004413.F4835@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Here is a patch that makes 2.4.x's behaviour more closely match that
of 2.2.x when a nibble mode read goes wrong.  It prevents reading
processes from getting stuck in certain circumstances.

Tim.
*/

2001-03-02  Tim Waugh  <twaugh@redhat.com>

	* drivers/parport/ieee1284_ops.c (parport_ieee1284_read_nibble):
	Reset nAutoFd on timeout.  Matches 2.2.x behaviour.

--- linux/drivers/parport/ieee1284_ops.c.autofd	Sat Mar  3 00:37:23 2001
+++ linux/drivers/parport/ieee1284_ops.c	Sat Mar  3 00:37:23 2001
@@ -189,6 +189,7 @@
 			DPRINTK (KERN_DEBUG
 				 "%s: Nibble timeout at event 9 (%d bytes)\n",
 				 port->name, i/2);
+			parport_frob_control (port, PARPORT_CONTROL_AUTOFD, 0);
 			break;
 		}
 

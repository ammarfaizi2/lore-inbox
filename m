Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264226AbTFPUNM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 16:13:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264231AbTFPUNM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 16:13:12 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:34579 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264226AbTFPUNL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 16:13:11 -0400
Date: Mon, 16 Jun 2003 21:27:00 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Peter Lundkvist <p.lundkvist@telia.com>,
       Jaakko Niemi <liiwi@lonesom.pp.fi>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.71 go boom
Message-ID: <20030616212700.J13312@flint.arm.linux.org.uk>
Mail-Followup-To: Peter Lundkvist <p.lundkvist@telia.com>,
	Jaakko Niemi <liiwi@lonesom.pp.fi>, linux-kernel@vger.kernel.org
References: <87isr7cjra.fsf@jumper.lonesom.pp.fi> <20030615191125.I5417@flint.arm.linux.org.uk> <87el1vcdrz.fsf@jumper.lonesom.pp.fi> <20030615212814.N5417@flint.arm.linux.org.uk> <87he6qc3bb.fsf@jumper.lonesom.pp.fi> <20030616085403.A5969@flint.arm.linux.org.uk> <3EEE173A.8040802@telia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3EEE173A.8040802@telia.com>; from p.lundkvist@telia.com on Mon, Jun 16, 2003 at 09:15:06PM +0200
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 16, 2003 at 09:15:06PM +0200, Peter Lundkvist wrote:
> Tested with the following versions (exactly the same behaviour):
>    2.5.69-bk10
> 
> 2.5.69-bk9 was OK.

Great, this helps a lot.  While I remove the bullet from my foot, could
you test this patch please?

--- linux/drivers/pcmcia/cs.c.old	Mon Jun 16 21:17:45 2003
+++ linux/drivers/pcmcia/cs.c	Mon Jun 16 21:24:23 2003
@@ -817,7 +817,8 @@
 				if ((skt->state & SOCKET_PRESENT) &&
 				     !(status & SS_DETECT))
 					socket_shutdown(skt);
-				if (status & SS_DETECT)
+				if (!(skt->state & SOCKET_PRESENT) &&
+				    status & SS_DETECT)
 					socket_insert(skt);
 			}
 			if (events & SS_BATDEAD)


-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html


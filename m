Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751528AbWGaX7D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751528AbWGaX7D (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 19:59:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751499AbWGaX65
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 19:58:57 -0400
Received: from smtp114.sbc.mail.mud.yahoo.com ([68.142.198.213]:26287 "HELO
	smtp114.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751495AbWGaX6g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 19:58:36 -0400
From: David Brownell <david-b@pacbell.net>
To: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH] OMAP: I2C driver for TI OMAP boards #2
Date: Mon, 31 Jul 2006 16:53:47 -0700
User-Agent: KMail/1.7.1
Cc: Komal Shah <komal_shah802003@yahoo.com>, akpm@osdl.org, gregkh@suse.de,
       i2c@lm-sensors.org, imre.deak@nokia.com, juha.yrjola@solidboot.com,
       linux-kernel@vger.kernel.org, r-woodruff2@ti.com, tony@atomide.com
References: <1154066134.13520.267064606@webmail.messagingengine.com> <200607310733.09125.david-b@pacbell.net> <20060731181327.d54ce1d0.khali@linux-fr.org>
In-Reply-To: <20060731181327.d54ce1d0.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607311653.48240.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 31 July 2006 9:13 am, Jean Delvare wrote:
>	 If you want things to improve, please help by
> reviewing Komal's driver. I think I understand you already commented on
> it, but I'd like you to really review it, and add a formal approval to
> it (e.g. Signed-off-by or Acked-by). Then I'll review it for merge.

The issues noted in the code are still almost all low priority
(non-blocking).

 - The FIXME about choosing the address is very low priority,
   and would affect only multi-master systems.  The fix would
   involve defining a new i2c-specific struct for platform_data,
   updating various boards to use it (e.g. OSK can use 400 MHz),
   and wouldn't change behavior for any board I've ever seen.

 - Likewise with the REVISIT for the bus speed to use.  They'd
   be fixed with the same patch.

 - The REVISIT about maybe a better way to probe is also low
   priority; someone with a board that needs better probing
   could address it at that time.  (Then restest any changes
   on multiple generations of silicion ... which IMO is the
   role the linux-omap tree should play.)

 - The revisit about adap->retries is still up in the air,
   and was a question in my submission from last year.
   How exactly is that supposed to be used?  Right now
   it's neither initialized (except to zero) nor tested.

Re coding style issues, I didn't give it a detailed nitpick
but I did easily notice two things worth fixing:

 - Some lines are more than 80 characters, so they'll wrap
   on standard editor windows.

 - There are a couple instances of hidden whitespace to
   remove:  at end of line, or space-before-tab.

This doesn't include the drivers/Makefile change to push i2c
linkage up near the beginning with other "system" busses,
but that can be a separate patch in any case (assuming that
it's still needed).

Assuming those two coding style things get resolved first,

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

- Dave

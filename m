Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265176AbUELTdM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265176AbUELTdM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 15:33:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265198AbUELTbm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 15:31:42 -0400
Received: from fw.osdl.org ([65.172.181.6]:23180 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265176AbUELT1a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 15:27:30 -0400
Date: Wed, 12 May 2004 12:26:28 -0700
From: Andrew Morton <akpm@osdl.org>
To: Sean Neakums <sneakums@zork.net>
Cc: vojtech@suse.cz, linux-kernel@vger.kernel.org,
       Kim Holviala <kim@holviala.com>
Subject: Re: 2.6.6-mm1
Message-Id: <20040512122628.63b3479c.akpm@osdl.org>
In-Reply-To: <6ufza5yfmn.fsf@zork.zork.net>
References: <20040510024506.1a9023b6.akpm@osdl.org>
	<6ufza5yfmn.fsf@zork.zork.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Neakums <sneakums@zork.net> wrote:
>
> Andrew Morton <akpm@osdl.org> writes:
> 
>  > psmouse-fix-mouse-hotplugging.patch
>  >   psmouse: fix mouse hotplugging
> 
>  This change seems to cause psmouse.proto=bare to no longer work as a
>  way of disabling the passthrough port on my laptop's Synaptics touchpad.

OK, thanks.  I'll drop it.





This patch fixes hotplugging of PS/2 devices on hardware which don't
support hotplugging of PS/2 devices.  In other words, most desktop
machines.


---

 25-akpm/drivers/input/mouse/psmouse-base.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/input/mouse/psmouse-base.c~psmouse-fix-mouse-hotplugging drivers/input/mouse/psmouse-base.c
--- 25/drivers/input/mouse/psmouse-base.c~psmouse-fix-mouse-hotplugging	2004-05-08 13:13:40.636484424 -0700
+++ 25-akpm/drivers/input/mouse/psmouse-base.c	2004-05-08 13:13:40.640483816 -0700
@@ -470,7 +470,7 @@ static int psmouse_probe(struct psmouse 
  * Then we reset and disable the mouse so that it doesn't generate events.
  */
 
-	if (psmouse_command(psmouse, NULL, PSMOUSE_CMD_RESET_DIS))
+	if (psmouse_reset(psmouse))
 		printk(KERN_WARNING "psmouse.c: Failed to reset mouse on %s\n", psmouse->serio->phys);
 
 /*

_


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262649AbTJAWjJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 18:39:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262651AbTJAWjJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 18:39:09 -0400
Received: from gprs150-56.eurotel.cz ([160.218.150.56]:30081 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262649AbTJAWjH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 18:39:07 -0400
Date: Thu, 2 Oct 2003 00:37:52 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@osdl.org>
Subject: [pm] fix oops after saving image
Message-ID: <20031001223751.GA6402@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I was seeing strange oopsen after saving image. They are almost
harmless: anything that happens after writing final signature does not
matter (as long as  it does not write to disk). But that oops makes
testing hard as you have to manually powerdown the machine.

free_page() at this point is unneccessary as machine is going down,
anyway. Please apply,
								Pavel
PS: For a test, I'm running while true; do echo 4 > /proc/acpi/sleep;
sleep 30; done while making kernel. It seems to work so far.

--- tmp/linux/kernel/power/swsusp.c	2003-10-02 00:04:35.000000000 +0200
+++ linux/kernel/power/swsusp.c	2003-10-01 23:56:49.000000000 +0200
@@ -345,7 +348,7 @@
 	printk( "|\n" );
 
 	MDELAY(1000);
-	free_page((unsigned long) buffer);
+	/* Trying to free_page((unsigned long) buffer) here is bad idea, not sure why */
 	return 0;
 }
 
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]

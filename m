Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261245AbTJHHs2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 03:48:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261262AbTJHHs2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 03:48:28 -0400
Received: from TYO201.gate.nec.co.jp ([202.32.8.214]:50079 "EHLO
	TYO201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S261245AbTJHHs0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 03:48:26 -0400
To: linux-kernel@vger.kernel.org
Subject: initcall ordering of driver w/respect to tty_init?
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
From: Miles Bader <miles@lsi.nec.co.jp>
Date: 08 Oct 2003 16:48:17 +0900
Message-ID: <buo65j0f9vi.fsf@mcspd15.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a tty driver, arch/v850/kernel/simcons.c, who's init function is
called via __initcall:

   int __init simcons_tty_init (void)
   {
           struct tty_driver *driver = alloc_tty_driver(1);
   ...
           err = tty_register_driver(driver);
   }
   __initcall (simcons_tty_init);

I'm getting errors because this init function is being called _before_
tty_init, and tty_kobj (which is the `parent' kobj of simcon's kobj) is
apparently not setup correctly yet when the simcons_tty_init calls
tty_register_driver.

Since there seems to be no way of ordering basic initcalls, I can see
why it's happening.  But what's the proper way to avoid this?  Other
tty drivers that call tty_register_driver also seem to get initialized
via initcalls (usually declared with module_init), so maybe this
problem exists for other drivers too.

Thanks,

-Miles
-- 
Come now, if we were really planning to harm you, would we be waiting here, 
 beside the path, in the very darkest part of the forest?

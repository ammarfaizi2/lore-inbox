Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317534AbSGYHNT>; Thu, 25 Jul 2002 03:13:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317544AbSGYHNS>; Thu, 25 Jul 2002 03:13:18 -0400
Received: from pD9E23356.dip.t-dialin.net ([217.226.51.86]:28554 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S317534AbSGYHNS>; Thu, 25 Jul 2002 03:13:18 -0400
Date: Thu, 25 Jul 2002 01:16:20 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Greg KH <greg@kroah.com>
cc: Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: cli-sti-removal.txt fixup
In-Reply-To: <20020725061926.GC13691@kroah.com>
Message-ID: <Pine.LNX.4.44.0207250115120.3347-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 24 Jul 2002, Greg KH wrote:
> > Ah, sorry, I didn't get that from cli-sti-removal.txt.  Actually it
> > looks like cli-sti-removal.txt is a bit wrong, as there is no
> > local_irq_save_off() function.  I'll send a patch for that next.

In my understanding things look rather like this:

--- linus-2.5/Documentation/cli-sti-removal.txt	2002-07-24 23:10:23.000000000 -0600
+++ thunder-2.5/Documentation/cli-sti-removal.txt	2002-07-25 01:12:45.000000000 -0600
@@ -96,8 +96,8 @@
 drivers that want to disable local interrupts (interrupts on the
 current CPU), can use the following five macros:
 
-  local_irq_disable(), local_irq_enable(), local_irq_save(flags),
-  local_irq_save_off(flags), local_irq_restore(flags)
+  local_irq_disable(), local_irq_enable(), local_save_flags(flags),
+  local_irq_save(flags), local_irq_restore(flags)
 
 but beware, their meaning and semantics are much simpler, far from
 that of the old cli(), sti(), save_flags(flags) and restore_flags(flags)
@@ -107,11 +107,11 @@
 
     local_irq_enable()        => turn local IRQs on
 
-    local_irq_save(flags)     => save the current IRQ state into flags. The
+    local_save_flags(flags)   => save the current IRQ state into flags. The
                                  state can be on or off. (on some
                                  architectures there's even more bits in it.)
 
-    local_irq_save_off(flags) => save the current IRQ state into flags and
+    local_irq_save(flags)     => save the current IRQ state into flags and
                                  disable interrupts.
 
     local_irq_restore(flags)  => restore the IRQ state from flags.

							Regards,
							Thunder
-- 
(Use http://www.ebb.org/ungeek if you can't decode)
------BEGIN GEEK CODE BLOCK------
Version: 3.12
GCS/E/G/S/AT d- s++:-- a? C++$ ULAVHI++++$ P++$ L++++(+++++)$ E W-$
N--- o?  K? w-- O- M V$ PS+ PE- Y- PGP+ t+ 5+ X+ R- !tv b++ DI? !D G
e++++ h* r--- y- 
------END GEEK CODE BLOCK------


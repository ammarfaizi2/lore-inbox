Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262030AbTINVmo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Sep 2003 17:42:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262033AbTINVmo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Sep 2003 17:42:44 -0400
Received: from modemcable137.219-201-24.mtl.mc.videotron.ca ([24.201.219.137]:25473
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S262030AbTINVml (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Sep 2003 17:42:41 -0400
Date: Sun, 14 Sep 2003 17:42:42 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Kevin Breit <mrproper@ximian.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Need fixing of a rebooting system
In-Reply-To: <1063561687.10874.0.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.53.0309141741050.5140@montezuma.fsmlabs.com>
References: <1063496544.3164.2.camel@localhost.localdomain> 
 <Pine.LNX.4.53.0309131945130.3274@montezuma.fsmlabs.com>  <3F6450D7.7020906@ximian.com>
  <Pine.LNX.4.53.0309140904060.22897@montezuma.fsmlabs.com>
 <1063561687.10874.0.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Sep 2003, Kevin Breit wrote:

> On Sun, 2003-09-14 at 09:05, Zwane Mwaikambo wrote:
> > On Sun, 14 Sep 2003, Kevin Breit wrote:
> > 
> > > I set the CPU type to PII/Celeron and recompiled.  It was at 
> > > PIII/Celeron but it still won't work.  It is still rebooting.
> > 
> > Please send your .config and a dmesg from a working kernel.
> 
> The files should be attached.  If they aren't, please let me know!
> 
> Thanks for your help.

Can you try with the following patch, courtesy of Adam Belay, my box 
panicked with your .config without it.

--- a/sound/pci/ens1370.c	2003-09-13 19:28:45.000000000 +0000
+++ b/sound/pci/ens1370.c	2003-09-13 19:30:02.000000000 +0000
@@ -2354,7 +2354,11 @@
 }

 static struct pci_driver driver = {
-	.name = "Ensoniq AudioPCI",
+#ifdef CHIP1371
+	.name = "Ensoniq 1371",
+#else
+	.name = "Ensoniq 1370",
+#endif
 	.id_table = snd_audiopci_ids,
 	.probe = snd_audiopci_probe,
 	.remove = __devexit_p(snd_audiopci_remove),


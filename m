Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272440AbTGaK2o (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 06:28:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272446AbTGaK2o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 06:28:44 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:46559 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S272440AbTGaK2m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 06:28:42 -0400
Date: Thu, 31 Jul 2003 12:28:28 +0200
From: Pavel Machek <pavel@suse.cz>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: alan@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: Warn about taskfile?
Message-ID: <20030731102827.GD464@elf.ucw.cz>
References: <20030730225500.GC144@elf.ucw.cz> <Pine.SOL.4.30.0307310058580.17352-100000@mion.elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.SOL.4.30.0307310058580.17352-100000@mion.elka.pw.edu.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > I had some strange fs corruption, and andi suggested that it probably
> > > > is TASKFILE-related. Perhaps this is good idea?
> > >
> > > Idea is good.
> > >
> > > Did corruption go away after disabling taskfile?
> >
> > Not sure, it took week for corruption to creep in, and it might have
> > been loop-related or swsusp-related. I'm not at all sure it was
> > TASKFILE, but I'm turning it off for now.
> 
> I doubt it was taskfile, your /dev/hda is using UDMA so taskfile's impact
> is minimal.  I've checked this codepath once again today and can't
> see anything which has (possibly) caused Andi's problems.
> 
> I think if it is taskfile related it might be caused by some timing issues
> (races) and should be visible (less frequently) with non-taskfile code too
> and this is not happening.
> 
> If you are not sure if it was taskfile why do you want to warn about it?
> [ Because Andi is spreading FUD about taskfile? ;-) ]

This was i386 machine, but I'm not sure if I told that to Andi.

> > At least it is strange to have option that says both "experimental"
> > and "it is safe to say Y". What are those "most cases"?
> 
> Using (U)DMA should be 100% safe, using single-sector PIO should
> also be safe, using multi-sector PIO might be less safe...

Perhaps this is good idea?
								Pavel

--- clean/drivers/ide/Kconfig	2003-07-27 22:31:13.000000000 +0200
+++ linux/drivers/ide/Kconfig	2003-07-31 12:24:16.000000000 +0200
@@ -283,7 +283,8 @@
 	---help---
 	  Use new taskfile IO code.
 
-	  It is safe to say Y to this question, in most cases.
+  	  It is safe to say Y to this question if you are using (U)DMA or
+	  single-sector PIO. Be carefull wilh multi-sector PIO.
 
 comment "IDE chipset support/bugfixes"
 	depends on BLK_DEV_IDE


-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]

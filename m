Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272327AbTG3XFE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 19:05:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272330AbTG3XFE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 19:05:04 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:16006 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S272327AbTG3XDm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 19:03:42 -0400
Date: Thu, 31 Jul 2003 01:03:32 +0200
From: Pavel Machek <pavel@suse.cz>
To: Alan Cox <alan@redhat.com>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Warn about taskfile?
Message-ID: <20030730230332.GD144@elf.ucw.cz>
References: <20030730205935.GA238@elf.ucw.cz> <200307302111.h6ULBci06803@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307302111.h6ULBci06803@devserv.devel.redhat.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I had some strange fs corruption, and andi suggested that it probably
> > is TASKFILE-related. Perhaps this is good idea?
> 
> Well without taskfile multimode may corrupt your disks, so pick one.
> This needs debugging not paranoia.

Can you explain a bit more? If multi_mode needs taskfile perhaps we
need to kill compilation? [Attached patch probably is not enough,
AFAICS multimode can be turned on without this config option, but it
should be clear what I mean.]

> > +	  It is safe to say Y to this question, but you should attach
> > +	  scratch monkey, first.
> 
> "a scratch monkey" - also a lot of people won't get the reference

Okay, it is probably not the best help text ever.

If I want safest possible configuration for 2.6.0, is
CONFIG_TASKFILE_IO=n, CONFIG_IDEDISK_MULTI_MODE=n and hdparm -c 1
/dev/hda good idea?
								Pavel

--- clean/drivers/ide/ide-disk.c	2003-07-27 22:31:13.000000000 +0200
+++ linux/drivers/ide/ide-disk.c	2003-07-31 00:59:36.000000000 +0200
@@ -1650,6 +1650,9 @@
 	drive->mult_count = 0;
 	if (id->max_multsect) {
 #ifdef CONFIG_IDEDISK_MULTI_MODE
+#ifndef CONFIG_TASKFILE_IO
+#error IDEDISK_MULTI_MODE needs TASKFILE_IO for safe operation
+#endif
 		id->multsect = ((id->max_multsect/2) > 1) ? id->max_multsect : 0;
 		id->multsect_valid = id->multsect ? 1 : 0;
 		drive->mult_req = id->multsect_valid ? id->max_multsect : INITIAL_MULT_COUNT;


-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262308AbVAOTJW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262308AbVAOTJW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 14:09:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262311AbVAOTJW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 14:09:22 -0500
Received: from hera.cwi.nl ([192.16.191.8]:53923 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S262308AbVAOTJP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 14:09:15 -0500
Date: Sat, 15 Jan 2005 20:01:30 +0100
From: Andries Brouwer <Andries.Brouwer@cwi.nl>
To: Andrew Morton <akpm@osdl.org>
Cc: Andries Brouwer <aebr@win.tue.nl>, bunk@stusta.de,
       linux-kernel@vger.kernel.org
Subject: Re: Do PS/2 ESDI users exist?
Message-ID: <20050115190130.GA8744@apps.cwi.nl>
References: <20050108214036.GW14108@stusta.de> <20050108234337.GE6052@pclin040.win.tue.nl> <20050111043220.GB2760@pclin040.win.tue.nl> <20050110204909.2703d7af.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050110204909.2703d7af.akpm@osdl.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2005 at 08:49:09PM -0800, Andrew Morton wrote:
> Andries Brouwer <aebr@win.tue.nl> wrote:
> >
> > I wonder whether ps2esdi should be removed.
> >  Does the present driver work for someone?
> >  Have there been users in this millennium? With 2.3 or later?
> 
> We could mark it CONFIG_BROKEN, leave it six months or so, see if anyone
> complains.

OK.

diff -uprN -X /linux/dontdiff a/drivers/block/Kconfig b/drivers/block/Kconfig
--- a/drivers/block/Kconfig	2004-12-29 03:39:44.000000000 +0100
+++ b/drivers/block/Kconfig	2005-01-11 12:35:25.000000000 +0100
@@ -42,7 +42,7 @@ config MAC_FLOPPY
 
 config BLK_DEV_PS2
 	tristate "PS/2 ESDI hard disk support"
-	depends on MCA && MCA_LEGACY
+	depends on MCA && MCA_LEGACY && BROKEN
 	help
 	  Say Y here if you have a PS/2 machine with a MCA bus and an ESDI
 	  hard disk.

I hesitated a bit: Just removing something means: we do no longer
want to support it. That might happen even when a feature still
works. For example, xiafs was removed, but it worked fine.
On the other hand, saying that something is broken invites the
question "what precisely is broken?", and is an invitation to fix
rather than an announcement of an intention to obsolete.

Maybe I would prefer just to throw ps2esdi out, and say that
2.2 is the preferred distribution for people who need ps2esdi.

As observed earlier, ps2esdi was broken as a module,
and the passing of geometry boot parameters is broken.
But does it still work with kernels 2.3 or later?
I think it does, but failed to verify that.

I found an IBM PS/2 model 70-A21 with 8 MB and 120 MB ESDI disk.
Tried a few distribution boot floppies to see whether they would boot.

Slackware has special ibmmca bootdisks.
SW 3.3 - Linux 2.1.43 - boots fine
SW 4.0 - Linux 2.2.6 - hangs
SW 7.0 - Linux 2.2.13 - boots fine
SW 8.1 - Linux 2.4.18 - boots, but every single command is killed by OOM
SW 10.0 - Linux 2.4.26 - kernel panic: no 386 supported

Then Debian:
Woody - Linux 2.2.10 - boots fine, but the rootdisk hangs
Sarge - Linux 2.4.27 - does not recognize the ESDI disk, and the rootdisk
 crashes by OOM.

So, good luck with 2.1 and 2.2 kernels, only failures with later kernels.

What about other people? The two major Linux/MCA sites were
http://glycerine.itsmm.uni.edu/mca (also referenced in Documentation/mca.txt)
but it doesnt exist any longer, and http://www.dgmicro.com/mca/,
which still exists ("last update: Jan 28 1999"), but the binaries
it refers to live on ftp.dgmicro.com, which isn't there anymore.

Concerning the speed:
I measured this ESDI disk under Linux as transferring 50 kB/s,
that is 4% of the speed the IBM specs claim. Also other Linux users
complained that the disk is much faster under DOS.

Andries

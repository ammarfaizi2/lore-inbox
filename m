Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262655AbUCERDx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 12:03:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262657AbUCERDw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 12:03:52 -0500
Received: from [193.138.115.101] ([193.138.115.101]:48398 "HELO
	diftmgw.backbone.dif.dk") by vger.kernel.org with SMTP
	id S262655AbUCERDu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 12:03:50 -0500
Date: Fri, 5 Mar 2004 17:59:55 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel@vger.kernel.org
Subject: SCSI CDROM/DVD trouble with 2.6.3 (2.6.2 is fine)
Message-ID: <Pine.LNX.4.56.0403051745430.21208@jju_lnx.backbone.dif.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I'm currently running 2.6.2 on a system with an Adaptec 29160N SCSI
controller, an IBM UltraStar Ultra160 SCSI disk, A Plextor SCSI CD writer
and a Pioneer SCSI DVD-ROM drive.
With 2.6.2 everything functions perfectly (did so with 2.4.x as well) and
I have no trouble what-so-ever.  With 2.6.3 it's a completely different
matter.
I had build my 2.6.2 kernel so that it included the config in /proc , so
when time came to build 2.6.3 I grabbed /proc/config.gz and used that as a
basis (make oldconfig) for my new kernel - I answered No to all the new
options presented by oldconfig for 2.6.3 since I needed none of them, then
proceeded to build and install the kernel (This is on a Slackware 9.1
system and both kernels where build with the same gcc 3.2.3 compiler).
Booting the 2.6.3 kernel works just fine, the controller is identified
just as with 2.6.2 and all my devices are found as well. The trouble
begins when I attempt to mount (or otherwhice access) the CD-RW and DVD
devices. The processes accessing /dev/sr0 and/or /dev/sr1 just hang, and
when I attempt to kill them they don't die but just end up unkillable in D
state. Running strace on mount when trying to mount a CD reveals that it
is stuck in a read() call that apparently never completes.
I can use my SCSI HD just fine, but there is one small bit of strangeness
there as well. When it comes time to shut down the system I get reports
that /home is busy an cannot be unmounted so it gets remounted read-only
instead (which seems to succeed). I actually get the same error for /proc
which really puzzels me since it's not on any SCSI device.

Rebooting back to 2.6.2 results in a perfectly working system again.

So, what changed regarding SCSI and or the (new) aic7xxx driver from 2.6.2
to 2.6.3 ?  I don't know, but something must have happened since 2.6.2
works fine and 2.6.3 (with basically the same .config) is completely
unusable.

Let me know if you want further details and/or want me to test patches
etc, and I'll be happy to provide anything you may need/test anything you
want me to test.


-- 
Jesper Juhl <juhl@dif.dk>
Systems Administrator, Danmarks Idræts-Forbund / The Danish Sports Federation
Please don't top-post    http://www.catb.org/~esr/jargon/html/T/top-post.html
Please send plain text emails only          http://www.expita.com/nomime.html

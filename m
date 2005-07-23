Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262247AbVGWAT3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262247AbVGWAT3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 20:19:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262246AbVGWAT3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 20:19:29 -0400
Received: from smtpauth05.mail.atl.earthlink.net ([209.86.89.65]:8920 "EHLO
	smtpauth05.mail.atl.earthlink.net") by vger.kernel.org with ESMTP
	id S262247AbVGWAT2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 20:19:28 -0400
To: linux-kernel@vger.kernel.org
Subject: 2.6.13-rc3: swsusp works (TP 600X)
X-Mailer: MH-E 7.84; nmh 1.1; GNU Emacs 21.4.1
Date: Fri, 22 Jul 2005 20:19:18 -0400
From: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Message-Id: <E1Dw7ja-0002Ge-EF@approximate.corpus.cam.ac.uk>
X-ELNK-Trace: dcd19350f30646cc26f3bd1b5f75c9f474bf435c0eb9d47826f234369f82662fd2ec2305d31de11a68fdb9e9071e9a9c350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 24.41.6.91
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

swsusp now mostly works on my TP 600X.  If I don't eject the pcmcia card
(usually a prism54 wireless card), swsusp begins the process of
hibernation, but never gets to the writing pages part.  The eth0 somehow
tries to reload the firmware (as if it's been woken up), and then
everything hangs.  If I eject the card and (for safety) stop
/etc/init.d/pcmcia, then swsusp writes out the memory to swap, and
waking up works fine.  Thanks for all the improvements!

Is there debugging I can do in order to help get the pcmcia system
hibernating automagically?

One other glitch is that pdnsd (a nameserver caching daemon) has crashed
when the system wakes up from swsusp.  It also happens when waking up
from S3, which was working with 2.6.11.4 although not with 2.6.13-rc3.
Many people have said mysql also does not suspend well.  Is their use of
a named pipe or socket causing the problem?

System: TP 600X, 2.6.13-rc3 vanilla kernel, fixed DSDT that I used to
        get S3 working with 2.6.11.4 (see
        <http://bugme.osdl.org/show_bug.cgi?id=4926> for the DSDT),
        booted with 
              idebus=66 apm=off acpi=force pci=noacpi acpi_sleep=s3_bios

-Sanjoy

`A society of sheep must in time beget a government of wolves.'
   - Bertrand de Jouvenal

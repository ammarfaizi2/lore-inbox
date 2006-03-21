Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751809AbWCUWJt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751809AbWCUWJt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 17:09:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751807AbWCUWJt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 17:09:49 -0500
Received: from smtpauth08.mail.atl.earthlink.net ([209.86.89.68]:33471 "EHLO
	smtpauth08.mail.atl.earthlink.net") by vger.kernel.org with ESMTP
	id S1751802AbWCUWJs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 17:09:48 -0500
To: "Yu, Luming" <luming.yu@intel.com>
cc: linux-kernel@vger.kernel.org, "Linus Torvalds" <torvalds@osdl.org>,
       "Andrew Morton" <akpm@osdl.org>, "Tom Seeley" <redhat@tomseeley.co.uk>,
       "Dave Jones" <davej@redhat.com>, "Jiri Slaby" <jirislaby@gmail.com>,
       michael@mihu.de, mchehab@infradead.org,
       "Brian Marete" <bgmarete@gmail.com>,
       "Ryan Phillips" <rphillips@gentoo.org>, gregkh@suse.de,
       "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org,
       "Mark Lord" <lkml@rtr.ca>, "Randy Dunlap" <rdunlap@xenotime.net>,
       jgarzik@pobox.com, "Duncan" <1i5t5.duncan@cox.net>,
       "Pavlik Vojtech" <vojtech@suse.cz>, "Meelis Roos" <mroos@linux.ee>
Subject: Re: 2.6.16-rc5: known regressions [TP 600X S3, vanilla DSDT] 
In-Reply-To: Your message of "Tue, 21 Mar 2006 17:11:29 +0800."
             <3ACA40606221794F80A5670F0AF15F840B417863@pdsmsx403> 
X-Mailer: MH-E 7.91; nmh 1.1; GNU Emacs 21.4.1
Date: Tue, 21 Mar 2006 17:09:25 -0500
From: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Message-Id: <E1FLp2b-00011l-Fz@approximate.corpus.cam.ac.uk>
X-ELNK-Trace: dcd19350f30646cc26f3bd1b5f75c9f474bf435c0eb9d478d165aa9320335d718cc3f7e9008610e7ee90dc03c8257537350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 24.41.6.91
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Two more experiments:

  With a vanilla kernel, I faked EC0.UPDT() to just return 0x00, and the
  system hung on the second sleep.

  Then, again in the DSDT, I also faked the 4 _TMP methods (one in each
  thermal zone), and the system hung on the second sleep.

I think we've raced too far ahead by trying to debug many thermal zones
at once.  Perhaps there are two bugs.  So let's find them one by one.

One bug is quite repeatable and we know a lot about it. With all zones
except THM0 commented out, the system hung.  With the EC0.UPDT line in
THM0._TMP also commented out, the system didn't hang.  So there's a
problem related to the EC, even with only THM0.  And finding that
problem may giveideas for what else may be wrong.

-Sanjoy

`A society of sheep must in time beget a government of wolves.'
   - Bertrand de Jouvenal

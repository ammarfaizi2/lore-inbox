Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263925AbTEOJho (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 05:37:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263928AbTEOJhn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 05:37:43 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:56706 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S263925AbTEOJhm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 05:37:42 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16067.25088.905125.474440@gargle.gargle.HOWL>
Date: Thu, 15 May 2003 11:46:40 +0200
From: mikpe@csd.uu.se
To: Pavel Machek <pavel@suse.cz>
Cc: Adrian Bunk <bunk@fs.tum.de>, Andrew Morton <akpm@digeo.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5.69-mm5: CONFIG_ACPI_SLEEP compile error
In-Reply-To: <20030514225157.GA13427@elf.ucw.cz>
References: <20030514012947.46b011ff.akpm@digeo.com>
	<20030514214536.GK1346@fs.tum.de>
	<20030514225157.GA13427@elf.ucw.cz>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek writes:
 > Hi!
 > 
 > Mikpe, is this your diff? 
 > 
 > revision 1.16
 > date: 2003/05/11 18:58:48;  author: mikpe;  state: Exp;  lines: +2 -4
 > restore sysenter MSRs at APM resume
 > 
 > I do not know why you changed it (it has certainly nothing to do with
 > APM resume)... Please revert it.

I've just posted a fix for the compile error.

APM suspend and resume now use the save and restore processor state
procedures in suspend.c. The only alternative is to duplicate that
functionality in apm.c or a new "suspend-but-not-tied-to-acpi.c" file.
But suspend.c is fairly generic so it makes sense to share it with APM.

The suspend.c changes are cleanups. The variables are only used in acpi's
suspend_asm.S and acpi/wakeup.S, so I moved them to suspend_asm.S since
they aren't needed when suspend is done by APM. fix_processor_context()
isn't used outside of suspend.c so I made it static.

Do you still have a problem with this?

/Mikael

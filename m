Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267923AbUJOOJk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267923AbUJOOJk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 10:09:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267777AbUJOOIT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 10:08:19 -0400
Received: from gprs212-94.eurotel.cz ([160.218.212.94]:30595 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S267852AbUJOOA3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 10:00:29 -0400
Date: Fri, 15 Oct 2004 15:59:55 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Pavel Machek <pavel@ucw.cz>, Paul Mackerras <paulus@samba.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, David Brownell <david-b@pacbell.net>
Subject: Re: Totally broken PCI PM calls
Message-ID: <20041015135955.GD2015@elf.ucw.cz>
References: <1097455528.25489.9.camel@gaston> <Pine.LNX.4.58.0410101937100.3897@ppc970.osdl.org> <16746.299.189583.506818@cargo.ozlabs.ibm.com> <Pine.LNX.4.58.0410102115410.3897@ppc970.osdl.org> <20041011101824.GC26677@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.58.0410110857180.3897@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0410110857180.3897@ppc970.osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Does sparse now have typechecking on enums?
> 
> You can mark an enum "bitwise" (by making all of it's values be
> "bitwise"), and it will be considered a type of its own, yes. But then you
> also cannot do arithmetic on it (which _usually_ is what you want, but not
> necessarily always).
> 
> (You'd also need to pass in the "-Wbitwise" flag to sparse, to get the
> checks).
> 
> By the time you mark something "bitwise", you don't even need to use an
> enum, btw. You can just do a regular integer typedef and mark the typedef 
> to be "bitwise" - that generates a unique type right there. That's what 
> the endianness checking does.

I'm trying to learn how to work with bitwise on obsolete stuff, but
checking there is good, too, right?

Is this right way to do it?

+typedef enum pm_request __bitwise {
+       __bitwise PM_SUSPEND, /* enter D1-D3 */
+       __bitwise PM_RESUME,  /* enter D0 */
+} pm_request_t;
+
+/*
+ * Device types... these are passed to pm_register
+ */
+typedef enum pm_dev_type __bitwise {
+       __bitwise PM_UNKNOWN_DEV = 0, /* generic */
+       __bitwise PM_SYS_DEV,       /* system device (fan, KB
controller, ...) */
+       __bitwise PM_PCI_DEV,       /* PCI device */
+       __bitwise PM_USB_DEV,       /* USB device */
+       __bitwise PM_SCSI_DEV,      /* SCSI device */
+       __bitwise PM_ISA_DEV,       /* ISA device */
+       __bitwise PM_MTD_DEV,       /* Memory Technology Device */
+} pm_dev_t;

Having __bitwise at every line in enum looks quite ugly to my
eyes. [Where to get sparse? I tried to google for it but "sparse" is
very common word (as in sparse matrix). And theres no
kernel/people/linus on kernel.org...]
							Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!

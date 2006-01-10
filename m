Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932230AbWAJSzQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932230AbWAJSzQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 13:55:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751179AbWAJSzQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 13:55:16 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:40168 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751174AbWAJSzO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 13:55:14 -0500
Subject: Re: 2G memory split
From: Dave Hansen <haveblue@us.ibm.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Martin Bligh <mbligh@mbligh.org>, Jens Axboe <axboe@suse.de>,
       Byron Stanoszek <gandalf@winds.org>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0601101028360.4939@g5.osdl.org>
References: <20060110125852.GA3389@suse.de> <20060110132957.GA28666@elte.hu>
	 <20060110133728.GB3389@suse.de>
	 <Pine.LNX.4.63.0601100840400.9511@winds.org>
	 <20060110143931.GM3389@suse.de>
	 <Pine.LNX.4.64.0601100804380.4939@g5.osdl.org>
	 <43C3F986.4090209@mbligh.org>
	 <Pine.LNX.4.64.0601101028360.4939@g5.osdl.org>
Content-Type: text/plain
Date: Tue, 10 Jan 2006 10:55:11 -0800
Message-Id: <1136919312.2557.77.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-01-10 at 10:34 -0800, Linus Torvalds wrote:
> On Tue, 10 Jan 2006, Martin Bligh wrote:
> > 
> > The non-1GB-aligned ones need to be disbarred when PAE is on, I think.
> 
> Well, right now _all_ the non-3:1 cases need to be disbarred. I think we 
> depend on the kernel mapping only ever being the _one_ last entry in the 
> top-level page table, which is only true with the 3:1 mapping.

It actually "just works".  We have a 16GB machine that gets a lot of
filesystem activity and use a 2:2 split all the time.  Appended patch is
all that we need.

It was for other reasons at the time, but I think we fixed a bunch of
the multiple kernel mapping PMDs back in 2.5.  Some remnants of that
stuff are still around.

http://marc.theaimsgroup.com/?l=linux-kernel&m=104197008817507&w=2

diff -purN -X /home/dvhart/.diff.exclude /home/linux/views/linux-2.6.12/include/asm-i386/page.h 2.6.12-uptime/include/asm-i386/page.h
--- /home/linux/views/linux-2.6.12/include/asm-i386/page.h	2005-03-02 03:00:08.000000000 -0800
+++ 2.6.12-uptime/include/asm-i386/page.h	2005-07-27 11:53:40.000000000 -0700
@@ -122,9 +122,9 @@ extern int sysctl_legacy_va_layout;
 #endif /* __ASSEMBLY__ */
 
 #ifdef __ASSEMBLY__
-#define __PAGE_OFFSET		(0xC0000000)
+#define __PAGE_OFFSET		(0x80000000)
 #else
-#define __PAGE_OFFSET		(0xC0000000UL)
+#define __PAGE_OFFSET		(0x80000000UL)
 #endif
 
-- Dave


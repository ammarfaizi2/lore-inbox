Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262562AbUKVTwv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262562AbUKVTwv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 14:52:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262597AbUKVTvE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 14:51:04 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:52634 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262562AbUKVTuW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 14:50:22 -0500
Date: Mon, 22 Nov 2004 11:50:16 -0800
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Oliver Neukum <oliver@neukum.org>
Cc: linux-kernel@vger.kernel.org, domen@coderock.org
Subject: [PATCH ] kernel/timer: correct msleep_interruptible() comment
Message-ID: <20041122195016.GB7770@us.ibm.com>
References: <20041117024944.GB4218@us.ibm.com> <200411201037.22237.oliver@neukum.org> <20041122180154.GA8442@us.ibm.com> <200411221934.53425.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411221934.53425.oliver@neukum.org>
X-Operating-System: Linux 2.6.9-test-acpi (i686)
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2004 at 07:34:53PM +0100, Oliver Neukum wrote:
> Am Montag, 22. November 2004 19:01 schrieb Nishanth Aravamudan:
> > On Sat, Nov 20, 2004 at 10:37:21AM +0100, Oliver Neukum wrote:
> > > Am Samstag, 20. November 2004 02:23 schrieb Nishanth Aravamudan:
> > > > Description: Remove prototypes of msleep() and msleep_interruptible() to
> > > > prepare for the macro versions of these functions. Add macros for 4
> > > > types of sleeps:
> > > 
> > > What is the purpose of having macros for delay?
> > > They are on a slow path by definition. You want the smallest possible
> > > function call here, nothing fancy.
> > 
> > Just so I'm clear on what you are asking... Do you mean why am I using
> > macros or why the macros are needed at all?
> 
> Yes, they should be functions.
> 
> > To the former, I am more than happy to change them to functions, and, in
> > fact, I believe I have to for modules (EXPORT_SYMBOL_GPL?) to be able to
> > call the sleep functions.
> > 
> > To the latter, having these 4 functions/macros makes it clear for what
> > reason you are sleeping. It leads to *correct* functionality of the
> > code, which we do not currently have.
> 
> But two of them are redundant. You are reinventing the wait_event_*
> family.

Fair enough. I was not aware of the various wait_event_*timeout()
functions. Thanks for beating me over the head with this. Kind of shoots
down my fancy patch though :) Here's one that at least corrects the
comment that made all of this happen...

-Nish

Description: The comment for msleep_interruptible() incorrectly asserts
that the function takes into consideration wait-queue interruptions. The
wait_event_*() family of functions should be used in those cases.
msleep_interruptible() is only to be used when sleeping waiting for
signals.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>


--- 2.6.10-rc2-vanilla/kernel/timer.c	2004-11-19 16:12:28.000000000 -0800
+++ 2.6.10-rc2/kernel/timer.c	2004-11-22 11:19:16.000000000 -0800
@@ -1627,7 +1627,7 @@ void msleep(unsigned int msecs)
 EXPORT_SYMBOL(msleep);
 
 /**
- * msleep_interruptible - sleep waiting for waitqueue interruptions
+ * msleep_interruptible - sleep waiting for signals
  * @msecs: Time in milliseconds to sleep for
  */
 unsigned long msleep_interruptible(unsigned int msecs)

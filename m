Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751217AbWDQTVF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751217AbWDQTVF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 15:21:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751227AbWDQTVF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 15:21:05 -0400
Received: from mail7.sea5.speakeasy.net ([69.17.117.9]:64907 "EHLO
	mail7.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1751221AbWDQTVC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 15:21:02 -0400
Date: Mon, 17 Apr 2006 15:20:55 -0400 (EDT)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@d.namei
To: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>
cc: Stephen Smalley <sds@tycho.nsa.gov>, T?r?k Edwin <edwin@gurde.com>,
       linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
       Chris Wright <chrisw@sous-sol.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Time to remove LSM (was Re: [RESEND][RFC][PATCH 2/7] implementation
 of LSM hooks)
In-Reply-To: <20060417173319.GA11506@infradead.org>
Message-ID: <Pine.LNX.4.64.0604171454070.17563@d.namei>
References: <200604021240.21290.edwin@gurde.com> <200604072138.35201.edwin@gurde.com>
 <1144863768.32059.67.camel@moss-spartans.epoch.ncsc.mil>
 <200604142301.10188.edwin@gurde.com> <1145290013.8542.141.camel@moss-spartans.epoch.ncsc.mil>
 <20060417162345.GA9609@infradead.org> <1145293404.8542.190.camel@moss-spartans.epoch.ncsc.mil>
 <20060417173319.GA11506@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Apr 2006, Christoph Hellwig wrote:

> > Or, better, remove LSM itself ;)
> 
> Seriously that makes a lot of sense.  All other modules people have come up
> with over the last years are irrelevant and/or broken by design.

It's been nearly a year since I proposed this, and we've not seen any 
appropriate LSM modules submitted in that time.

See
http://thread.gmane.org/gmane.linux.kernel.lsm/1120
http://thread.gmane.org/gmane.linux.kernel.lsm/1088

The only reason I can see to not delete it immediately is to give BSD 
secure levels users a heads-up, although I thought it was already slated 
for removal.  BSD secure levels is fundamentally broken and should 
never have gone into mainline.

How about enough time to get us to 2.6.18, say, two months?


Signed-off-by: James Morris <jmorris@namei.org>

--- linux-2.6.17-rc1.o/Documentation/feature-removal-schedule.txt	2006-04-15 19:57:53.000000000 -0400
+++ linux-2.6.17-rc1.x/Documentation/feature-removal-schedule.txt	2006-04-17 15:18:15.000000000 -0400
@@ -246,3 +246,27 @@ Why:	The interface no longer has any cal
 Who:	Nick Piggin <npiggin@suse.de>
 
 ---------------------------
+
+What:	LSM (Linux Security Modules) including BSD Secure Levels.
+When:	June 2006
+Why:	In the years since LSM was included in the mainline kernel, SELinux
+        has been the only significant module implemented and also included
+        in the mainline kernel.  So we have a generalized framework for
+        one user, SELinux, which itself is a generalized framework.
+        Thus, LSM will be removed, as it adds unecessary infrastructure,
+        performance overhead and complicates the code.  It also attracts
+        a regular stream of misconceived and broken security module
+        submissions to mainline, such as BSD Security Levels, and
+        developers are seeing LSM as the answer to everything rather
+        than really thinking about what they need and how to architect
+        the code properly and generally.  There is also a growing number
+        of proprietary modules hooking into LSM in usafe ways, not 
+        necessarily even for security purposes.  The LSM interface
+        semantics are too weak and such an API does not belong in the
+        mainline kernel.
+        See also, previous discussions on the issue:
+        http://thread.gmane.org/gmane.linux.kernel.lsm/1120
+        http://thread.gmane.org/gmane.linux.kernel.lsm/1088
+Who:	James Morris <jmorris@namei.org>
+
+---------------------------




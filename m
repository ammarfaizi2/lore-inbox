Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261455AbUJZUne@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261455AbUJZUne (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 16:43:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261452AbUJZUmu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 16:42:50 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:43693 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S261457AbUJZUle (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 16:41:34 -0400
Date: Tue, 26 Oct 2004 13:41:32 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Jean-Christophe Dubois <jdubois@mc.com>,
       kai@germaschewski.name, sam@ravnborg.org
Subject: Re: [PATCH 2.6.9] kbuild warning fixes on Solaris 9
Message-ID: <20041026204132.GD926@smtp.west.cox.net>
References: <20041025224907.GL25154@smtp.west.cox.net> <20041026221408.GB30918@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041026221408.GB30918@mars.ravnborg.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27, 2004 at 12:14:08AM +0200, Sam Ravnborg wrote:
> On Mon, Oct 25, 2004 at 03:49:07PM -0700, Tom Rini wrote:
> > The following set of patches is based loosely on the patches that
> > Jean-Christophe Dubois came up with for 2.6.7.  Where as the original
> > patches added a number of casts to unsigned char, I went the route of
> > making the chars be explicitly signed.  I honestly don't know which
> > route is better to go down.  Doing this is the bulk of the patch.  Out
> > of the rest of the odds 'n ends is that on Solaris, Elf32_Word is a
> > ulong, which means all of the printf's are unhappy (uint format, ulong
> > arg) for most of the typedefs.
> > 
> > Signed-off-by: Tom Rini <trini@kernel.crashing.org>
> > 
> > Comments?  Beatings?  Thanks.
> 
> Looks much better. Applied.

Great.  A coworker of mine give them a look-over and spotted a few
places where I missed changing some casts.


Signed-off-by: Tom Rini <trini@kernel.crashing.org>

--- linux-2.6.9/scripts/basic/fixdep.c
+++ linux-2.6.9/scripts/basic/fixdep.c
@@ -225,10 +225,10 @@
 	signed char *p, *q;
 
 	for (; m < end; m++) {
-		if (*m == INT_CONF) { p = (char *) m  ; goto conf; }
-		if (*m == INT_ONFI) { p = (char *) m-1; goto conf; }
-		if (*m == INT_NFIG) { p = (char *) m-2; goto conf; }
-		if (*m == INT_FIG_) { p = (char *) m-3; goto conf; }
+		if (*m == INT_CONF) { p = (signed char *) m  ; goto conf; }
+		if (*m == INT_ONFI) { p = (signed char *) m-1; goto conf; }
+		if (*m == INT_NFIG) { p = (signed char *) m-2; goto conf; }
+		if (*m == INT_FIG_) { p = (signed char *) m-3; goto conf; }
 		continue;
 	conf:
 		if (p > map + len - 7)
--- linux-2.6.9/scripts/mod/modpost.c
+++ linux-2.6.9/scripts/mod/modpost.c
@@ -215,7 +215,7 @@
 	static char line[4096];
 	int skip = 1;
 	size_t len = 0;
-	signed char *p = (char *)file + *pos;
+	signed char *p = (signed char *)file + *pos;
 	char *s = line;
 
 	for (; *pos < size ; (*pos)++)

-- 
Tom Rini
http://gate.crashing.org/~trini/

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262944AbVCMEgG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262944AbVCMEgG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 23:36:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262899AbVCMEel
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 23:34:41 -0500
Received: from mail.autoweb.net ([198.172.237.26]:12299 "EHLO mail.autoweb.net")
	by vger.kernel.org with ESMTP id S262934AbVCMEcw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 23:32:52 -0500
Date: Sat, 12 Mar 2005 23:32:29 -0500
From: Ryan Anderson <ryan@michonline.com>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: [PATCH] Auto-append localversion for BK users needs to use CONFIG_SHELL
Message-ID: <20050313043229.GA7828@mythryan2.michonline.com>
Mail-Followup-To: Sam Ravnborg <sam@ravnborg.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
References: <422FA817.4060400@ca.ibm.com> <1110420620.32525.145.camel@gaston> <Pine.LNX.4.58.0503091821570.2530@ppc970.osdl.org> <20050310054011.GA8287@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050310054011.GA8287@mars.ravnborg.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(trimming cc: down a bit)

On Thu, Mar 10, 2005 at 06:40:11AM +0100, Sam Ravnborg wrote:
> On Wed, Mar 09, 2005 at 06:25:56PM -0800, Linus Torvalds wrote:
> > On Thu, 10 Mar 2005, Benjamin Herrenschmidt wrote:
> > > BTW, Linus: Any chance you ever change something to version or
> > > extraversion in bk just after a release ? I know I already ask and it
> > > degenerated into a flamefest, and I don't know if that is specifically
> > > the case now, but I keep getting report of people saying "I have a bug
> > > in 2.6.xx" while in fact, they have some kind of bk clone of sometime
> > > after 2.6.xx...
> > 
> > The answer is the same: I'd still like to have somebody (preferably Sam)  
> > who is comfortable with all the build scripts get a revision-control-
> > specific version at build-time, so that BK users would get the top-of-tree 
> > key value, and other people could get some CVS revision or something.
> 
> I have a patch somewhere in my inbox, and got one from Ryan yesterday
> also. I will see if I during the weekend find some time to look at it.

Sam, you'll probably want this on top of the patch I sent.  (I haven't
built in a clean tree in a while, found a minor problem when I was
transitioning to quilt today.)

When running scripts/setlocalversion.sh, use $(CONFIG_SHELL) so the
executable bit doesn't need to be set.

Signed-off-by: Ryan Anderson <ryan@michonline.com>

Index: local-quilt/Makefile
===================================================================
--- local-quilt.orig/Makefile	2005-03-12 20:36:24.000000000 -0500
+++ local-quilt/Makefile	2005-03-12 20:54:40.000000000 -0500
@@ -563,7 +563,7 @@
 
 ifeq ($(CONFIG_LOCALVERSION_AUTO),y)
 	ifeq ($(shell ls -d $(srctree)/BitKeeper 2>/dev/null),$(srctree)/BitKeeper)
-		localversion-bk := $(shell $(srctree)/scripts/setlocalversion.sh $(srctree) $(objtree))
+		localversion-bk := $(shell $(CONFIG_SHELL) $(srctree)/scripts/setlocalversion.sh $(srctree) $(objtree))
 		LOCALVERSION := $(LOCALVERSION)$(localversion-bk)
 	endif
 endif


-- 

Ryan Anderson
  sometimes Pug Majere

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030446AbWBHSpN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030446AbWBHSpN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 13:45:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030450AbWBHSpN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 13:45:13 -0500
Received: from static-151-204-232-50.bos.east.verizon.net ([151.204.232.50]:22237
	"EHLO mail2.sicortex.com") by vger.kernel.org with ESMTP
	id S1030446AbWBHSpL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 13:45:11 -0500
Date: Wed, 8 Feb 2006 13:45:06 -0500
From: "Aaron D. Brooks" <aaron.brooks@sicortex.com>
To: linux-kernel@vger.kernel.org
Cc: Keith Owens <kaos@ocs.com.au>
Subject: scripts/namespace.pl is not CROSS_COMPILE happy
Message-ID: <20060208184506.GS11744@sicortex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,

    I see that this has come up before:

    http://lkml.org/lkml/2005/9/20/68

but I don't see the inclusion of these changes in the current Linus
linux-2.6 git tree. Are the changes hanging out somewhere or were they
shot down for some reason?

    I've attached an alternate patch which is a ever so slightly more
clean (for some definitions of "clean").

-Aaron

P.S. Please CC me, I'm not on the list.

Index: scripts/namespace.pl
===================================================================
--- old/scripts/namespace.pl        (revision 13486)
+++ new/scripts/namespace.pl        (working copy)
@@ -66,8 +66,8 @@
 use strict;
 use File::Find;
 
-my $nm = "/usr/bin/nm -p";
-my $objdump = "/usr/bin/objdump -s -j .comment";
+my $nm = ($ENV{'NM'} || "nm") . " -p";
+my $objdump = ($ENV{'OBJDUMP'} || "objdump") . " -s -j .comment";
 my $srctree = "";
 my $objtree = "";
 $srctree = "$ENV{'srctree'}/" if (exists($ENV{'srctree'}));


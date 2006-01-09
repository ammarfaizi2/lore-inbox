Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750758AbWAIVjK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750758AbWAIVjK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 16:39:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750734AbWAIViy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 16:38:54 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:58895 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1750725AbWAIVip convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 16:38:45 -0500
Subject: [PATCH 06/11] kbuild: reference_discarded addition
In-Reply-To: <20060109211157.GA14477@mars.ravnborg.org>
X-Mailer: gregkh_patchbomb-sam
Date: Mon, 9 Jan 2006 22:38:29 +0100
Message-Id: <11368427093804@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Sam Ravnborg <sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Jones <davej@redhat.com>
Date: 1136533219 -0500

Error: ./fs/quota_v2.o .opd refers to 0000000000000020 R_PPC64_ADDR64    .exit.text

Been carrying this for some time in Red Hat trees.

Keith Ownes <kaos@sgi.com> commented:
For our future {in}sanity, add a comment that this is the ppc .opd
section, not the ia64 .opd section.  ia64 .opd should not point to
discarded sections.

Any idea why ppc .opd points to discarded sections when ia64 does not?
AFAICT no ia64 object has a useful .opd section, they are all empty or
(sometimes) a dummy entry which is 1 byte long.  ia64 .opd data is
built at link time, not compile time.

Signed-off-by: Dave Jones <davej@redhat.com>
Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

---

 scripts/reference_discarded.pl |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

442ce844e139c1e3c23e8b4df13468041ae35721
diff --git a/scripts/reference_discarded.pl b/scripts/reference_discarded.pl
index c2d5414..4ee6ab2 100644
--- a/scripts/reference_discarded.pl
+++ b/scripts/reference_discarded.pl
@@ -71,6 +71,11 @@ foreach $object (keys(%object)) {
 # printf("ignoring %d conglomerate(s)\n", $ignore);
 
 # printf("Scanning objects\n");
+
+# Keith Ownes <kaos@sgi.com> commented:
+# For our future {in}sanity, add a comment that this is the ppc .opd
+# section, not the ia64 .opd section.
+# ia64 .opd should not point to discarded sections.
 $errorcount = 0;
 foreach $object (keys(%object)) {
 	my $from;
@@ -88,6 +93,7 @@ foreach $object (keys(%object)) {
 		    ($from !~ /\.text\.exit$/ &&
 		     $from !~ /\.exit\.text$/ &&
 		     $from !~ /\.data\.exit$/ &&
+		     $from !~ /\.opd$/ &&
 		     $from !~ /\.exit\.data$/ &&
 		     $from !~ /\.altinstructions$/ &&
 		     $from !~ /\.pdr$/ &&
-- 
1.0.GIT


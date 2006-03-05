Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932311AbWCEAgK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932311AbWCEAgK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 19:36:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932312AbWCEAgK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 19:36:10 -0500
Received: from smtp.osdl.org ([65.172.181.4]:28386 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932311AbWCEAgI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 19:36:08 -0500
Date: Sat, 4 Mar 2006 16:34:19 -0800
From: Andrew Morton <akpm@osdl.org>
To: Sam Vilain <sam@vilain.net>
Cc: dhowells@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [Fwd: [PATCH 3/5] NFS: Abstract out namespace initialisation
 [try #2]]
Message-Id: <20060304163419.5884e3e4.akpm@osdl.org>
In-Reply-To: <4407693E.6000108@vilain.net>
References: <44074CFD.7050708@vilain.net>
	<20060302084448.GA21902@infradead.org>
	<440613FF.4040807@vilain.net>
	<3254.1141299348@warthog.cambridge.redhat.com>
	<5923.1141333943@warthog.cambridge.redhat.com>
	<4407693E.6000108@vilain.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Vilain <sam@vilain.net> wrote:
>
>  >Remember: one of the main reasons for splitting patches is to make it easier
>  >for other people to appreciate just how sublimely terrific your work is:-)
>  >  
>  >
> 
>  Interesting.  I've just seen patches slammed by subsystem maintainers 
>  before for doing things "the wrong way around" within a patchset.
> 
>  I don't remember seeing this covered in TPP, am I missing having read a 
>  guide document or is this grey area?

I just updated it.

--- tpp.txt	2006-03-04 16:32:28.000000000 -0800
+++ tpp2.txt	2006-03-04 16:33:10.000000000 -0800
@@ -1,7 +1,7 @@
 
 The perfect patch.
 akpm@osdl.org
-Updated 12 Jan 2006
+Updated 4 March 2006
 
 The latest version of this document may be found at
 http://www.zip.com.au/~akpm/linux/patches/stuff/tpp.txt
@@ -93,8 +93,8 @@
    patch should contain a standalone changelog.  This implies that you need a
    patch management system which maintains changelogs.  See below.
 
-e) Add a Signed-off-by: line, as per the Documentation/SubmittingPatches
-   file in the kernel tree.
+e) Add a Signed-off-by: line, as per section 11 of the
+   Documentation/SubmittingPatches file in the kernel tree.
 
    Signed-off-by: implies that you had some part in the developent of the
    patch, or that you handled it and passed it on to another developer for
@@ -174,8 +174,49 @@
 	done
 
 
-6: Overall
-=========
+6: Patch series
+===============
+
+a) When sending a series of patches, number them in the Subject:s thusly:
+
+	[patch 1/10] ext2: block allocation: frob the globnozzle
+	[patch 2/10] ext2: block allocation: wash the pizza
+	etc
+
+b) Some people like to introduce a patch series with an introductory email
+   which doesn't actually carry a patch, such as:
+
+	[patch 0/10] ext2: block allocation changes
+
+   Please don't do this.  There is no facility in the git tree to carry
+   changelog-only changesets such as this (or at least, we don't do that) so
+   the information in the introductory email will be lost.
+
+   So I end up copying and pasting your nice introduction into the
+   changelog for the first patch, so it gets into git.  I'll follow it with
+   the text
+
+	This patch:
+
+   and then I'll include the changelog for the first patch of the series.
+
+   It would be preferred if the patch originators were to do this.
+
+c) Try very hard to ensure that the kernel builds and runs correctly at
+   every step of the patch series.  This requirement exists because of
+   `git-bisect'.  If someone is doing a bisection search for a kernel bug and
+   they land upon your won't-compile point partway through the exercise, they
+   will be unhappy.
+
+d) If your patch series includes non-runtime-affecting things such as
+   cleanups, whitespace fixes, file renames, moving functions around, etc then
+   this work should be done in the initial patches in the series.  The
+   functional changes should come later in the series.
+
+   This is mainly so that reversion of problematic changes becomes simpler.
+
+7: Overall
+==========
 
 a) Avoid MIME and attachements if possible.  Make sure that your email
    client does not wordwrap your patch.  Make sure that your email client does


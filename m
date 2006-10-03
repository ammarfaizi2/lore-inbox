Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932341AbWJCDp2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932341AbWJCDp2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 23:45:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932339AbWJCDp2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 23:45:28 -0400
Received: from ozlabs.org ([203.10.76.45]:39075 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932341AbWJCDp1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 23:45:27 -0400
Date: Tue, 3 Oct 2006 13:45:13 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Fix spurious error on TAGS target when missing defconfig
Message-ID: <20061003034513.GA24053@localhost.localdomain>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, please apply:

Not all architectures have a file named 'defconfig' (e.g. powerpc).
However the make TAGS and make tags targets search such files for
tags, causing an error message when they don't exist.  This patch
addresses the problem by instructing xargs not to run the tags program
if there are no matching files.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: working-2.6/Makefile
===================================================================
--- working-2.6.orig/Makefile	2006-10-03 13:35:19.000000000 +1000
+++ working-2.6/Makefile	2006-10-03 13:41:08.000000000 +1000
@@ -1321,7 +1321,7 @@ define xtags
 		--langdef=kconfig \
 		--language-force=kconfig \
 		--regex-kconfig='/^[[:blank:]]*config[[:blank:]]+([[:alnum:]_]+)/\1/'; \
-	    $(all-defconfigs) | xargs $1 -a \
+	    $(all-defconfigs) | xargs -r $1 -a \
 		--langdef=dotconfig \
 		--language-force=dotconfig \
 		--regex-dotconfig='/^#?[[:blank:]]*(CONFIG_[[:alnum:]_]+)/\1/'; \
@@ -1329,7 +1329,7 @@ define xtags
 	    $(all-sources) | xargs $1 -a; \
 	    $(all-kconfigs) | xargs $1 -a \
 		--regex='/^[ \t]*config[ \t]+\([a-zA-Z0-9_]+\)/\1/'; \
-	    $(all-defconfigs) | xargs $1 -a \
+	    $(all-defconfigs) | xargs -r $1 -a \
 		--regex='/^#?[ \t]?\(CONFIG_[a-zA-Z0-9_]+\)/\1/'; \
 	else \
 	    $(all-sources) | xargs $1 -a; \

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

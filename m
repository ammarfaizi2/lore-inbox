Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264288AbTLVBVb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Dec 2003 20:21:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264285AbTLVBUj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Dec 2003 20:20:39 -0500
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:20667 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S264277AbTLVBUJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Dec 2003 20:20:09 -0500
MIME-Version: 1.0
To: torvalds@osdl.org, marcelo.tosatti@cyclades.com.br
Subject: lk-changelog.pl 0.208
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Mon_Dec_22_01_20_06_UTC_2003_0@merlin.emma.line.org>
Content-Type: text/plain; charset=US-ASCII
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 7BIT
Message-Id: <20031222012006.7C14E97558@merlin.emma.line.org>
Date: Mon, 22 Dec 2003 02:20:06 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a semi-automatic announcement.

lk-changelog.pl aka. shortlog version 0.208 has been released.

This script is used by Linus and Marcelo to rearrange and reformat BK
ChangeSet logs into a more human-readable format, and the official
repository is Parent repository is http://bktools.bkbits.net/bktools

As the script has grown large, this mail only contains a diff against
the last released version.

You can always download the full script and GPG signatures from
http://mandree.home.pages.de/linux/kernel/

My thanks go to Vitezslav Samel who has spent a lot of time on digging
out the real names for addresses sending in BK ChangeSets.

Note that your mailer must be MIME-capable to save this mail properly,
because it is in the "quoted-printable" encoding.

= <- if you see just an equality sign, but no "3D", your mailer is fine.
= <- if you see 3D on this line, then upgrade your mailer or pipe this mail
= <- into metamail.

-- 
A sh script on behalf of Matthias Andree
-------------------------------------------------------------------------
Changes since last release:

----------------------------
revision 0.208
date: 2003/12/22 01:17:09;  author: emma;  state: Exp;  lines: +9 -4
Only print ignoremerge warning if ignoremerge is really enabled.
----------------------------
revision 0.207
date: 2003/12/21 03:10:50;  author: emma;  state: Exp;  lines: +9 -3
Mark --ignoremerge deprecated, point towards bk changes -d'$unless(:MERGE:)' instead.
----------------------------
revision 0.206
date: 2003/12/20 23:32:45;  author: emma;  state: Exp;  lines: +5 -2
Resolve conflict with Linus' version.
=============================================================================
Index: lk-changelog.pl
===================================================================
RCS file: /var/CVS/lk-changelog/lk-changelog.pl,v
retrieving revision 0.206
retrieving revision 0.208
diff -u -r0.206 -r0.208
--- lk-changelog.pl	20 Dec 2003 23:32:45 -0000	0.206
+++ lk-changelog.pl	22 Dec 2003 01:17:09 -0000	0.208
@@ -8,7 +8,7 @@
 #			Tomas Szepe <szepe@pinerecords.com>
 #			Vitezslav Samel <samel@mail.cz>
 #
-# $Id: lk-changelog.pl,v 0.206 2003/12/20 23:32:45 emma Exp $
+# $Id: lk-changelog.pl,v 0.208 2003/12/22 01:17:09 emma Exp $
 # ----------------------------------------------------------------------
 # Distribution of this script is permitted under the terms of the
 # GNU General Public License (GNU GPL) v2.
@@ -2062,6 +2062,13 @@
 # --count implies --compress
 if ($opt{count}) { $opt{compress} = 1; }
 
+# --ignoremerge is deprecated
+if ($opt{ignoremerge}) {
+    print STDERR "--ignoremerge is deprecated. Replacement:\n"
+    . 'bk changes -d\'$unless(:MERGE:){<:P:@:HOST:>\n $each(:C:){\t(:C:)\n}\n\''
+    . "\n";
+}
+
 # Set the sort function
 $namesortfunc = \&caseicmp;
 if ($opt{'by-surname'}) { $namesortfunc = \&caseicmpbysurname; }
@@ -2150,6 +2157,12 @@
 __END__
 # --------------------------------------------------------------------
 # $Log: lk-changelog.pl,v $
+# Revision 0.208  2003/12/22 01:17:09  emma
+# Only print ignoremerge warning if ignoremerge is really enabled.
+#
+# Revision 0.207  2003/12/21 03:10:50  emma
+# Mark --ignoremerge deprecated, point towards bk changes -d'$unless(:MERGE:)' instead.
+#
 # Revision 0.206  2003/12/20 23:32:45  emma
 # Resolve conflict with Linus' version.
 #
@@ -2874,8 +2887,6 @@
                      omit "email address" when a name is known
      --[no]obfuscate
                      obfuscate "email address" in output
-     --[no]ignoremerge
-                     suppress "Merge bk://..." changelogs.
 
      --mode=MODE     specify the output format (use --man to find out more)
      --width[=WIDTH] specify the line length, if omitted: $COLUMNS or 80.


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263487AbTDNPhQ (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 11:37:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263483AbTDNPhQ (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 11:37:16 -0400
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:38148 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S263482AbTDNPhN (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 11:37:13 -0400
Date: Mon, 14 Apr 2003 17:49:01 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: Zack Brown <zbrown@tumblerings.org>
Cc: linux-kernel@vger.kernel.org, Matthias Andree <matthias.andree@gmx.de>
Subject: Re: lk-changelog.pl 0.96
Message-ID: <20030414154901.GC8125@merlin.emma.line.org>
Mail-Followup-To: Zack Brown <zbrown@tumblerings.org>,
	linux-kernel@vger.kernel.org
References: <20030413104943.433A37EBE4@merlin.emma.line.org> <20030413144218.GB21855@renegade> <20030413162338.GC22268@merlin.emma.line.org> <20030413170951.GC21855@renegade>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030413170951.GC21855@renegade>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Apr 2003, Zack Brown wrote:

> Too bad for me, I was hoping to use that data structure as a complete list
> of email -> name translations for changelog entries. Maybe you could
> include them anyway as commented out entries in the data structure? That
> would give your script the added benefit of being harvestable for other
> purposes, but wouldn't sacrifice the regex speed enhancements.

How about this patch? Taken from CVS. Have fun,

Index: lk-changelog.pl
===================================================================
RCS file: /var/CVS/lk-changelog/lk-changelog.pl,v
retrieving revision 0.96
retrieving revision 0.98
diff -u -r0.96 -r0.98
--- lk-changelog.pl	13 Apr 2003 10:46:57 -0000	0.96
+++ lk-changelog.pl	14 Apr 2003 15:47:56 -0000	0.98
@@ -8,7 +8,7 @@
 #			Tomas Szepe <szepe@pinerecords.com>
 #			Vitezslav Samel <samel@mail.cz>
 #
-# $Id: lk-changelog.pl,v 0.96 2003/04/13 10:46:57 emma Exp $
+# $Id: lk-changelog.pl,v 0.98 2003/04/14 15:47:56 emma Exp $
 # ----------------------------------------------------------------------
 # Distribution of this script is permitted under the terms of the
 # GNU General Public License (GNU GPL) v2.
@@ -88,6 +88,20 @@
 #
 # Unless otherwise noted, the addresses below have been obtained using
 # lbdb.
+my @addresses_handled_in_regexp = (
+'alan:hraefn.swansea.linux.org.uk' => 'Alan Cox',
+'alan:irongate.swansea.linux.org.uk' => 'Alan Cox',
+'torvalds:athlon.transmeta.com' => 'Linus Torvalds',
+'torvalds:home.transmeta.com' => 'Linus Torvalds',
+'torvalds:kiwi.transmeta.com' => 'Linus Torvalds',
+'torvalds:penguin.transmeta.com' => 'Linus Torvalds',
+'torvalds:tove.transmeta.com' => 'Linus Torvalds',
+'torvalds:transmeta.com' => 'Linus Torvalds',
+'###############################' => '###############'
+);
+
+undef @addresses_handled_in_regexp;
+
 my %addresses = (
 'aaron.baranoff:tsc.tdk.com' => 'Aaron Baranoff',
 'abraham:2d3d.co.za' => 'Abraham van der Merwe',
@@ -396,7 +410,7 @@
 'glee:gnupilgrims.org' => 'Geoffrey Lee', # lbdb
 'gnb:alphalink.com.au' => 'Greg Banks',
 'go:turbolinux.co.jp' => 'Go Taniguchi',
-'gone:us.ibm.com' => 'Patricia Guaghen',
+'gone:us.ibm.com' => 'Patricia Gaughen',
 'gotom:debian.or.jp' => 'Goto Masanori', # from shortlog
 'gphat:cafes.net' => 'Cory Watson',
 'greearb:candelatech.com' => 'Ben Greear',
@@ -1595,6 +1609,13 @@
 __END__
 # --------------------------------------------------------------------
 # $Log: lk-changelog.pl,v $
+# Revision 0.98  2003/04/14 15:47:56  emma
+# Doing Zack Brown a favor and archiving addresses that are now handled by regexps
+# in a separate list.
+#
+# Revision 0.97  2003/04/13 11:33:27  emma
+# Correct Patricia Gaughen's name (was Gua...). Found by Geoffrey Lee.
+#
 # Revision 0.96  2003/04/13 10:46:57  emma
 # 100 (one hundred) new addresses and 17 corrections by Zack Brown.
 #

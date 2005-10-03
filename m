Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932418AbVJCVCi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932418AbVJCVCi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 17:02:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932423AbVJCVCi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 17:02:38 -0400
Received: from smtp-101-monday.noc.nerim.net ([62.4.17.101]:61202 "EHLO
	mallaury.nerim.net") by vger.kernel.org with ESMTP id S932418AbVJCVCi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 17:02:38 -0400
Date: Mon, 3 Oct 2005 23:02:35 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Greg KH <greg@kroah.com>, Paul Jackson <pj@sgi.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Jeff Garzik <jgarzik@pobox.com>, Randy Dunlap <rdunlap@xenotime.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Document patch subject line better
Message-Id: <20051003230235.55516671.khali@linux-fr.org>
In-Reply-To: <20051003160452.GA9107@kroah.com>
References: <20051003072910.14726.10100.sendpatchset@jackhammer.engr.sgi.com>
	<Pine.LNX.4.64.0510030805380.31407@g5.osdl.org>
	<20051003085414.05468a2b.pj@sgi.com>
	<20051003160452.GA9107@kroah.com>
X-Mailer: Sylpheed version 2.0.1 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg, Paul,

> > Ideally either I should change my patch sending process, or I should
> > change quilt. 
> 
> Change quilt.  I have a horrible patch to my local copy of quilt that
> adds this line, it's not hard to do.
> 
> I'll work on cleaning it up and getting the change into the upstream
> version of quilt this week.

I wasn't aware of the problem, this clearly sounds like a bug to me. I
guess that picking "---" as a separator wasn't exactly a subtle choice,
but still...

The following patch fixes it for me:

Index: scripts/patchfns.in
===================================================================
RCS file: /cvsroot/quilt/quilt/scripts/patchfns.in,v
retrieving revision 1.75
diff -u -r1.75 patchfns.in
--- scripts/patchfns.in	18 Sep 2005 16:02:31 -0000	1.75
+++ scripts/patchfns.in	3 Oct 2005 20:50:23 -0000
@@ -612,7 +612,7 @@
 patch_header()
 {
 	awk '
-	$1 == "***" || $1 == "---" \
+	($1 == "***" || $1 == "---") && NF > 1 \
 		{ exit }
 	/^Index:[ \t]|^diff[ \t]|^==*$|^RCS file: |^retrieving revision [0-9]+(\.[0-9]+)*$/ \
 		{ eat = eat $0 "\n"
@@ -628,7 +628,7 @@
 	/^Index:[ \t]|^diff[ \t]|^==*$|^RCS file: |^retrieving revision [0-9]+(\.[0-9]+)*$/ \
 		{ eat = eat $0 "\n"
 		  next }
-	$1 == "***" || $1 == "---" \
+	($1 == "***" || $1 == "---") && NF > 1 \
 		{ body=1 }
 	body	{ print eat $0
 		  eat = ""


Comments?

This only prevents quilt from stripping the "---" line, it does NOT
add the line if it's not there. Doing so would require template
support, I know many users are interested and a few implementations
exist, waiting to be merged upstream, but it's not there right now.

Greg, if you have a better fix, just send it to the quilt-dev and I'll
get it applied.

-- 
Jean Delvare

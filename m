Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932317AbVJDDMy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932317AbVJDDMy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 23:12:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932338AbVJDDMy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 23:12:54 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:19691 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S932317AbVJDDMx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 23:12:53 -0400
Date: Mon, 3 Oct 2005 20:12:37 -0700
From: Paul Jackson <pj@sgi.com>
To: Greg KH <greg@kroah.com>
Cc: khali@linux-fr.org, torvalds@osdl.org, akpm@osdl.org, jgarzik@pobox.com,
       rdunlap@xenotime.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Document patch subject line better
Message-Id: <20051003201237.4c4b16f1.pj@sgi.com>
In-Reply-To: <20051003212200.GA28300@kroah.com>
References: <20051003072910.14726.10100.sendpatchset@jackhammer.engr.sgi.com>
	<Pine.LNX.4.64.0510030805380.31407@g5.osdl.org>
	<20051003085414.05468a2b.pj@sgi.com>
	<20051003160452.GA9107@kroah.com>
	<20051003230235.55516671.khali@linux-fr.org>
	<20051003212200.GA28300@kroah.com>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg wrote (of the "---" line):
> No, my fix just always added it.

My preference would be to only add the "---" line
when starting with a brand new, empty patch file.

If an existing version of the patch file exists,
then just copy over the entire header (up to the
first actual patch) as is, no change.  If I choose
to edit the patch file header and remove the "---"
line, or do any other edit to it (short of creating
a line that looks like the start of a patch) then
quilt should respect that.

The following patch seems to accomplish this.

--- refresh.old	2005-10-03 17:31:41.000000000 -0700
+++ refresh	2005-10-03 20:02:04.000000000 -0700
@@ -247,7 +247,9 @@ fi
 
 mkdir -p $(dirname $patch_file)
 
-if ! cat_file $patch_file | patch_header > $tmp_header
+[ -s $patch_file ] || echo -e "\n---\n" > $tmp_header
+
+if ! cat_file $patch_file | patch_header >> $tmp_header
 then
 	die 1
 fi


-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401

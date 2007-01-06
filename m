Return-Path: <linux-kernel-owner+w=401wt.eu-S1751182AbXAFGkN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751182AbXAFGkN (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 01:40:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751187AbXAFGkN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 01:40:13 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:60898 "EHLO
	rgminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751182AbXAFGkL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 01:40:11 -0500
Date: Fri, 5 Jan 2007 22:39:04 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>
Subject: [PATCH] kernel-doc: allow a little whitespace
Message-Id: <20070105223904.06783a48.randy.dunlap@oracle.com>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed 2.3.0 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Whitelist: TRUE
X-Whitelist: TRUE
X-Brightmail-Tracker: AAAAAQAAAAI=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <randy.dunlap@oracle.com>

In kernel-doc syntax, be a little flexible:  allow whitespace between
a function parameter name and the colon that must follow it, such as:
	@pdev : PCI device to unplug

(This allows lots of megaraid kernel-doc to work without tons of
editing.)

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 Documentation/kernel-doc-nano-HOWTO.txt |    2 +-
 scripts/kernel-doc                      |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

--- linux-2620-rc3g4.orig/scripts/kernel-doc
+++ linux-2620-rc3g4/scripts/kernel-doc
@@ -83,7 +83,7 @@ use strict;
 #  * my_function
 #  **/
 #
-# If the Description: header tag is ommitted, then there must be a blank line
+# If the Description: header tag is omitted, then there must be a blank line
 # after the last parameter specification.
 # e.g.
 # /**
@@ -265,7 +265,7 @@ my $doc_start = '^/\*\*\s*$'; # Allow wh
 my $doc_end = '\*/';
 my $doc_com = '\s*\*\s*';
 my $doc_decl = $doc_com.'(\w+)';
-my $doc_sect = $doc_com.'(['.$doc_special.']?[\w ]+):(.*)';
+my $doc_sect = $doc_com.'(['.$doc_special.']?[\w\s]+):(.*)';
 my $doc_content = $doc_com.'(.*)';
 my $doc_block = $doc_com.'DOC:\s*(.*)?';
 
--- linux-2620-rc3g4.orig/Documentation/kernel-doc-nano-HOWTO.txt
+++ linux-2620-rc3g4/Documentation/kernel-doc-nano-HOWTO.txt
@@ -101,7 +101,7 @@ The format of the block comment is like 
 
 /**
  * function_name(:)? (- short description)?
-(* @parameterx: (description of parameter x)?)*
+(* @parameterx(space)*: (description of parameter x)?)*
 (* a blank line)?
  * (Description:)? (Description of function)?
  * (section header: (section description)? )*


---

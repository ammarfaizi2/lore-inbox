Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751550AbWF3WjY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751550AbWF3WjY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 18:39:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751549AbWF3WjY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 18:39:24 -0400
Received: from xenotime.net ([66.160.160.81]:61933 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751513AbWF3WjY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 18:39:24 -0400
Date: Fri, 30 Jun 2006 15:42:10 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>, tali@admingilde.org
Subject: [PATCH] kernel-doc: consistent text/man mode output
Message-Id: <20060630154210.98e6ad03.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Add a space between data type and struct field name in man-mode
bitfield struct output so that they don't run together.

For text-mode struct output, print the struct 'purpose' or
short description (as done in man-mode output).

For text-mode enum output, print the enum 'purpose' or
short description (as done in man-mode output).

For text-mode typedfe output, print the typedef 'purpose' or
short description (as done in man-mode output).

---
 scripts/kernel-doc |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

--- linux-2617-g13.orig/scripts/kernel-doc
+++ linux-2617-g13/scripts/kernel-doc
@@ -1056,7 +1056,8 @@ sub output_struct_man(%) {
 	    # pointer-to-function
 	    print ".BI \"    ".$1."\" ".$parameter." \") (".$2.")"."\"\n;\n";
 	} elsif ($type =~ m/^(.*?)\s*(:.*)/) {
-	    print ".BI \"    ".$1."\" ".$parameter.$2." \""."\"\n;\n";
+	    # bitfield
+	    print ".BI \"    ".$1."\ \" ".$parameter.$2." \""."\"\n;\n";
 	} else {
 	    $type =~ s/([^\*])$/$1 /;
 	    print ".BI \"    ".$type."\" ".$parameter." \""."\"\n;\n";
@@ -1172,6 +1173,7 @@ sub output_enum_text(%) {
     my $count;
     print "Enum:\n\n";
 
+    print "enum ".$args{'enum'}." - ".$args{'purpose'}."\n\n";
     print "enum ".$args{'enum'}." {\n";
     $count = 0;
     foreach $parameter (@{$args{'parameterlist'}}) {
@@ -1200,7 +1202,7 @@ sub output_typedef_text(%) {
     my $count;
     print "Typedef:\n\n";
 
-    print "typedef ".$args{'typedef'}."\n";
+    print "typedef ".$args{'typedef'}." - ".$args{'purpose'}."\n";
     output_section_text(@_);
 }
 
@@ -1209,7 +1211,7 @@ sub output_struct_text(%) {
     my %args = %{$_[0]};
     my ($parameter);
 
-    print $args{'type'}." ".$args{'struct'}.":\n\n";
+    print $args{'type'}." ".$args{'struct'}." - ".$args{'purpose'}."\n\n";
     print $args{'type'}." ".$args{'struct'}." {\n";
     foreach $parameter (@{$args{'parameterlist'}}) {
 	if ($parameter =~ /^#/) {


---

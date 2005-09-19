Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932690AbVISVGy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932690AbVISVGy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 17:06:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932691AbVISVGy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 17:06:54 -0400
Received: from host-84-9-200-79.bulldogdsl.com ([84.9.200.79]:2439 "EHLO
	aeryn.fluff.org.uk") by vger.kernel.org with ESMTP id S932690AbVISVGx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 17:06:53 -0400
Date: Mon, 19 Sep 2005 22:06:45 +0100
From: Ben Dooks <ben-linux@fluff.org>
To: linux-kernel@vger.kernel.org
Cc: patch-out@fluff.rog
Subject: [PATCH] scripts - use $OBJDUMP to get correct objdump (cross compile)
Message-ID: <20050919210645.GA20669@home.fluff.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="jI8keyz6grp/JLjh"
Content-Disposition: inline
X-Disclaimer: I speak for me, myself, and the other one of me.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The scripts for `make buildcheck` are executing
objdump straight, which is wrong if the system
is using `make CROSS_COMPILE=....`. 

Change the scripts to use $OBJDUMP passed from
the Makefile's environment, so that the correct
objdump is used, and the symbols are printed
correctly

Signed-off-by: Ben Dooks <ben-linux@fluff.org>

diff -urN -X ../dontdiff linux-2.6.13-simtec1/scripts/reference_discarded.pl linux-2.6.13-simtec2/scripts/reference_discarded.pl
--- linux-2.6.13-simtec1/scripts/reference_discarded.pl	2005-09-06 12:28:18.000000000 +0100
+++ linux-2.6.13-simtec2/scripts/reference_discarded.pl	2005-09-19 22:02:07.000000000 +0100
@@ -18,7 +18,7 @@
 $| = 1;
 
 # printf("Finding objects, ");
-open(OBJDUMP_LIST, "find . -name '*.o' | xargs objdump -h |") || die "getting objdump list failed";
+open(OBJDUMP_LIST, "find . -name '*.o' | xargs \$OBJDUMP -h |") || die "getting objdump list failed";
 while (defined($line = <OBJDUMP_LIST>)) {
 	chomp($line);
 	if ($line =~ /:\s+file format/) {
@@ -74,7 +74,7 @@
 $errorcount = 0;
 foreach $object (keys(%object)) {
 	my $from;
-	open(OBJDUMP, "objdump -r $object|") || die "cannot objdump -r $object";
+	open(OBJDUMP, "\$OBJDUMP -r $object|") || die "cannot objdump -r $object";
 	while (defined($line = <OBJDUMP>)) {
 		chomp($line);
 		if ($line =~ /RELOCATION RECORDS FOR /) {
diff -urN -X ../dontdiff linux-2.6.13-simtec1/scripts/reference_init.pl linux-2.6.13-simtec2/scripts/reference_init.pl
--- linux-2.6.13-simtec1/scripts/reference_init.pl	2005-09-06 12:28:18.000000000 +0100
+++ linux-2.6.13-simtec2/scripts/reference_init.pl	2005-09-19 22:00:52.000000000 +0100
@@ -26,7 +26,7 @@
 $| = 1;
 
 printf("Finding objects, ");
-open(OBJDUMP_LIST, "find . -name '*.o' | xargs objdump -h |") || die "getting objdump list failed";
+open(OBJDUMP_LIST, "find . -name '*.o' | xargs \$OBJDUMP -h |") || die "getting objdump list failed";
 while (defined($line = <OBJDUMP_LIST>)) {
 	chomp($line);
 	if ($line =~ /:\s+file format/) {
@@ -81,7 +81,7 @@
 printf("Scanning objects\n");
 foreach $object (sort(keys(%object))) {
 	my $from;
-	open(OBJDUMP, "objdump -r $object|") || die "cannot objdump -r $object";
+	open(OBJDUMP, "\$OBJDUMP -r $object|") || die "cannot objdump -r $object";
 	while (defined($line = <OBJDUMP>)) {
 		chomp($line);
 		if ($line =~ /RELOCATION RECORDS FOR /) {

--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="scripts-buildcheck-pass-objdump.patch"

diff -urN -X ../dontdiff linux-2.6.13-simtec1/scripts/reference_discarded.pl linux-2.6.13-simtec2/scripts/reference_discarded.pl
--- linux-2.6.13-simtec1/scripts/reference_discarded.pl	2005-09-06 12:28:18.000000000 +0100
+++ linux-2.6.13-simtec2/scripts/reference_discarded.pl	2005-09-19 22:02:07.000000000 +0100
@@ -18,7 +18,7 @@
 $| = 1;
 
 # printf("Finding objects, ");
-open(OBJDUMP_LIST, "find . -name '*.o' | xargs objdump -h |") || die "getting objdump list failed";
+open(OBJDUMP_LIST, "find . -name '*.o' | xargs \$OBJDUMP -h |") || die "getting objdump list failed";
 while (defined($line = <OBJDUMP_LIST>)) {
 	chomp($line);
 	if ($line =~ /:\s+file format/) {
@@ -74,7 +74,7 @@
 $errorcount = 0;
 foreach $object (keys(%object)) {
 	my $from;
-	open(OBJDUMP, "objdump -r $object|") || die "cannot objdump -r $object";
+	open(OBJDUMP, "\$OBJDUMP -r $object|") || die "cannot objdump -r $object";
 	while (defined($line = <OBJDUMP>)) {
 		chomp($line);
 		if ($line =~ /RELOCATION RECORDS FOR /) {
diff -urN -X ../dontdiff linux-2.6.13-simtec1/scripts/reference_init.pl linux-2.6.13-simtec2/scripts/reference_init.pl
--- linux-2.6.13-simtec1/scripts/reference_init.pl	2005-09-06 12:28:18.000000000 +0100
+++ linux-2.6.13-simtec2/scripts/reference_init.pl	2005-09-19 22:00:52.000000000 +0100
@@ -26,7 +26,7 @@
 $| = 1;
 
 printf("Finding objects, ");
-open(OBJDUMP_LIST, "find . -name '*.o' | xargs objdump -h |") || die "getting objdump list failed";
+open(OBJDUMP_LIST, "find . -name '*.o' | xargs \$OBJDUMP -h |") || die "getting objdump list failed";
 while (defined($line = <OBJDUMP_LIST>)) {
 	chomp($line);
 	if ($line =~ /:\s+file format/) {
@@ -81,7 +81,7 @@
 printf("Scanning objects\n");
 foreach $object (sort(keys(%object))) {
 	my $from;
-	open(OBJDUMP, "objdump -r $object|") || die "cannot objdump -r $object";
+	open(OBJDUMP, "\$OBJDUMP -r $object|") || die "cannot objdump -r $object";
 	while (defined($line = <OBJDUMP>)) {
 		chomp($line);
 		if ($line =~ /RELOCATION RECORDS FOR /) {

--jI8keyz6grp/JLjh--

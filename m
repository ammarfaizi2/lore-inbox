Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261803AbVCGVZg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261803AbVCGVZg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 16:25:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261359AbVCGVZC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 16:25:02 -0500
Received: from mail.fh-wedel.de ([213.39.232.198]:58777 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S261529AbVCGUuR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 15:50:17 -0500
Date: Mon, 7 Mar 2005 21:50:16 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Andrew Morton <akpm@osdl.org>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] Implement Computer Aided Ignorance
Message-ID: <20050307205016.GB26318@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jörn

-- 
Happiness isn't having what you want, it's wanting what you have.
-- unknown

Implement Computer Aided Ignorance (CAI) for Randy:
o Only negative numbers >= -256MiB are turned positive.
o Numbers above 256MiB (or below -256MiB) are ignored.

This specifically catches a case when 0xc000_0000 is added/removed.

Signed-off-by: Jörn Engel <joern@wohnheim.fh-wedel.de>
---

 scripts/checkstack.pl |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

--- linux-2.6.11cow/scripts/checkstack.pl~randy_check	2004-12-28 17:31:38.000000000 +0100
+++ linux-2.6.11cow/scripts/checkstack.pl	2005-03-07 00:39:44.000000000 +0100
@@ -90,11 +90,12 @@ while (my $line = <STDIN>) {
 		my $size = $1;
 		$size = hex($size) if ($size =~ /^0x/);
 
-		if ($size > 0x80000000) {
+		if ($size > 0xf0000000) {
 			$size = - $size;
 			$size += 0x80000000;
 			$size += 0x80000000;
 		}
+		next if ($size > 0x10000000);
 
 		next if $line !~ m/^($xs*)/;
 		my $addr = $1;

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268696AbUI2QTM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268696AbUI2QTM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 12:19:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268700AbUI2QTL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 12:19:11 -0400
Received: from baikonur.stro.at ([213.239.196.228]:57013 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S268696AbUI2QTD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 12:19:03 -0400
Date: Wed, 29 Sep 2004 18:19:05 +0200
From: maks attems <debian@sternwelten.at>
To: linux-kernel@vger.kernel.org
Cc: marcelo.tosatti@cyclades.com, sam@ravnborg.org
Subject: [patch 2.4] menuconfig fix crash due to infinite recursion
Message-ID: <20040929161905.GK1835@stro.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gawk(1) tells that getline "returns 0 on end of file and -1 on an error."
in current script for menuconfig if getline has an error,
it is still treated as true.

2.6 don't use that script anymore.
fix suggestion from Aharon Robbins <arnold@skeeve.com>
debian bts has 2 bugs open concerning that issue,
this is the one containing belows fix:
http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=147469

[TM] tested.
menuconfig still works for me. ;)


--- a/scripts/Menuconfig	2002-08-03 02:39:46.000000000 +0200
+++ b/scripts/Menuconfig	2004-09-29 18:00:29.000000000 +0200
@@ -714,7 +714,7 @@ BEGIN {
 
 function parser(ifile,menu) {
 
-	while (getline <ifile) {
+	while ((getline < ifile) > 0) {
 		if ($1 == "mainmenu_option") {
 			comment_is_option = "1"
 		}

--
maks
kernel janitor  	http://janitor.kernelnewbies.org/


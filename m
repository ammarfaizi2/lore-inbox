Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269441AbUI3Tdx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269441AbUI3Tdx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 15:33:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269442AbUI3Tdx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 15:33:53 -0400
Received: from baikonur.stro.at ([213.239.196.228]:13247 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S269441AbUI3Tdu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 15:33:50 -0400
Date: Thu, 30 Sep 2004 21:33:45 +0200
From: maximilian attems <janitor@sternwelten.at>
To: linux-kernel@vger.kernel.org
Cc: marcelo.tosatti@cyclades.com, sam@ravnborg.org, arnold@skeeve.com
Subject: Re: [patch 2.4] menuconfig fix crash due to infinite recursion
Message-ID: <20040930193345.GA1848@stro.at>
References: <20040929161905.GK1835@stro.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040929161905.GK1835@stro.at>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 gawk(1) tells that getline "returns 0 on end of file and -1 on an error."
 in current script for menuconfig if getline has an error,
 it is still treated as true, fix _both_ of its invocations.
 
 2.6 don't use that script anymore.
 fix suggestion from Aharon Robbins <arnold@skeeve.com>
 debian bts has 2 bugs open concerning that issue,
 this is the one containing belows fix:
 http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=147469
 
 [TM] tested.
 menuconfig still works for me. ;)
 


--- a/scripts/Menuconfig	2002-08-03 02:39:46.000000000 +0200
+++ b/scripts/Menuconfig	2004-09-30 21:29:21.000000000 +0200
@@ -714,7 +714,7 @@ BEGIN {
 
 function parser(ifile,menu) {
 
-	while (getline <ifile) {
+	while ((getline <ifile) > 0) {
 		if ($1 == "mainmenu_option") {
 			comment_is_option = "1"
 		}
@@ -761,7 +761,7 @@ BEGIN {
 
 function parser(ifile,menu) {
 
-	while (getline <ifile) {
+	while ((getline <ifile) > 0) {
 		if ($0 ~ /^#|$MAKE|mainmenu_name/) {
 			printf("") >>menu
 		}
 
 
--
maks
kernel janitor  	http://janitor.kernelnewbies.org/


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264367AbUEDNlu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264367AbUEDNlu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 09:41:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264369AbUEDNlu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 09:41:50 -0400
Received: from ns.tasking.nl ([195.193.207.2]:22539 "EHLO ns.tasking.nl")
	by vger.kernel.org with ESMTP id S264367AbUEDNlp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 09:41:45 -0400
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
X-Newsreader: knews 1.0b.1
Reply-To: dick.streefland@altium.nl (Dick Streefland)
Organization: Altium BV
X-Face: "`*@3nW;mP[=Z(!`?W;}cn~3M5O_/vMjX&Pe!o7y?xi@;wnA&Tvx&kjv'N\P&&5Xqf{2CaT 9HXfUFg}Y/TT^?G1j26Qr[TZY%v-1A<3?zpTYD5E759Q?lEoR*U1oj[.9\yg_o.~O.$wj:t(B+Q_?D XX57?U,#b,iM$[zX'I(!'VCQM)N)x~knSj>M*@l}y9(tK\rYwdv%~+&*jV"epphm>|q~?ys:g:K#R" 2PuAzy-N9cKM<Ml/%yPQxpq"Ttm{GzBn-*:;619QM2HLuRX4]~361+,[uFp6f"JF5R`y
From: spam@altium.nl (Dick Streefland)
Subject: [PATCH] update Documentation/md.txt
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Host: 172.17.1.66
Message-ID: <4769.40979d55.46f00@altium.nl>
Date: Tue, 04 May 2004 13:40:37 -0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch documents the currently undocumented raid= kernel
parameter:

--- linux-2.6.5/Documentation/md.txt.orig	2003-12-18 03:59:05.000000000 +0100
+++ linux-2.6.5/Documentation/md.txt	2004-05-04 15:35:34.000000000 +0200
@@ -2,6 +2,8 @@ Tools that manage md devices can be foun
    http://www.<country>.kernel.org/pub/linux/utils/raid/....
 
 
+Boot time assembly of RAID arrays
+---------------------------------
 
 You can boot with your md device with the following kernel command
 lines:
@@ -11,6 +13,8 @@ for old raid arrays without persistent s
 
 for raid arrays with persistent superblocks
   md=<md device no.>,dev0,dev1,...,devn
+or, to assemble a partitionable array:
+  md=d<md device no.>,dev0,dev1,...,devn
   
 md device no. = the number of the md device ... 
               0 means md0, 
@@ -34,7 +38,22 @@ A possible loadlin line (Harald Hoyer <H
 
 e:\loadlin\loadlin e:\zimage root=/dev/md0 md=0,0,4,0,/dev/hdb2,/dev/hdc3 ro
 
--------------------------------
+
+Boot time autodetection of RAID arrays
+--------------------------------------
+
+When md is compiled into the kernel (not as module), partitions of
+type 0xfd are scanned and automatically assembled into RAID arrays.
+This autodetection may be suppressed with the kernel parameter
+"raid=noautodetect".
+
+The kernel parameter "raid=partitionable" (or "raid=part") means
+that all auto-detected arrays are assembled as partitionable.
+
+
+Superblock formats
+------------------
+
 The md driver can support a variety of different superblock formats.
 (It doesn't yet, but it can)
 
@@ -82,7 +101,7 @@ array using HOT_REMOVE_DISK.
 
 
 Specific Rules that apply to format-0 super block arrays, and
-       arrays with no superblock (non-presistant).
+       arrays with no superblock (non-persistant).
 -------------------------------------------------------------
 
 An array can be 'created' by describing the array (level, chunksize

-- 
Dick Streefland                      ////                      Altium BV
dick.streefland@altium.nl           (@ @)          http://www.altium.com
--------------------------------oOO--(_)--OOo---------------------------


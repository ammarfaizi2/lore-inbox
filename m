Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262956AbVDHVLu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262956AbVDHVLu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 17:11:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262957AbVDHVLu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 17:11:50 -0400
Received: from cc15467-a.groni1.gr.home.nl ([82.73.222.20]:10682 "HELO
	boetes.org") by vger.kernel.org with SMTP id S262956AbVDHVLk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 17:11:40 -0400
Date: Fri, 8 Apr 2005 23:11:38 +0159
From: Han Boetes <han@mijncomputer.nl>
To: linux-kernel@vger.kernel.org
Cc: Martin Schlemmer <azarah@nosferatu.za.org>
Subject: patch to fix bashism
Message-ID: <20050408211200.GX15412@boetes.org>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Martin Schlemmer <azarah@nosferatu.za.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch fixes a three bashisms in
scripts/gen_initramfs_list.sh;

I'm not sure of the intention of the second change (local
name=...). So it's very well possible that:

+       local name="${location%/$srcdir}"

is more appropriate.


--- scripts/gen_initramfs_list.sh.orig	2005-03-27 14:53:15.628883408 +0200
+++ scripts/gen_initramfs_list.sh	2005-03-27 15:12:20.093898280 +0200
@@ -1,4 +1,7 @@
-#!/bin/bash
+#!/bin/sh
+
+# script is sourced, the shebang is ignored.
+
 # Copyright (C) Martin Schlemmer <azarah@nosferatu.za.org>
 # Released under the terms of the GNU GPL
 #
@@ -56,9 +59,9 @@
 
 parse() {
 	local location="$1"
-	local name="${location/${srcdir}//}"
+	local name="${location#$srcdir/}"
 	# change '//' into '/'
-	name="${name//\/\///}"
+	name=`echo $name|sed -e 's|//|/|g'`
 	local mode="$2"
 	local uid="$3"
 	local gid="$4"
@@ -68,8 +71,8 @@
 	[ "$gid" -eq "$root_gid" ] && gid=0
 	local str="${mode} ${uid} ${gid}"
 
-	[ "${ftype}" == "invalid" ] && return 0
-	[ "${location}" == "${srcdir}" ] && return 0
+	[ "${ftype}" = "invalid" ] && return 0
+	[ "${location}" = "${srcdir}" ] && return 0
 
 	case "${ftype}" in
 		"file")



# Han

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262651AbVAPXr7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262651AbVAPXr7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 18:47:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262650AbVAPXr7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 18:47:59 -0500
Received: from fire.osdl.org ([65.172.181.4]:61079 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S262652AbVAPXrt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 18:47:49 -0500
Message-ID: <41EAFB64.6010101@osdl.org>
Date: Sun, 16 Jan 2005 15:40:20 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
CC: akpm <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] scripts/reference*.pl - treat built-in.o as conglomerate
References: <15580.1105905034@ocs3.ocs.com.au>
In-Reply-To: <15580.1105905034@ocs3.ocs.com.au>
Content-Type: multipart/mixed;
 boundary="------------050507070705000407060600"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050507070705000407060600
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Keith Owens wrote:
> scripts/reference*.pl - treat built-in.o as conglomerate.  Ignore
> references from altinstructions to init text/data.
> 
> Signed-off-by: Keith Owens <kaos@ocs.com.au>

> +		if ($comment =~ /GCC\:.*GCC\:/m || $object =~ /built-in.\o/) {
s|built-in.\o|built-in\.o|

Corrected patch is attached.
---

--------------050507070705000407060600
Content-Type: text/x-patch;
 name="scripts_referenced.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="scripts_referenced.patch"

scripts/reference*.pl - treat built-in.o as conglomerate.  Ignore
references from altinstructions to init text/data.

Signed-off-by: Keith Owens <kaos@ocs.com.au>

Index: 2.6.10/scripts/reference_discarded.pl
===================================================================
--- 2.6.10.orig/scripts/reference_discarded.pl	2004-10-19 07:54:07.000000000 +1000
+++ 2.6.10/scripts/reference_discarded.pl	2005-01-16 17:13:03.997955187 +1100
@@ -62,7 +62,7 @@ foreach $object (keys(%object)) {
 		$l = read(OBJECT, $comment, $size);
 		die "read $size bytes from $object .comment failed" if ($l != $size);
 		close(OBJECT);
-		if ($comment =~ /GCC\:.*GCC\:/m) {
+		if ($comment =~ /GCC\:.*GCC\:/m || $object =~ /built-in\.o/) {
 			++$ignore;
 			delete($object{$object});
 		}
Index: 2.6.10/scripts/reference_init.pl
===================================================================
--- 2.6.10.orig/scripts/reference_init.pl	2004-12-25 10:26:19.000000000 +1100
+++ 2.6.10/scripts/reference_init.pl	2005-01-16 17:12:50.449024044 +1100
@@ -70,7 +70,7 @@ foreach $object (keys(%object)) {
 		$l = read(OBJECT, $comment, $size);
 		die "read $size bytes from $object .comment failed" if ($l != $size);
 		close(OBJECT);
-		if ($comment =~ /GCC\:.*GCC\:/m) {
+		if ($comment =~ /GCC\:.*GCC\:/m || $object =~ /built-in\.o/) {
 			++$ignore;
 			delete($object{$object});
 		}
@@ -96,6 +96,7 @@ foreach $object (sort(keys(%object))) {
 		     $from !~ /\.pci_fixup_header$/ &&
 		     $from !~ /\.pci_fixup_final$/ &&
 		     $from !~ /\__param$/ &&
+		     $from !~ /\.altinstructions/ &&
 		     $from !~ /\.debug_/)) {
 			printf("Error: %s %s refers to %s\n", $object, $from, $line);
 		}


---

--------------050507070705000407060600--

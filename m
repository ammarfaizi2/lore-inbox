Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262618AbVAEVuS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262618AbVAEVuS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 16:50:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262614AbVAEVrn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 16:47:43 -0500
Received: from mail.portrix.net ([212.202.157.208]:22754 "EHLO
	zoidberg.portrix.net") by vger.kernel.org with ESMTP
	id S262609AbVAEVnb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 16:43:31 -0500
Message-ID: <41DC5F62.9090006@ppp0.net>
Date: Wed, 05 Jan 2005 22:42:58 +0100
From: Jan Dittmer <jdittmer@ppp0.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041124 Thunderbird/0.9 Mnenhy/0.6.0.104
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: mpm@selenic.com
CC: Linux kernel <linux-kernel@vger.kernel.org>
Subject: ketchup patch for 2.6-ac
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------030105070306090803080301"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030105070306090803080301
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi Matt,

attached patch adds support for 2.6-ac releases to ketchup.

Thanks for the nice tool,

Jan

--------------030105070306090803080301
Content-Type: text/plain;
 name="ketchup-ac.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ketchup-ac.patch"

--- ketchup-0.9	2005-01-05 22:14:23.000000000 +0100
+++ ketchup	2005-01-05 22:40:06.000000000 +0100
@@ -219,6 +219,14 @@
     part = last(url)
     return part[:-1]
 
+def latest_ac(url, pat):
+    url = kernel_url + '/people/alan/linux-2.6/'
+    url += last(url)
+    for l in urllib.urlopen(url).readlines():
+        m=re.search('(?i)<a href="patch-(.*)\.bz2">', l)
+        if m: n = m.group(1)
+    return n
+
 def latest_26(url, pat):
     for l in urllib.urlopen(url).readlines():
         m = re.search('"LATEST-IS-(.*)"', l)
@@ -300,6 +308,10 @@
                kernel_url + "/people/akpm/patches/" +
                "%(tree)s/%(prebase)s/%(full)s/%(full)s.bz2", "",
                1, "Andrew Morton's -mm development tree"),
+    '2.6-ac': (latest_ac,
+               kernel_url + "/people/alan/linux-%(tree)s/" +
+               "%(prebase)s/patch-%(full)s.bz2", "",
+               1, "Alan Cox's -ac development tree"),
     '2.6-tiny': (latest_dir,
                  "http://www.selenic.com/tiny/%(full)s.patch.bz2",
                  r'(2.6.*?).patch.bz2',

--------------030105070306090803080301--

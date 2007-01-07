Return-Path: <linux-kernel-owner+w=401wt.eu-S932642AbXAHJJx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932642AbXAHJJx (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 04:09:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932645AbXAHJJx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 04:09:53 -0500
Received: from mx0.karneval.cz ([81.27.192.122]:12158 "EHLO av2.karneval.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932642AbXAHJJv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 04:09:51 -0500
From: Pavel Pisa <pisa@cmp.felk.cvut.cz>
To: Randy Dunlap <rdunlap@xenotime.net>
Subject: [PATCH] DocBook/HTML: correction of recursive A tags in HTML output
Date: Sun, 7 Jan 2007 21:23:07 +0100
User-Agent: KMail/1.9.4
Cc: tali@admingilde.org, linux-kernel@vger.kernel.org,
       Jirka Kosek <jirka@kosek.cz>
References: <200612310227.47721.pisa@cmp.felk.cvut.cz> <20070101164147.3a6da015.rdunlap@xenotime.net> <200701021018.45360.pisa@cmp.felk.cvut.cz>
In-Reply-To: <200701021018.45360.pisa@cmp.felk.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701072123.07741.pisa@cmp.felk.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The malformed HTML was generated after switch to XSLTPROC
from SGML tools. The reference title

  <refentrytitle><phrase id="API-struct-x">struct x</phrase></refentrytitle>

is converted into two recursive <a> tags

  <a href="re02.html"><span><a id="API-struct-x"></a>struct x</span></a>

There is more possible solutions for this problem.
One can be found at

  http://darkk.livejournal.com/

The proposed solution is based on suggestion provided by Jiri Kosek.

Signed-off-by: Pavel Pisa <pisa@cmp.felk.cvut.cz>

---

 scripts/kernel-doc |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

Index: linux-2.6.19/scripts/kernel-doc
===================================================================
--- linux-2.6.19.orig/scripts/kernel-doc
+++ linux-2.6.19/scripts/kernel-doc
@@ -583,14 +583,14 @@ sub output_function_xml(%) {
     $id = "API-".$args{'function'};
     $id =~ s/[^A-Za-z0-9]/-/g;
 
-    print "<refentry>\n";
+    print "<refentry id=\"$id\">\n";
     print "<refentryinfo>\n";
     print " <title>LINUX</title>\n";
     print " <productname>Kernel Hackers Manual</productname>\n";
     print " <date>$man_date</date>\n";
     print "</refentryinfo>\n";
     print "<refmeta>\n";
-    print " <refentrytitle><phrase id=\"$id\">".$args{'function'}."</phrase></refentrytitle>\n";
+    print " <refentrytitle><phrase>".$args{'function'}."</phrase></refentrytitle>\n";
     print " <manvolnum>9</manvolnum>\n";
     print "</refmeta>\n";
     print "<refnamediv>\n";
@@ -659,14 +659,14 @@ sub output_struct_xml(%) {
     $id = "API-struct-".$args{'struct'};
     $id =~ s/[^A-Za-z0-9]/-/g;
 
-    print "<refentry>\n";
+    print "<refentry id=\"$id\">\n";
     print "<refentryinfo>\n";
     print " <title>LINUX</title>\n";
     print " <productname>Kernel Hackers Manual</productname>\n";
     print " <date>$man_date</date>\n";
     print "</refentryinfo>\n";
     print "<refmeta>\n";
-    print " <refentrytitle><phrase id=\"$id\">".$args{'type'}." ".$args{'struct'}."</phrase></refentrytitle>\n";
+    print " <refentrytitle><phrase>".$args{'type'}." ".$args{'struct'}."</phrase></refentrytitle>\n";
     print " <manvolnum>9</manvolnum>\n";
     print "</refmeta>\n";
     print "<refnamediv>\n";
@@ -743,14 +743,14 @@ sub output_enum_xml(%) {
     $id = "API-enum-".$args{'enum'};
     $id =~ s/[^A-Za-z0-9]/-/g;
 
-    print "<refentry>\n";
+    print "<refentry id=\"$id\">\n";
     print "<refentryinfo>\n";
     print " <title>LINUX</title>\n";
     print " <productname>Kernel Hackers Manual</productname>\n";
     print " <date>$man_date</date>\n";
     print "</refentryinfo>\n";
     print "<refmeta>\n";
-    print " <refentrytitle><phrase id=\"$id\">enum ".$args{'enum'}."</phrase></refentrytitle>\n";
+    print " <refentrytitle><phrase>enum ".$args{'enum'}."</phrase></refentrytitle>\n";
     print " <manvolnum>9</manvolnum>\n";
     print "</refmeta>\n";
     print "<refnamediv>\n";
@@ -809,14 +809,14 @@ sub output_typedef_xml(%) {
     $id = "API-typedef-".$args{'typedef'};
     $id =~ s/[^A-Za-z0-9]/-/g;
 
-    print "<refentry>\n";
+    print "<refentry id=\"$id\">\n";
     print "<refentryinfo>\n";
     print " <title>LINUX</title>\n";
     print " <productname>Kernel Hackers Manual</productname>\n";
     print " <date>$man_date</date>\n";
     print "</refentryinfo>\n";
     print "<refmeta>\n";
-    print " <refentrytitle><phrase id=\"$id\">typedef ".$args{'typedef'}."</phrase></refentrytitle>\n";
+    print " <refentrytitle><phrase>typedef ".$args{'typedef'}."</phrase></refentrytitle>\n";
     print " <manvolnum>9</manvolnum>\n";
     print "</refmeta>\n";
     print "<refnamediv>\n";

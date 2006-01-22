Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932321AbWAVEAF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932321AbWAVEAF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 23:00:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932406AbWAVEAF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 23:00:05 -0500
Received: from xenotime.net ([66.160.160.81]:6328 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932321AbWAVEAD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 23:00:03 -0500
Date: Sat, 21 Jan 2006 20:00:09 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: tali@admingilde.org, akpm <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] Doc/kernel-doc: add more usage info
Message-Id: <20060121200009.53ce97c6.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Add info that structs, unions, enums, and typedefs are supported.
Add doc about "private:" and "public:" tags for struct fields.
Fix some typos.
Remove some trailing whitespace.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 Documentation/kernel-doc-nano-HOWTO.txt |   39 +++++++++++++++++++++++++++-----
 scripts/kernel-doc                      |    6 ++--
 2 files changed, 37 insertions(+), 8 deletions(-)

--- linux-2616-rc1-secur.orig/scripts/kernel-doc
+++ linux-2616-rc1-secur/scripts/kernel-doc
@@ -45,7 +45,7 @@ use strict;
 # Note: This only supports 'c'.
 
 # usage:
-# kerneldoc [ -docbook | -html | -text | -man ]
+# kernel-doc [ -docbook | -html | -text | -man ]
 #           [ -function funcname [ -function funcname ...] ] c file(s)s > outputfile
 # or
 #           [ -nofunction funcname [ -function funcname ...] ] c file(s)s > outputfile
@@ -59,7 +59,7 @@ use strict;
 #  -nofunction funcname
 #	If set, then only generate documentation for the other function(s).  All
 #	other functions are ignored. Cannot be used with -function together
-#	(yes thats a bug - perl hackers can fix it 8))
+#	(yes, that's a bug -- perl hackers can fix it 8))
 #
 #  c files - list of 'c' files to process
 #
@@ -434,7 +434,7 @@ sub output_enum_html(%) {
     print "<hr>\n";
 }
 
-# output tyepdef in html
+# output typedef in html
 sub output_typedef_html(%) {
     my %args = %{$_[0]};
     my ($parameter);
--- linux-2616-rc1-secur.orig/Documentation/kernel-doc-nano-HOWTO.txt
+++ linux-2616-rc1-secur/Documentation/kernel-doc-nano-HOWTO.txt
@@ -45,10 +45,10 @@ How to extract the documentation
 
 If you just want to read the ready-made books on the various
 subsystems (see Documentation/DocBook/*.tmpl), just type 'make
-psdocs', or 'make pdfdocs', or 'make htmldocs', depending on your 
-preference.  If you would rather read a different format, you can type 
-'make sgmldocs' and then use DocBook tools to convert 
-Documentation/DocBook/*.sgml to a format of your choice (for example, 
+psdocs', or 'make pdfdocs', or 'make htmldocs', depending on your
+preference.  If you would rather read a different format, you can type
+'make sgmldocs' and then use DocBook tools to convert
+Documentation/DocBook/*.sgml to a format of your choice (for example,
 'db2html ...' if 'make htmldocs' was not defined).
 
 If you want to see man pages instead, you can do this:
@@ -124,6 +124,36 @@ patterns, which are highlighted appropri
 Take a look around the source tree for examples.
 
 
+kernel-doc for structs, unions, enums, and typedefs
+---------------------------------------------------
+
+Beside functions you can also write documentation for structs, unions,
+enums and typedefs. Instead of the function name you must write the name
+of the declaration;  the struct/union/enum/typedef must always precede
+the name. Nesting of declarations is not supported.
+Use the argument mechanism to document members or constants.
+
+Inside a struct description, you can use the "private:" and "public:"
+comment tags.  Structure fields that are inside a "private:" area
+are not listed in the generated output documentation.
+
+Example:
+
+/**
+ * struct my_struct - short description
+ * @a: first member
+ * @b: second member
+ *
+ * Longer description
+ */
+struct my_struct {
+    int a;
+    int b;
+/* private: */
+    int c;
+};
+
+
 How to make new SGML template files
 -----------------------------------
 
@@ -147,4 +177,3 @@ documentation, in <filename>, for the fu
 
 Tim.
 */ <twaugh@redhat.com>
-


---

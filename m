Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264915AbRFZNQ3>; Tue, 26 Jun 2001 09:16:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264920AbRFZNQU>; Tue, 26 Jun 2001 09:16:20 -0400
Received: from mailout02.sul.t-online.com ([194.25.134.17]:28688 "EHLO
	mailout02.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S264915AbRFZNQF>; Tue, 26 Jun 2001 09:16:05 -0400
Message-ID: <3B388B09.1BFD719B@iku-netz.de>
Date: Tue, 26 Jun 2001 15:15:53 +0200
From: Kurt Huwig <kurt@iku-netz.de>
X-Mailer: Mozilla 4.77 [de] (X11; U; Linux 2.4.4-4GB i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: binfmt_misc for executable jar files
Content-Type: multipart/mixed;
 boundary="------------BCE5E190DFCCC588BC244008"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dies ist eine mehrteilige Nachricht im MIME-Format.
--------------BCE5E190DFCCC588BC244008
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hello!

The applied patch updates the documentation of using binfmt_misc to
execute Java applications. It adds support for executable jar files, the
normal packaging for Java applications.

With Windows, you just double-click on the file, so Linux should be able
to run them, too :-)

Kurt

P.S.: I am not subscribed.
-- 
------------------------------------------------------------------------
All these worlds are yours -- except Europa. Attempt no landings there.
--------------BCE5E190DFCCC588BC244008
Content-Type: text/plain; charset=iso-8859-1;
 name="executable-jar-file.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename="executable-jar-file.patch"

--- /usr/src/linux/Documentation/java.txt	Thu Jul  1 19:47:08 1999
+++ linux/Documentation/java.txt	Tue Jun 26 15:08:13 2001
@@ -1,4 +1,4 @@
-               Java(tm) Binary Kernel Support for Linux v1.02
+               Java(tm) Binary Kernel Support for Linux v1.03
                ----------------------------------------------
 
 Linux beats them ALL! While all other OS's are TALKING about direct
@@ -30,6 +30,8 @@
    (you should really have read binfmt_misc.txt now):
    support for Java applications:
      ':Java:M::\xca\xfe\xba\xbe::/usr/local/bin/javawrapper:'
+   support for executable Jar files:
+     ':ExecutableJAR:E::jar::/usr/local/bin/jarwrapper:'
    support for Java Applets:
      ':Applet:E::html::/usr/bin/appletviewer:'
    or the following, if you want to be more selective:
@@ -343,7 +345,15 @@
 ====================== Cut here ===================
 
 
-Now simply chmod +x the .class and/or .html files you want to execute.
+====================== Cut here ===================
+#!/bin/bash
+# /usr/local/java/bin/jarwrapper - the wrapper for binfmt_misc/jar
+
+java -jar $1
+====================== Cut here ===================
+
+
+Now simply chmod +x the .class, .jar and/or .html files you want to execute.
 To add a Java program to your path best put a symbolic link to the main
 .class file into /usr/bin (or another place you like) omitting the .class
 extension. The directory containing the original .class file will be
@@ -369,6 +379,11 @@
 	./HelloWorld.class
 
 
+To execute Java Jar files, simple chmod the *.jar files to include
+the execution bit, then just do
+       ./Application.jar
+
+
 To execute Java Applets, simple chmod the *.html files to include
 the execution bit, then just do
 	./Applet.html
@@ -376,5 +391,6 @@
 
 originally by Brian A. Lantz, brian@lantz.com
 heavily edited for binfmt_misc by Richard Günther
-new scripts by Colin J. Watson <cjw44@cam.ac.uk>.
+new scripts by Colin J. Watson <cjw44@cam.ac.uk>
+added executable Jar file support by Kurt Huwig <kurt@iku-netz.de>
 

--------------BCE5E190DFCCC588BC244008--


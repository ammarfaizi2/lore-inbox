Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261358AbVALUBm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261358AbVALUBm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 15:01:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261331AbVALUAX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 15:00:23 -0500
Received: from adsl-298.mirage.euroweb.hu ([193.226.239.42]:4740 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261355AbVALT4t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 14:56:49 -0500
To: erik@hensema.net
CC: dmitry-z@mail.ru, linux-kernel@vger.kernel.org,
       fuse-devel@lists.sourceforge.net
In-reply-to: <slrncuatr0.ego.erik@bender.home.hensema.net> (message from Erik
	Hensema on Wed, 12 Jan 2005 19:15:44 +0000 (UTC))
Subject: Re: [fuse-devel] Merging?
References: <loom.20041231T155940-548@post.gmane.org> <E1ClQi2-0004BO-00@dorka.pomaz.szeredi.hu> <E1CoisR-0001Hi-00@dorka.pomaz.szeredi.hu> <20050112110109.6a21fae5.akpm@osdl.org> <slrncuatr0.ego.erik@bender.home.hensema.net>
Message-Id: <E1CoobT-0002We-00@localhost>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 12 Jan 2005 20:56:27 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I was using siefs, to mount the fs of my Siemens mobile phone
> (via serial cable). However it doesn't seem to work with the
> current fuse anymore.

The following patch makes it compile with FUSE 2.2-pre3 too.  You need
to run autoreconf after patching.

Not tested, since I don't have a Siemens phone.

Miklos

diff -ru siefs-0.4.orig/configure.in siefs-0.4/configure.in
--- siefs-0.4.orig/configure.in	2004-08-13 08:39:07.000000000 +0200
+++ siefs-0.4/configure.in	2005-01-12 20:40:20.000000000 +0100
@@ -39,14 +39,6 @@
 ])
 fi
 
-if ! grep -q '\(\*release\)' $fuseinst/include/fuse.h ; then
-	AC_MSG_RESULT([old])
-	AC_MSG_ERROR([
-*** You need fuse version 1.0 or later.
-*** Please go to http://sourceforge.net/projects/avf
-*** and download the latest version
-])
-fi
 AC_MSG_RESULT(${fuseinst})
 AC_SUBST(fuseinst)
 
diff -ru siefs-0.4.orig/siefs/Makefile.am siefs-0.4/siefs/Makefile.am
--- siefs-0.4.orig/siefs/Makefile.am	2004-08-13 08:45:30.000000000 +0200
+++ siefs-0.4/siefs/Makefile.am	2005-01-12 20:49:27.000000000 +0100
@@ -1,6 +1,6 @@
 ## Process this file with automake to produce Makefile.in
 
-CFLAGS = -I$(fuseinst)/include
+CFLAGS = -I$(fuseinst)/include -D_FILE_OFFSET_BITS=64 -DFUSE_USE_VERSION=11
 
 bin_PROGRAMS = siefs slink
 


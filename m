Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266212AbUHJNo3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266212AbUHJNo3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 09:44:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266215AbUHJNmw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 09:42:52 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:30399 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S264973AbUHJNlT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 09:41:19 -0400
From: Benno <benjl@cse.unsw.edu.au>
To: Andrew Morton <akpm@osdl.org>
Date: Tue, 10 Aug 2004 23:41:02 +1000
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Use posix headers in sumversion.c
Message-ID: <20040810134102.GA15576@cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="TB36FDmn/VVEgNH/"
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

When compiling Linux on Mac OSX I had trouble with scripts/sumversion.c.
It includes <netinet/in.h> to obtain to definitions of htonl and ntohl.

On Mac OSX these are found in <arpa/inet.h>. After checking the POSIX
specification it appears that this is the correct place to get
the definitons for these functions.

(http://www.opengroup.org/onlinepubs/009695399/functions/htonl.html)

Using this header also appears to work on Linux (at least with
Glibc-2.3.2).

It seems clearer to me to go with the POSIX standard than implementing
#if __APPLE__ style macros, but if such an approach is preferred I can
supply patches for that instead.

A patch against 2.6.7 which change <netinet/in.h> -> <arpa/inet.h> is
attached.

Cheers,

Benno

--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="sumversion.patch"

--- sumversion.c	2004-08-10 23:26:27.000000000 +1000
+++ sumversion.c.orig	2004-08-10 23:26:08.000000000 +1000
@@ -1,4 +1,4 @@
-#include <arpa/inet.h>
+#include <netinet/in.h>
 #include <stdint.h>
 #include <ctype.h>
 #include <errno.h>

--TB36FDmn/VVEgNH/--

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266936AbTADOHP>; Sat, 4 Jan 2003 09:07:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266938AbTADOHP>; Sat, 4 Jan 2003 09:07:15 -0500
Received: from fed1mtao01.cox.net ([68.6.19.244]:26842 "EHLO
	fed1mtao01.cox.net") by vger.kernel.org with ESMTP
	id <S266936AbTADOHO>; Sat, 4 Jan 2003 09:07:14 -0500
From: junkio@cox.net
To: Sam Ravnborg <sam@ravnborg.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Documentation/modules.txt
References: <fa.gg57a2v.1j56o1v@ifi.uio.no>
Date: 04 Jan 2003 06:15:40 -0800
Message-ID: <7v1y3typ9v.fsf@assigned-by-dhcp.cox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "SR" == Sam Ravnborg <sam@ravnborg.org> writes:

SR>  Anyway, your first step is to compile the kernel, as explained in the
SR>  file linux/README.  It generally goes like:
 
SR> -	make config
SR> -	make dep
SR> +	make *config <= usually menuconfig or xconfig
SR>  	make clean
SR>  	make zImage or make zlilo

If that is the case, this message after "make config" must go:

  *** End of Linux kernel configuration.
  *** Check the top-level Makefile for additional configuration.
  *** Next, you must run 'make dep'.

Here is a patch.

diff -u 2.4.20/scripts/Configure 2.4.20/scripts/Configure
--- 2.4.20/scripts/Configure	2001-07-02 13:56:40.000000000 -0700
+++ 2.4.20/scripts/Configure	2003-01-04 06:12:18.000000000 -0800
@@ -575,10 +575,7 @@
 echo
 echo "*** End of Linux kernel configuration."
 echo "*** Check the top-level Makefile for additional configuration."
-if [ ! -f .hdepend -o "$CONFIG_MODVERSIONS" = "y" ] ; then
-    echo "*** Next, you must run 'make dep'."
-else
-    echo "*** Next, you may run 'make bzImage', 'make bzdisk', or 'make install'."
+echo "*** Next, you may run 'make bzImage', 'make bzdisk', or 'make install'."
 fi
 echo

